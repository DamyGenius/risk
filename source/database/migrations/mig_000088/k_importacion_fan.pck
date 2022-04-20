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

  -- Procedimiento de importación de fases/grupos
  PROCEDURE p_importar_fases(i_id_torneo IN t_torneos.id_torneo%TYPE,
                             i_fases     IN CLOB);

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE,
                                i_partidos  IN CLOB);

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE);

  -- Procedimiento de importación de un partido en particular
  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2,
                               i_partido    IN CLOB);

  -- Procedimiento de importación de un partido en particular
  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2);

  -- Procedimiento de creación de escudos de un partido en particular
  PROCEDURE p_guardar_escudos_partido(i_id_partido IN VARCHAR2);

  -- Procedimiento de eliminación de escudos de un partido en particular
  PROCEDURE p_eliminar_escudos_partido(i_id_partido IN VARCHAR2);

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

  FUNCTION lf_id_torneo_partido(i_partido IN NUMBER) RETURN VARCHAR2 IS
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    SELECT * INTO rw_partido FROM t_partidos WHERE id_partido = i_partido;
    RETURN rw_partido.id_torneo;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
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

  PROCEDURE lp_datos_importacion_torneo(i_id_torneo      IN t_torneo_jornadas.id_torneo%TYPE,
                                        o_url_base       OUT VARCHAR2,
                                        o_id_importacion OUT VARCHAR2) IS
  BEGIN
    SELECT b.descripcion url_base, a.id_importacion
      INTO o_url_base, o_id_importacion
      FROM t_torneos a, t_importador_urls b
     WHERE a.id_url = b.id_url(+)
       AND a.id_torneo = i_id_torneo;
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

  PROCEDURE p_importar_fases(i_id_torneo IN t_torneos.id_torneo%TYPE,
                             i_fases     IN CLOB) IS
    l_fases json_array_t;
    l_fase  json_object_t;
    rw_fase t_torneo_fases%ROWTYPE;
  
    l_grupos json_array_t;
    l_grupo  json_object_t;
    rw_grupo t_torneo_grupos%ROWTYPE;
  
    l_partidos json_array_t;
  
    l_id_torneo t_torneos.id_torneo%TYPE;
  BEGIN
    l_id_torneo := i_id_torneo;
  
    l_fases := json_array_t(i_fases);
  
    FOR i IN 0 .. l_fases.get_size - 1 LOOP
      l_fase              := treat(l_fases.get(i) AS json_object_t);
      rw_fase.id_torneo   := l_id_torneo;
      rw_fase.id_fase     := l_fase.get_number('id');
      rw_fase.descripcion := l_fase.get_string('nombreFase');
    
      -- Importa la fase
      BEGIN
        INSERT INTO t_torneo_fases
          (id_torneo, id_fase, descripcion)
        VALUES
          (rw_fase.id_torneo, rw_fase.id_fase, rw_fase.descripcion);
      EXCEPTION
        WHEN dup_val_on_index THEN
          UPDATE t_torneo_fases
             SET descripcion = rw_fase.descripcion
           WHERE id_torneo = rw_fase.id_torneo
             AND id_fase = rw_fase.id_fase
             AND descripcion <> rw_fase.descripcion; -- Sólo si cambia la descripción
      END;
    
      IF l_fase.has('grupos') THEN
        l_grupos := l_fase.get_array('grupos');
      
        FOR j IN 0 .. l_grupos.get_size - 1 LOOP
          l_grupo              := treat(l_grupos.get(j) AS json_object_t);
          rw_grupo.id_torneo   := l_id_torneo;
          rw_grupo.id_fase     := rw_fase.id_fase;
          rw_grupo.id_grupo    := l_grupo.get_number('id');
          rw_grupo.descripcion := l_grupo.get_string('nombreGrupo');
        
          -- Importa el grupo
          BEGIN
            INSERT INTO t_torneo_grupos
              (id_torneo, id_fase, id_grupo, descripcion)
            VALUES
              (rw_grupo.id_torneo,
               rw_grupo.id_fase,
               rw_grupo.id_grupo,
               rw_grupo.descripcion);
          EXCEPTION
            WHEN dup_val_on_index THEN
              UPDATE t_torneo_grupos
                 SET descripcion = rw_grupo.descripcion
               WHERE id_torneo = rw_grupo.id_torneo
                 AND id_fase = rw_grupo.id_fase
                 AND id_grupo = rw_grupo.id_grupo
                 AND descripcion <> rw_grupo.descripcion; -- Sólo si cambia la descripción
          END;
        
          IF l_grupo.has('partidos') THEN
            l_partidos := l_grupo.get_array('partidos');
          
            -- Procesa la lista de partidos
            k_sistema.p_definir_parametro_number('ID_FASE',
                                                 rw_fase.id_fase);
            k_sistema.p_definir_parametro_number('ID_GRUPO',
                                                 rw_grupo.id_grupo);
          
            p_importar_partidos(i_id_torneo => l_id_torneo,
                                i_partidos  => l_partidos.to_clob);
          END IF;
        
        END LOOP;
      
      ELSIF l_fase.has('partidos') THEN
        l_partidos := l_fase.get_array('partidos');
      
        -- Procesa la lista de partidos
        k_sistema.p_definir_parametro_number('ID_FASE', rw_fase.id_fase);
        k_sistema.p_definir_parametro_number('ID_GRUPO', NULL);
      
        p_importar_partidos(i_id_torneo => l_id_torneo,
                            i_partidos  => l_partidos.to_clob);
      
      END IF;
    
    END LOOP;
  END;

  PROCEDURE p_importar_partidos(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE,
                                i_partidos  IN CLOB) IS
    l_partidos  json_array_t;
    l_partido   json_object_t;
    rw_partido  t_partidos%ROWTYPE;
    rw_partido2 t_partidos%ROWTYPE;
  
    l_id_torneo t_torneos.id_torneo%TYPE;
  
    l_dia  VARCHAR2(30);
    l_hora VARCHAR2(30);
  
    l_id_fase  t_partidos.id_fase%TYPE;
    l_id_grupo t_partidos.id_grupo%TYPE;
  BEGIN
    l_id_torneo := i_id_torneo;
    l_id_fase   := k_sistema.f_valor_parametro_number('ID_FASE');
    l_id_grupo  := k_sistema.f_valor_parametro_number('ID_GRUPO');
  
    l_partidos := json_array_t(i_partidos);
  
    FOR i IN 0 .. l_partidos.get_size - 1 LOOP
      l_partido := treat(l_partidos.get(i) AS json_object_t);
    
      rw_partido.id_importacion := l_partido.get_number('id');
      dbms_output.put_line('index: ' || i || ' ' || 'id: ' ||
                           rw_partido.id_importacion);
      rw_partido.id_jornada := l_partido.get_number('numeroFecha');
      IF rw_partido.id_jornada = 0 THEN
        rw_partido.id_jornada := NULL;
      END IF;
    
      rw_partido.id_club_local     := lf_buscar_club(treat(l_partido.get('local') AS json_object_t).get_number('id'));
      rw_partido.id_club_visitante := lf_buscar_club(treat(l_partido.get('visitante') AS json_object_t).get_number('id'));
    
      l_dia  := l_partido.get_string('dia');
      l_hora := l_partido.get_string('hora');
      IF l_dia IS NOT NULL AND l_hora IS NOT NULL THEN
        rw_partido.fecha := to_date(l_dia || ' ' || l_hora,
                                    'DD-MM-YYYY HH24:MI');
      ELSE
        rw_partido.fecha := NULL;
      END IF;
    
      rw_partido.goles_club_local     := l_partido.get_number('golesLocal');
      rw_partido.goles_club_visitante := l_partido.get_number('golesVisitante');
      rw_partido.estado               := l_partido.get_string('estado');
      rw_partido.estado_predicciones  := CASE rw_partido.estado
                                           WHEN 'F' THEN
                                            'L' --Liquidado
                                           ELSE
                                            'P' --Pendiente
                                         END;
    
      IF rw_partido.estado NOT IN ('F', 'S', 'J') THEN
        -- FINALIZADO O SUSPENDIDO
        rw_partido.goles_club_local     := NULL;
        rw_partido.goles_club_visitante := NULL;
      END IF;
    
      rw_partido.descripcion           := l_partido.get_string('etiqueta');
      rw_partido.nombre_club_local     := treat(l_partido.get('local') AS json_object_t).get_string('nombre');
      rw_partido.nombre_club_visitante := treat(l_partido.get('visitante') AS json_object_t).get_string('nombre');
    
      BEGIN
        IF rw_partido.id_jornada IS NOT NULL THEN
          --Inserta la jornada si no existe
          BEGIN
            INSERT INTO t_torneo_jornadas
              (id_torneo, id_jornada)
            VALUES
              (l_id_torneo, rw_partido.id_jornada);
          EXCEPTION
            WHEN dup_val_on_index THEN
              NULL;
          END;
        END IF;
      
        IF rw_partido.id_club_local IS NOT NULL THEN
          --Inserta el plantel local si no existe
          BEGIN
            INSERT INTO t_planteles
              (id_torneo, id_club)
            VALUES
              (l_id_torneo, rw_partido.id_club_local);
          EXCEPTION
            WHEN dup_val_on_index THEN
              NULL;
          END;
        END IF;
      
        IF rw_partido.id_club_visitante IS NOT NULL THEN
          --Inserta el plantel visitante si no existe
          BEGIN
            INSERT INTO t_planteles
              (id_torneo, id_club)
            VALUES
              (l_id_torneo, rw_partido.id_club_visitante);
          EXCEPTION
            WHEN dup_val_on_index THEN
              NULL;
          END;
        END IF;
      
        rw_partido2 := lf_buscar_partido(rw_partido.id_importacion);
        IF rw_partido2.id_partido IS NOT NULL THEN
          --Acutualiza si no fue Programado Manualmente y no fue Finalizado
          IF NOT (rw_partido2.estado = 'M' AND rw_partido.estado = 'R') AND
             NOT (rw_partido2.estado = 'F') THEN
            UPDATE t_partidos p
               SET id_torneo             = l_id_torneo,
                   id_club_local         = rw_partido.id_club_local,
                   id_club_visitante     = rw_partido.id_club_visitante,
                   fecha                 = rw_partido.fecha,
                   hora                  = to_char(rw_partido.fecha,
                                                   'HH24:MI'),
                   id_jornada            = rw_partido.id_jornada,
                   id_estadio            = rw_partido.id_estadio,
                   goles_club_local      = rw_partido.goles_club_local,
                   goles_club_visitante  = rw_partido.goles_club_visitante,
                   estado                = rw_partido.estado,
                   estado_predicciones   = rw_partido.estado_predicciones,
                   id_importacion        = rw_partido.id_importacion,
                   id_fase               = l_id_fase,
                   id_grupo              = l_id_grupo,
                   descripcion           = rw_partido.descripcion,
                   nombre_club_local     = rw_partido.nombre_club_local,
                   nombre_club_visitante = rw_partido.nombre_club_visitante
             WHERE p.id_partido = rw_partido2.id_partido;
          END IF;
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
             id_importacion,
             id_fase,
             id_grupo,
             descripcion,
             nombre_club_local,
             nombre_club_visitante)
          VALUES
            (l_id_torneo,
             rw_partido.id_club_local,
             rw_partido.id_club_visitante,
             rw_partido.fecha,
             to_char(rw_partido.fecha, 'HH24:MI'),
             rw_partido.id_jornada,
             rw_partido.id_estadio,
             rw_partido.goles_club_local,
             rw_partido.goles_club_visitante,
             rw_partido.estado,
             rw_partido.estado_predicciones,
             rw_partido.id_importacion,
             l_id_fase,
             l_id_grupo,
             rw_partido.descripcion,
             rw_partido.nombre_club_local,
             rw_partido.nombre_club_visitante)
          RETURNING id_partido INTO rw_partido2.id_partido;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          dbms_output.put_line(rw_partido.id_importacion || ': ' ||
                               SQLERRM);
          raise_application_error(-20000,
                                  rw_partido.id_importacion || ': ' ||
                                  SQLERRM);
      END;
    
    END LOOP;
  END;

  PROCEDURE p_importar_partidos(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE) IS
    l_ok    VARCHAR2(1);
    l_datos CLOB;
    --
    l_url_base       t_importador_urls.descripcion%TYPE;
    l_id_importacion t_torneos.id_importacion%TYPE;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_estado_importacion_partidos = 'E' THEN
      RETURN;
    ELSE
      lp_actualizar_importacion_partido('E');
    END IF;
  
    -- obtenemos datos de importacion del torneo
    lp_datos_importacion_torneo(i_id_torneo      => i_id_torneo,
                                o_url_base       => l_url_base,
                                o_id_importacion => l_id_importacion);
  
    IF l_url_base IS NOT NULL AND l_id_importacion IS NOT NULL THEN
      -- obtenemos los datos a través del WS
      k_datos_fan.p_fixture(i_url_base       => l_url_base,
                            i_id_importacion => l_id_importacion,
                            o_ok             => l_ok,
                            o_response       => l_datos);
    
      -- actualizamos la cabecera de los partidos
      IF l_ok = 'S' THEN
        /*
        p_importar_partidos(i_id_torneo => i_id_torneo,
                            i_partidos  => l_datos);
        */
        p_importar_fases(i_id_torneo => i_id_torneo, i_fases => l_datos);
      ELSE
        $if k_modulo.c_instalado_msj $then
        -- Envía correo de error inesperado
        IF k_mensajeria.f_enviar_correo(i_subject         => 'Error en k_datos_fan.p_partido',
                                        i_body            => l_datos,
                                        i_to              => 'damian.meza.py@gmail.com, javier.meza.py@gmail.com', --TODO: Dinamizar
                                        i_prioridad_envio => k_mensajeria.c_prioridad_importante) <>
           k_mensajeria.c_ok THEN
          dbms_output.put_line('Error al enviar correo de error en k_datos_fan.p_fixture.');
        END IF;
        $end
        raise_application_error(-20501,
                                'Error en k_datos_fan.p_fixture: ' ||
                                l_datos);
      END IF;
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
    l_estado_juego         t_partidos.estado_juego%TYPE;
    l_estado_juego_antes   t_partidos.estado_juego%TYPE;
    l_id_division          t_divisiones.id_division%TYPE;
    --
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    dbms_output.put_line(i_partido);
    l_partido := json_object_t(i_partido);
    l_partido := l_partido.get_object('partido');
  
    l_id := l_partido.get_number('id');
    --dbms_output.put_line('id:' || l_id);
  
    l_goleslocal     := l_partido.get_number('golesLocal');
    l_golesvisitante := l_partido.get_number('golesVisitante');
    l_estado         := l_partido.get_string('estado');
    l_estado_juego   := l_partido.get_string('estadoDeJuego'); -- PT, ET, ST
    --tiempoDeJuego : string : 49:28
    /*dbms_output.put_line('tiempoDeJuego: ' ||
    l_partido.get_string('tiempoDeJuego'));*/
  
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
          SELECT t.id_division,
                 k_util.f_formatear_titulo(l.nombre_corto) club_local,
                 k_util.f_formatear_titulo(v.nombre_corto) club_visitante,
                 p.goles_club_local,
                 p.goles_club_visitante,
                 p.estado_juego
            INTO l_id_division,
                 l_club_local,
                 l_club_visitante,
                 l_goleslocal_antes,
                 l_golesvisitante_antes,
                 l_estado_juego_antes
            FROM t_partidos p, t_clubes l, t_clubes v, t_torneos t
           WHERE p.id_partido = rw_partido.id_partido
             AND p.id_club_local = l.id_club
             AND p.id_club_visitante = v.id_club
             AND p.id_torneo = t.id_torneo;
        EXCEPTION
          WHEN OTHERS THEN
            l_club_local     := NULL;
            l_club_visitante := NULL;
        END;
      
        --Acutualiza si no fue Finalizado        
        IF NOT (rw_partido.estado = 'F') THEN
          UPDATE t_partidos p
             SET goles_club_local     = l_goleslocal,
                 goles_club_visitante = l_golesvisitante,
                 estado               = l_estado,
                 estado_juego         = l_estado_juego
           WHERE p.id_partido = rw_partido.id_partido;
        END IF;
      
        $if k_modulo.c_instalado_msj $then
        -- Notifica la actualización en el resultado del partido en juego de forma silenciosa
        IF l_estado = 'J' AND l_club_local IS NOT NULL AND
           l_club_visitante IS NOT NULL THEN
          -- EN JUEGO
          IF (nvl(l_goleslocal_antes, -1) <> nvl(l_goleslocal, -1)) OR
             (nvl(l_golesvisitante_antes, -1) <> nvl(l_golesvisitante, -1)) OR
             (nvl(l_estado_juego_antes, 'X') <> nvl(l_estado_juego, 'X')) THEN
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
              l_json_object.put('dato1', rw_partido.id_club_local);
              l_json_object.put('dato2', rw_partido.id_club_visitante);
            
              l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local ||
                                                                              ' vs. ' ||
                                                                              l_club_visitante,
                                                             i_contenido   => l_mensaje || ': ' ||
                                                                              l_goleslocal || '-' ||
                                                                              l_golesvisitante || '.',
                                                             i_datos_extra => l_json_object.to_clob,
                                                             i_suscripcion => 'ESPECIAL_EXTRAS' || '&&' || --TODO: convertir a constante
                                                                              k_dispositivo.f_suscripcion_division(l_id_division));
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
    --
    l_url_base       t_importador_urls.descripcion%TYPE;
    l_id_importacion t_torneos.id_importacion%TYPE;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_estado_importacion_partidos = 'E' THEN
      RETURN;
    ELSE
      lp_actualizar_importacion_partido('E');
    END IF;
  
    -- obtenemos datos de importacion del torneo
    lp_datos_importacion_torneo(i_id_torneo      => lf_id_torneo_partido(i_id_partido),
                                o_url_base       => l_url_base,
                                o_id_importacion => l_id_importacion);
  
    -- obtenemos los datos a través del WS
    k_datos_fan.p_partido(i_url_base       => l_url_base,
                          i_id_importacion => l_id_importacion,
                          i_partido        => lf_id_importacion_partido(i_id_partido),
                          o_ok             => l_ok,
                          o_response       => l_datos);
  
    -- actualizamos la cabecera de los partidos
    IF l_ok = 'S' THEN
      p_importar_partido(i_id_partido => NULL, i_partido => l_datos);
    ELSE
      $if k_modulo.c_instalado_msj $then
      -- Envía correo de error inesperado
      IF k_mensajeria.f_enviar_correo(i_subject         => 'Error en k_datos_fan.p_partido',
                                      i_body            => l_datos,
                                      i_to              => 'damian.meza.py@gmail.com, javier.meza.py@gmail.com', --TODO: Dinamizar
                                      i_prioridad_envio => k_mensajeria.c_prioridad_importante) <>
         k_mensajeria.c_ok THEN
        dbms_output.put_line('Error al enviar correo de error en k_datos_fan.p_partido.');
      END IF;
      $end
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

  PROCEDURE p_guardar_escudos_partido(i_id_partido IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  
    CURSOR c_clubes(i_id_partido IN VARCHAR2) IS
      SELECT p.id_club_local, p.id_club_visitante
        FROM t_partidos p
       WHERE p.id_partido = i_id_partido;
  BEGIN
  
    FOR c IN c_clubes(i_id_partido) LOOP
      DECLARE
        l_archivo   y_archivo;
        l_ok        VARCHAR2(1);
        l_resultado CLOB;
        --
        l_escudo_local     CLOB;
        l_escudo_visitante CLOB;
      BEGIN
        -- ***** ESCUDO CLUB LOCAL *****
        -- Recupera el archivo
        l_archivo := k_archivo.f_recuperar_archivo('T_CLUBES',
                                                   'ESCUDO',
                                                   c.id_club_local,
                                                   NULL);
      
        -- Codifica en formato Base64
        l_escudo_local := k_util.base64encode(l_archivo.contenido);
        -- Elimina caracteres de nueva línea
        l_escudo_local := REPLACE(l_escudo_local, utl_tcp.crlf);
      
        -- ***** ESCUDO CLUB VISITANTE *****
        -- Recupera el archivo
        l_archivo := k_archivo.f_recuperar_archivo('T_CLUBES',
                                                   'ESCUDO',
                                                   c.id_club_visitante,
                                                   NULL);
      
        -- Codifica en formato Base64
        l_escudo_visitante := k_util.base64encode(l_archivo.contenido);
        -- Elimina caracteres de nueva línea
        l_escudo_visitante := REPLACE(l_escudo_visitante, utl_tcp.crlf);
      
        -- Combina las imagenes
        k_imagenes_fan.p_combinar_imagenes(i_imagen_base      => l_escudo_visitante,
                                           i_imagen_cobertura => l_escudo_local,
                                           o_ok               => l_ok,
                                           o_response         => l_resultado);
        IF l_ok = 'S' THEN
          --Guardar imagen
          DECLARE
            i_archivo y_archivo := y_archivo();
          BEGIN
            i_archivo.nombre    := 'escudos';
            i_archivo.extension := 'png';
            i_archivo.url       := '';
            i_archivo.contenido := k_util.base64decode(l_resultado);
          
            k_archivo.p_guardar_archivo(i_tabla      => 'T_PARTIDOS',
                                        i_campo      => 'ESCUDOS',
                                        i_referencia => to_char(i_id_partido),
                                        i_archivo    => i_archivo);
          END;
        
        ELSE
          --TODO: Manejar error inesperado
          dbms_output.put_line('Error: ' || l_resultado);
        END IF;
      
      END;
    END LOOP;
  
    COMMIT;
  END;

  PROCEDURE p_eliminar_escudos_partido(i_id_partido IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    DELETE t_archivos a
     WHERE a.tabla = 'T_PARTIDOS'
       AND a.campo = 'ESCUDOS'
       AND a.referencia = to_char(i_id_partido);
    COMMIT;
  END;

BEGIN
  -- Initialization
  dbms_output.enable(1000000);
END;
/
