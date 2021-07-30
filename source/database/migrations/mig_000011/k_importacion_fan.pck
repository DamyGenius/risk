CREATE OR REPLACE PACKAGE k_importacion_fan IS

  /**
  Agrupa operaciones relacionadas con la importacion de datos de Fantasy.
  
  %author dmezac 31/08/2020 21:28:59
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2020 dmezac
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  g_salida CLOB := ''; -- Salida del output

  -- Función que retorna el estado de la importación de partidos
  -- E-En Ejecución/D-Detenido
  FUNCTION f_estado_importacion_partidos RETURN VARCHAR2;

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos(i_partidos IN CLOB);

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos;

  -- Procedimiento de importación de un partido en particular
  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2,
                               i_partido    IN CLOB);

  -- Procedimiento de importación de un partido en particular
  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2);

END;
/
CREATE OR REPLACE PACKAGE BODY k_importacion_fan IS

  -- Procedimiento interno para actualizar parámetros de forma autónoma
  PROCEDURE lp_actualizar_valor_parametro(i_id_parametro IN VARCHAR2,
                                          i_valor        IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    k_util.p_actualizar_valor_parametro(i_id_parametro, i_valor);
    COMMIT;
  END;

  -- Procedimiento interno para actualizar estado de importación de partidos
  PROCEDURE lp_actualizar_importacion_partido(i_valor IN VARCHAR2) IS
  BEGIN
    lp_actualizar_valor_parametro('ESTADO_IMPORTACION_PARTIDOS', i_valor);
  END;

  FUNCTION lf_id_importacion_partido(i_partido IN NUMBER) RETURN NUMBER IS
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    SELECT * INTO rw_partido FROM t_partidos WHERE id_partido = i_partido;
    RETURN rw_partido.id_importacion;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION lf_buscar_partido(i_id_importacion IN NUMBER)
    RETURN t_partidos%ROWTYPE IS
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    SELECT *
      INTO rw_partido
      FROM t_partidos
     WHERE id_importacion = i_id_importacion;
    RETURN rw_partido;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION lf_buscar_club(i_id_importacion IN NUMBER) RETURN VARCHAR2 IS
    l_id_club t_clubes.id_club%TYPE;
  BEGIN
    SELECT id_club
      INTO l_id_club
      FROM t_clubes
     WHERE id_importacion = i_id_importacion;
    RETURN l_id_club;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION f_estado_importacion_partidos RETURN VARCHAR2 IS
  BEGIN
    RETURN k_util.f_valor_parametro('ESTADO_IMPORTACION_PARTIDOS');
  END;

  PROCEDURE p_importar_partidos(i_partidos IN CLOB) IS
    l_partidos json_array_t;
    l_partido  json_object_t;
  
    l_id                  t_partidos.id_importacion%TYPE;
    l_id_torneo           t_torneos.id_torneo%TYPE;
    l_numerofecha         t_partidos.id_jornada%TYPE;
    l_id_club_local       t_partidos.id_club_local%TYPE;
    l_id_club_visitante   t_partidos.id_club_visitante%TYPE;
    l_dia                 VARCHAR2(30);
    l_hora                VARCHAR2(30);
    l_fecha_partido       DATE;
    l_goleslocal          t_partidos.goles_club_local%TYPE;
    l_golesvisitante      t_partidos.goles_club_visitante%TYPE;
    l_estado              t_partidos.estado%TYPE;
    l_estado_predicciones t_partidos.estado_predicciones%TYPE;
    --
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    l_id_torneo := k_sistema.f_valor_parametro_string(k_sistema.c_torneo);
  
    l_partidos := json_array_t(i_partidos);
  
    FOR i IN 0 .. l_partidos.get_size - 1 LOOP
      l_partido := treat(l_partidos.get(i) AS json_object_t);
    
      l_id := l_partido.get_number('id');
      dbms_output.put_line('index : ' || i || ' ' || 'id:' || l_id);
      l_numerofecha       := l_partido.get_number('numeroFecha');
      l_id_club_local     := lf_buscar_club(treat(l_partido.get('local') AS json_object_t)
                                            .get_number('id'));
      l_id_club_visitante := lf_buscar_club(treat(l_partido.get('visitante') AS json_object_t)
                                            .get_number('id'));
    
      l_dia  := l_partido.get_string('dia');
      l_hora := l_partido.get_string('hora');
      IF l_dia IS NOT NULL AND l_hora IS NOT NULL THEN
        l_fecha_partido := to_date(l_dia || ' ' || l_hora,
                                   'DD-MM-YYYY HH24:MI');
      ELSE
        l_fecha_partido := NULL;
      END IF;
    
      l_goleslocal          := l_partido.get_number('golesLocal');
      l_golesvisitante      := l_partido.get_number('golesVisitante');
      l_estado              := l_partido.get_string('estado');
      l_estado_predicciones := CASE l_estado
                                 WHEN 'F' THEN
                                  'L' --Liquidado
                                 ELSE
                                  'P' --Pendiente
                               END;
    
      IF l_estado NOT IN ('F', 'S', 'J') THEN
        -- FINALIZADO O SUSPENDIDO
        l_goleslocal     := NULL;
        l_golesvisitante := NULL;
      END IF;
    
      BEGIN
        rw_partido := lf_buscar_partido(l_id);
        IF rw_partido.id_partido IS NOT NULL THEN
          UPDATE t_partidos p
             SET id_torneo            = l_id_torneo,
                 id_club_local        = l_id_club_local,
                 id_club_visitante    = l_id_club_visitante,
                 fecha                = l_fecha_partido,
                 hora                 = to_char(l_fecha_partido, 'HH24:MI'),
                 id_jornada           = l_numerofecha,
                 id_estadio           = NULL,
                 goles_club_local     = l_goleslocal,
                 goles_club_visitante = l_golesvisitante,
                 estado               = l_estado,
                 id_importacion       = l_id
           WHERE p.id_partido = rw_partido.id_partido;
        ELSE
          INSERT INTO t_partidos
            (id_torneo,
             id_club_local,
             id_club_visitante,
             fecha,
             hora,
             id_jornada,
             id_estadio,
             goles_club_local,
             goles_club_visitante,
             estado,
             estado_predicciones,
             id_importacion)
          VALUES
            (l_id_torneo,
             l_id_club_local,
             l_id_club_visitante,
             l_fecha_partido,
             to_char(l_fecha_partido, 'HH24:MI'),
             l_numerofecha,
             NULL,
             l_goleslocal,
             l_golesvisitante,
             l_estado,
             l_estado_predicciones,
             l_id)
          RETURNING id_partido INTO rw_partido.id_partido;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          dbms_output.put_line(l_id || ':' || SQLERRM);
          raise_application_error(-20000, l_id || ':' || SQLERRM);
      END;
    
    END LOOP;
  END;

  PROCEDURE p_importar_partidos IS
    l_ok    VARCHAR2(1);
    l_datos CLOB;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_estado_importacion_partidos = 'E' THEN
      RETURN;
    ELSE
      lp_actualizar_importacion_partido('E');
    END IF;
  
    -- obtenemos los datos a través del WS
    k_datos_fan.p_fixture(o_ok => l_ok, o_response => l_datos);
  
    -- actualizamos la cabecera de los partidos
    IF l_ok = 'S' THEN
      p_importar_partidos(i_partidos => l_datos);
    ELSE
      raise_application_error(-20501,
                              'Error en k_datos_fan.p_fixture: ' || l_datos);
    END IF;
    COMMIT;
    lp_actualizar_importacion_partido('D');
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      lp_actualizar_importacion_partido('D');
      raise_application_error(-20502, SQLERRM);
  END;

  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2,
                               i_partido    IN CLOB) IS
    l_partido json_object_t;
  
    l_id                   t_partidos.id_importacion%TYPE;
    l_goleslocal           t_partidos.goles_club_local%TYPE;
    l_golesvisitante       t_partidos.goles_club_visitante%TYPE;
    l_goleslocal_antes     t_partidos.goles_club_local%TYPE;
    l_golesvisitante_antes t_partidos.goles_club_visitante%TYPE;
    l_club_local           t_clubes.nombre_corto%TYPE;
    l_club_visitante       t_clubes.nombre_corto%TYPE;
    l_estado               t_partidos.estado%TYPE;
    l_estado_juego         VARCHAR2(2);
    --
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    l_partido := json_object_t(i_partido);
    l_partido := l_partido.get_object('partido');
  
    l_id := l_partido.get_number('id');
    dbms_output.put_line('id:' || l_id);
  
    l_goleslocal     := l_partido.get_number('golesLocal');
    l_golesvisitante := l_partido.get_number('golesVisitante');
    l_estado         := l_partido.get_string('estado');
    l_estado_juego   := l_partido.get_string('estadoDeJuego'); -- PT, ET, ST
    --tiempoDeJuego : string : 49:28
    dbms_output.put_line('tiempoDeJuego: ' ||
                         l_partido.get_string('tiempoDeJuego'));
  
    IF l_estado NOT IN ('F', 'S', 'J') THEN
      -- FINALIZADO O SUSPENDIDO
      l_goleslocal     := NULL;
      l_golesvisitante := NULL;
    END IF;
  
    BEGIN
      rw_partido := lf_buscar_partido(l_id);
      IF rw_partido.id_partido IS NOT NULL AND
         (rw_partido.id_partido = i_id_partido OR i_id_partido IS NULL) THEN
        -- Obtiene datos del partido
        BEGIN
          SELECT k_util.f_formatear_titulo(l.nombre_corto) club_local,
                 k_util.f_formatear_titulo(v.nombre_corto) club_visitante,
                 p.goles_club_local,
                 p.goles_club_visitante
            INTO l_club_local,
                 l_club_visitante,
                 l_goleslocal_antes,
                 l_golesvisitante_antes
            FROM t_partidos p, t_clubes l, t_clubes v
           WHERE p.id_partido = rw_partido.id_partido
             AND p.id_club_local = l.id_club
             AND p.id_club_visitante = v.id_club;
        EXCEPTION
          WHEN OTHERS THEN
            l_club_local     := NULL;
            l_club_visitante := NULL;
        END;
      
        -- Actualiza  resultado y estado del partido
        UPDATE t_partidos p
           SET goles_club_local     = l_goleslocal,
               goles_club_visitante = l_golesvisitante,
               estado               = l_estado
         WHERE p.id_partido = rw_partido.id_partido;
      
        $if k_modulo.c_instalado_msj $then
        -- Notifica la actualización en el resultado del partido en juego de forma silenciosa
        IF l_estado = 'J' AND l_club_local IS NOT NULL AND
           l_club_visitante IS NOT NULL THEN
          -- EN JUEGO
          IF (nvl(l_goleslocal_antes, -1) <> nvl(l_goleslocal, -1)) OR
             (nvl(l_golesvisitante_antes, -1) <> nvl(l_golesvisitante, -1)) THEN
            DECLARE
              l_json_object json_object_t;
              l_result      PLS_INTEGER;
              --
              l_mensaje VARCHAR2(25) := 'Partido en Juego';
            BEGIN
              IF l_estado_juego = 'PT' THEN
                l_mensaje := '1T en Juego';
              ELSIF l_estado_juego = 'ET' THEN
                l_mensaje := 'Entretiempo';
              ELSIF l_estado_juego = 'ST' THEN
                l_mensaje := '2T en Juego';
              END IF;
            
              l_json_object := NEW json_object_t();
              l_json_object.put('tipo', 'PARTIDO'); --TODO: convertir a constante
              l_json_object.put('identificador', rw_partido.id_partido);
              l_json_object.put('unaAlerta', 'S'); -- alerta silenciosa
            
              l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local ||
                                                                              ' vs. ' ||
                                                                              l_club_visitante,
                                                             i_contenido   => l_mensaje || ': ' ||
                                                                              l_goleslocal || '-' ||
                                                                              l_golesvisitante || '.',
                                                             i_datos_extra => l_json_object.to_clob,
                                                             i_suscripcion => 'ESPECIAL' || '&&' || --TODO: convertir a constante
                                                                              'default');
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
          END IF;
        END IF;
        $end
      ELSE
        raise_application_error(-20000,
                                l_id || ':' || 'Partido no encontrado.');
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line(l_id || ':' || SQLERRM);
        raise_application_error(-20000, l_id || ':' || SQLERRM);
    END;
  
  END;

  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2) IS
    l_ok    VARCHAR2(1);
    l_datos CLOB;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_estado_importacion_partidos = 'E' THEN
      RETURN;
    ELSE
      lp_actualizar_importacion_partido('E');
    END IF;
  
    -- obtenemos los datos a través del WS
    k_datos_fan.p_partido(i_partido  => lf_id_importacion_partido(i_id_partido),
                          o_ok       => l_ok,
                          o_response => l_datos);
  
    -- actualizamos la cabecera de los partidos
    IF l_ok = 'S' THEN
      p_importar_partido(i_id_partido => NULL, i_partido => l_datos);
    ELSE
      raise_application_error(-20501,
                              'Error en k_datos_fan.p_partido: ' || l_datos);
    END IF;
    COMMIT;
    lp_actualizar_importacion_partido('D');
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      lp_actualizar_importacion_partido('D');
      raise_application_error(-20502, SQLERRM);
  END;

BEGIN
  -- Initialization
  dbms_output.enable(1000000);
END;
/
