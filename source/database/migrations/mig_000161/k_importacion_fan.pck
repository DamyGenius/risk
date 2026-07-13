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

  -- Función para llavear estado de importación de partidos
  -- S--Llaveado correctamente/N-No se pudo llavear
  FUNCTION f_llavear_importacion_partido RETURN VARCHAR2;

  -- Función que retorna el estado de la importación de partidos
  -- E-En Ejecución/D-Detenido
  FUNCTION f_estado_importacion_partidos RETURN VARCHAR2;

  -- Procedimiento de importación de fases/grupos
  PROCEDURE p_importar_fases(i_id_torneo IN t_torneos.id_torneo%TYPE,
                             i_fases     IN CLOB);

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos(i_id_torneo    IN t_torneo_jornadas.id_torneo%TYPE,
                                i_partidos     IN CLOB,
                                i_zona_horaria IN VARCHAR2 := NULL);

  -- Procedimiento de importación de partidos
  PROCEDURE p_importar_partidos(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE);

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
    --PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    k_util.p_actualizar_valor_parametro(i_id_parametro, i_valor);
    --COMMIT;
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

  PROCEDURE lp_datos_importacion_torneo(i_id_torneo            IN t_torneo_jornadas.id_torneo%TYPE,
                                        o_url_base             OUT VARCHAR2,
                                        o_canal_importacion    OUT VARCHAR2,
                                        o_incluir_alineaciones OUT VARCHAR2,
                                        o_incluir_incidencias  OUT VARCHAR2) IS
  BEGIN
    SELECT b.descripcion url_base,
           d.canal_importacion,
           a.incluir_alineaciones,
           a.incluir_incidencias
      INTO o_url_base,
           o_canal_importacion,
           o_incluir_alineaciones,
           o_incluir_incidencias
      FROM t_torneos a, t_divisiones d, t_importador_urls b
     WHERE a.id_division = d.id_division
       AND d.id_url = b.id_url(+)
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

  FUNCTION f_llavear_importacion_partido RETURN VARCHAR2 IS
  BEGIN
    RETURN k_util.f_llavear_parametro('ESTADO_IMPORTACION_PARTIDOS');
  END;

  FUNCTION f_estado_importacion_partidos RETURN VARCHAR2 IS
  BEGIN
    RETURN k_util.f_valor_parametro('ESTADO_IMPORTACION_PARTIDOS');
  END;

  PROCEDURE p_importar_fases(i_id_torneo IN t_torneos.id_torneo%TYPE,
                             i_fases     IN CLOB) IS
    l_torneo json_object_t;
  
    l_fases json_array_t;
    l_fase  json_object_t;
    rw_fase t_torneo_fases%ROWTYPE;
  
    l_grupos json_array_t;
    l_grupo  json_object_t;
    rw_grupo t_torneo_grupos%ROWTYPE;
  
    l_partidos json_array_t;
  
    l_id_torneo               t_torneos.id_torneo%TYPE;
    l_id_division             t_torneos.id_division%TYPE;
    l_id_importacion          t_torneos.id_importacion%TYPE;
    l_desc_importacion        t_torneos.desc_importacion%TYPE;
    l_id_importacion_torneo   t_torneos.id_importacion%TYPE;
    l_desc_importacion_torneo t_torneos.desc_importacion%TYPE;
    l_zona_horaria            VARCHAR2(50);
  BEGIN
    l_id_torneo := i_id_torneo;
    BEGIN
      SELECT t.id_division, t.id_importacion, t.desc_importacion
        INTO l_id_division, l_id_importacion, l_desc_importacion
        FROM t_torneos t
       WHERE t.id_torneo = l_id_torneo;
    END;
  
    l_torneo                  := json_object_t(i_fases);
    l_id_importacion_torneo   := l_torneo.get_string('idTorneo');
    l_desc_importacion_torneo := l_torneo.get_string('nombreTorneo');
    l_zona_horaria            := nvl(l_torneo.get_string('zonaHoraria'),
                                     k_util.f_valor_parametro('ZONA_HORARIA'));
    dbms_output.put_line('idTorneo: ' || l_id_torneo);
    dbms_output.put_line('zonaHoraria: ' || l_zona_horaria);
  
    BEGIN
      UPDATE t_divisiones a
         SET a.id_importacion_torneo   = l_id_importacion_torneo,
             a.desc_importacion_torneo = l_desc_importacion_torneo
       WHERE a.id_division = l_id_division;
    END;
  
    IF nvl(l_id_importacion_torneo, 0) != nvl(l_id_importacion, 0) OR
       nvl(l_desc_importacion_torneo, 'X') != nvl(l_desc_importacion, 'X') THEN
      dbms_output.put_line(l_id_importacion || ' - ' || l_desc_importacion ||
                           ': Ya no es el torneo actual.');
      RETURN;
    END IF;
  
    IF l_torneo.has('fases') THEN
      l_fases := l_torneo.get_array('fases');
    
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
            
              p_importar_partidos(i_id_torneo    => l_id_torneo,
                                  i_partidos     => l_partidos.to_clob,
                                  i_zona_horaria => l_zona_horaria);
            END IF;
          
          END LOOP;
        
        ELSIF l_fase.has('partidos') THEN
          l_partidos := l_fase.get_array('partidos');
        
          -- Procesa la lista de partidos
          k_sistema.p_definir_parametro_number('ID_FASE', rw_fase.id_fase);
          k_sistema.p_definir_parametro_number('ID_GRUPO', NULL);
        
          p_importar_partidos(i_id_torneo    => l_id_torneo,
                              i_partidos     => l_partidos.to_clob,
                              i_zona_horaria => l_zona_horaria);
        
        END IF;
      
      END LOOP;
    
    END IF;
  
    BEGIN
      UPDATE t_torneos a
         SET a.fecha_ultima_importacion = current_timestamp
       WHERE a.id_torneo = l_id_torneo;
    END;
  END;

  PROCEDURE p_importar_partidos(i_id_torneo    IN t_torneo_jornadas.id_torneo%TYPE,
                                i_partidos     IN CLOB,
                                i_zona_horaria IN VARCHAR2 := NULL) IS
    l_partidos  json_array_t;
    l_partido   json_object_t;
    rw_partido  t_partidos%ROWTYPE;
    rw_partido2 t_partidos%ROWTYPE;
  
    l_id_club_local_tmp     PLS_INTEGER;
    l_id_club_visitante_tmp PLS_INTEGER;
  
    l_id_torneo    t_torneos.id_torneo%TYPE;
    l_id_division  t_divisiones.id_division%TYPE;
    l_id_pais      t_divisiones.id_pais%TYPE;
    l_tipo_equipos t_divisiones.tipo_equipos%TYPE;
    l_zona_horaria VARCHAR2(50);
  
    l_dia  VARCHAR2(30);
    l_hora VARCHAR2(30);
  
    l_id_fase  t_partidos.id_fase%TYPE;
    l_id_grupo t_partidos.id_grupo%TYPE;
  BEGIN
    l_zona_horaria := nvl(i_zona_horaria,
                          k_util.f_valor_parametro('ZONA_HORARIA'));
  
    l_id_torneo := i_id_torneo;
    BEGIN
      SELECT x.id_division, y.id_pais, y.tipo_equipos
        INTO l_id_division, l_id_pais, l_tipo_equipos
        FROM t_torneos x, t_divisiones y
       WHERE x.id_division = y.id_division
         AND x.id_torneo = l_id_torneo;
    
    END;
    l_id_fase  := k_sistema.f_valor_parametro_number('ID_FASE');
    l_id_grupo := k_sistema.f_valor_parametro_number('ID_GRUPO');
  
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
    
      l_id_club_local_tmp     := treat(l_partido.get('local') AS json_object_t).get_number('id');
      l_id_club_visitante_tmp := treat(l_partido.get('visitante') AS json_object_t).get_number('id');
    
      rw_partido.id_club_local     := lf_buscar_club(l_id_club_local_tmp);
      rw_partido.id_club_visitante := lf_buscar_club(l_id_club_visitante_tmp);
    
      l_dia  := l_partido.get_string('dia');
      l_hora := l_partido.get_string('hora');
      IF l_dia IS NOT NULL AND l_hora IS NOT NULL THEN
        rw_partido.fecha := to_timestamp_tz(l_dia || ' ' || l_hora || ' ' ||
                                            l_zona_horaria,
                                            'DD-MM-YYYY HH24:MI TZR');
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
    
      IF rw_partido.estado NOT IN ('F', 'S', 'P', 'J') THEN
        -- FINALIZADO O SUSPENDIDO O POSTERGADO
        rw_partido.goles_club_local     := NULL;
        rw_partido.goles_club_visitante := NULL;
      END IF;
    
      rw_partido.descripcion := l_partido.get_string('etiqueta');
    
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
          rw_partido.nombre_club_local := NULL;
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
        ELSE
          rw_partido.nombre_club_local := treat(l_partido.get('local') AS json_object_t).get_string('nombre');
          --Inserta el equipo pendiente de alta si no existe
          IF nvl(l_id_club_local_tmp, 0) <> 0 THEN
            BEGIN
              INSERT INTO t_equipos_tmp
                (id_division, nombre_corto, id_importacion, id_pais, tipo)
              VALUES
                (l_id_division,
                 rw_partido.nombre_club_local,
                 l_id_club_local_tmp,
                 l_id_pais,
                 l_tipo_equipos);
            EXCEPTION
              WHEN dup_val_on_index THEN
                NULL;
            END;
          END IF;
        END IF;
      
        IF rw_partido.id_club_visitante IS NOT NULL THEN
          rw_partido.nombre_club_visitante := NULL;
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
        ELSE
          rw_partido.nombre_club_visitante := treat(l_partido.get('visitante') AS json_object_t).get_string('nombre');
          --Inserta el equipo pendiente de alta si no existe
          IF nvl(l_id_club_visitante_tmp, 0) <> 0 THEN
            BEGIN
              INSERT INTO t_equipos_tmp
                (id_division, nombre_corto, id_importacion, id_pais, tipo)
              VALUES
                (l_id_division,
                 rw_partido.nombre_club_visitante,
                 l_id_club_visitante_tmp,
                 l_id_pais,
                 l_tipo_equipos);
            EXCEPTION
              WHEN dup_val_on_index THEN
                NULL;
            END;
          END IF;
        END IF;
      
        rw_partido2 := lf_buscar_partido(rw_partido.id_importacion);
        IF rw_partido2.id_partido IS NOT NULL THEN
          --Acutualiza si no fue Programado Manualmente y no fue Finalizado
          IF NOT (rw_partido2.estado = 'M' AND rw_partido.estado = 'R') AND
             NOT (rw_partido2.estado = 'F' AND
              rw_partido2.id_club_local IS NOT NULL AND
              rw_partido2.id_club_visitante IS NOT NULL) THEN
            UPDATE t_partidos p
               SET id_torneo             = l_id_torneo,
                   id_club_local         = rw_partido.id_club_local,
                   id_club_visitante     = rw_partido.id_club_visitante,
                   fecha                 = rw_partido.fecha,
                   id_jornada            = rw_partido.id_jornada,
                   id_estadio            = rw_partido.id_estadio,
                   goles_club_local      = rw_partido.goles_club_local,
                   goles_club_visitante  = rw_partido.goles_club_visitante,
                   estado                = rw_partido.estado,
                   estado_predicciones   = nvl(estado_predicciones,
                                               rw_partido.estado_predicciones),
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
    l_url_base             t_importador_urls.descripcion%TYPE;
    l_canal_importacion    t_divisiones.canal_importacion%TYPE;
    l_incluir_alineaciones t_torneos.incluir_alineaciones%TYPE;
    l_incluir_incidencias  t_torneos.incluir_incidencias%TYPE;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_llavear_importacion_partido = 'N' THEN
      RETURN;
    END IF;
    lp_actualizar_importacion_partido('E');
  
    -- obtenemos datos de importacion del torneo
    lp_datos_importacion_torneo(i_id_torneo            => i_id_torneo,
                                o_url_base             => l_url_base,
                                o_canal_importacion    => l_canal_importacion,
                                o_incluir_alineaciones => l_incluir_alineaciones,
                                o_incluir_incidencias  => l_incluir_incidencias);
  
    IF l_url_base IS NOT NULL AND l_canal_importacion IS NOT NULL THEN
      -- obtenemos los datos a través del WS
      k_datos_fan.p_fixture(i_url_base          => l_url_base,
                            i_canal_importacion => l_canal_importacion,
                            o_ok                => l_ok,
                            o_response          => l_datos);
    
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
        IF k_mensajeria.f_enviar_correo(i_subject         => 'Error en Importación de Fixture',
                                        i_body            => l_datos,
                                        i_to              => k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS'),
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
    lp_actualizar_importacion_partido('D');
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      raise_application_error(-20502, SQLERRM);
  END;

  PROCEDURE p_importar_partido(i_id_partido IN VARCHAR2,
                               i_partido    IN CLOB) IS
    l_partido json_object_t;
  
    l_id                    t_partidos.id_importacion%TYPE;
    l_goleslocal            t_partidos.goles_club_local%TYPE;
    l_golesvisitante        t_partidos.goles_club_visitante%TYPE;
    l_goleslocal_antes      t_partidos.goles_club_local%TYPE;
    l_golesvisitante_antes  t_partidos.goles_club_visitante%TYPE;
    l_club_local            t_clubes.nombre_corto%TYPE;
    l_club_visitante        t_clubes.nombre_corto%TYPE;
    l_estado                t_partidos.estado%TYPE;
    l_estado_juego          t_partidos.estado_juego%TYPE;
    l_estado_juego_antes    t_partidos.estado_juego%TYPE;
    l_tiempo_juego          t_partidos.tiempo_juego%TYPE;
    l_tiempo_juego_antes    t_partidos.tiempo_juego%TYPE;
    l_tiempo_5_min          BOOLEAN := FALSE;
    l_id_division           t_divisiones.id_division%TYPE;
    l_partido_json          CLOB;
    l_tiene_incidencias     VARCHAR2(1);
    l_goles_a_notificar     VARCHAR2(4000);
    l_goles_a_notificar_ids y_cadenas;
    l_imagen_gol_url        VARCHAR2(4000);
    --
    rw_partido t_partidos%ROWTYPE;
  BEGIN
    dbms_output.put_line(i_partido);
    l_partido      := json_object_t(i_partido);
    l_partido      := l_partido.get_object('partido');
    l_partido_json := l_partido.to_clob;
  
    l_id := l_partido.get_number('id');
    --dbms_output.put_line('id:' || l_id);
  
    l_goleslocal     := l_partido.get_number('golesLocal');
    l_golesvisitante := l_partido.get_number('golesVisitante');
    l_estado         := l_partido.get_string('estado');
    l_estado_juego   := l_partido.get_string('estadoDeJuego'); -- PT, ET, ST
    l_tiempo_juego   := l_partido.get_string('tiempoDeJuego'); -- 49:28
  
    IF l_estado NOT IN ('F', 'S', 'P', 'J') THEN
      -- FINALIZADO O SUSPENDIDO O POSTERGADO
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
                 p.estado_juego,
                 CASE
                   WHEN p.tiempo_juego LIKE '%:%' THEN
                    substr(p.tiempo_juego, 1, instr(p.tiempo_juego, ':') - 1)
                   ELSE
                    p.tiempo_juego
                 END
            INTO l_id_division,
                 l_club_local,
                 l_club_visitante,
                 l_goleslocal_antes,
                 l_golesvisitante_antes,
                 l_estado_juego_antes,
                 l_tiempo_juego_antes
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
                 estado_juego         = l_estado_juego,
                 tiempo_juego         = l_tiempo_juego
           WHERE p.id_partido = rw_partido.id_partido;
        
        END IF;
      
        BEGIN
          SELECT CASE
                   WHEN json_exists(l_partido_json, '$.incidenciasLocal') OR
                        json_exists(l_partido_json, '$.incidenciasVisitante') THEN
                    'S'
                   ELSE
                    'N'
                 END
            INTO l_tiene_incidencias
            FROM dual;
        
          IF l_tiene_incidencias = 'S' THEN
            UPDATE t_partido_incidencias a
               SET a.anulado = 'S'
             WHERE a.id_partido = rw_partido.id_partido;
          
            MERGE INTO t_partido_incidencias a
            USING (SELECT rw_partido.id_partido id_partido,
                          row_number() over(ORDER BY x.id_importacion) orden,
                          x.local_visitante,
                          x.periodo,
                          x.tiempo,
                          x.id_importacion,
                          x.incidencia,
                          x.detalle,
                          x.jugador_sale,
                          x.jugador_entra
                     FROM (SELECT 'L' local_visitante,
                                  jt.id_importacion,
                                  jt.periodo,
                                  jt.tiempo,
                                  jt.incidencia,
                                  jt.detalle,
                                  jt.jugador_sale,
                                  jt.jugador_entra
                             FROM json_table(l_partido_json,
                                             '$.incidenciasLocal[*]'
                                             columns(id_importacion NUMBER path
                                                     '$.id',
                                                     periodo VARCHAR2(3) path
                                                     '$.periodo',
                                                     tiempo VARCHAR2(10) path
                                                     '$.tiempo',
                                                     incidencia VARCHAR2(50) path
                                                     '$.incidencia',
                                                     detalle VARCHAR2(100) path
                                                     '$.jugador',
                                                     jugador_sale VARCHAR2(100) path
                                                     '$.sale',
                                                     jugador_entra
                                                     VARCHAR2(100) path
                                                     '$.entra')) jt
                            WHERE jt.id_importacion IS NOT NULL
                           UNION ALL
                           SELECT 'V' local_visitante,
                                  jt.id_importacion,
                                  jt.periodo,
                                  jt.tiempo,
                                  jt.incidencia,
                                  jt.detalle,
                                  jt.jugador_sale,
                                  jt.jugador_entra
                             FROM json_table(l_partido_json,
                                             '$.incidenciasVisitante[*]'
                                             columns(id_importacion NUMBER path
                                                     '$.id',
                                                     periodo VARCHAR2(3) path
                                                     '$.periodo',
                                                     tiempo VARCHAR2(10) path
                                                     '$.tiempo',
                                                     incidencia VARCHAR2(50) path
                                                     '$.incidencia',
                                                     detalle VARCHAR2(100) path
                                                     '$.jugador',
                                                     jugador_sale VARCHAR2(100) path
                                                     '$.sale',
                                                     jugador_entra
                                                     VARCHAR2(100) path
                                                     '$.entra')) jt
                            WHERE jt.id_importacion IS NOT NULL) x) b
            ON (a.id_partido = b.id_partido AND a.id_importacion = b.id_importacion)
            WHEN MATCHED THEN
              UPDATE
                 SET a.orden           = b.orden,
                     a.local_visitante = b.local_visitante,
                     a.periodo         = b.periodo,
                     a.tiempo          = b.tiempo,
                     a.anulado         = 'N',
                     a.incidencia      = b.incidencia,
                     a.detalle         = b.detalle,
                     a.jugador_sale    = b.jugador_sale,
                     a.jugador_entra   = b.jugador_entra
            WHEN NOT MATCHED THEN
              INSERT
                (id_partido,
                 orden,
                 local_visitante,
                 periodo,
                 tiempo,
                 id_importacion,
                 anulado,
                 incidencia,
                 detalle,
                 jugador_sale,
                 jugador_entra)
              VALUES
                (b.id_partido,
                 b.orden,
                 b.local_visitante,
                 b.periodo,
                 b.tiempo,
                 b.id_importacion,
                 'N',
                 b.incidencia,
                 b.detalle,
                 b.jugador_sale,
                 b.jugador_entra);
          
            -- Prepara los goles pendientes para la notificacion push.
            SELECT listagg(x.mensaje, chr(10)) within GROUP(ORDER BY x.orden, x.id_partido_incidencia),
                   CAST(COLLECT(to_char(x.id_partido_incidencia)) AS
                        y_cadenas)
              INTO l_goles_a_notificar, l_goles_a_notificar_ids
              FROM (SELECT a.orden,
                           a.id_partido_incidencia,
                           TRIM(CASE
                                  WHEN a.tiempo_juego IS NOT NULL THEN
                                   a.tiempo_juego || ' '
                                END || CASE
                                  WHEN upper(a.incidencia) LIKE '%ANULAD%' THEN
                                   'Gol anulado'
                                  ELSE
                                   'Gol'
                                END || CASE
                                  WHEN a.club IS NOT NULL THEN
                                   ' de ' || a.club
                                END || CASE
                                  WHEN a.detalle IS NOT NULL THEN
                                   ' - ' || a.detalle || CASE
                                     WHEN upper(a.incidencia) LIKE '%EN CONTR%' AND
                                          upper(a.incidencia) NOT LIKE '%ANULAD%' THEN
                                      ' (EC)'
                                   END
                                  WHEN upper(a.incidencia) LIKE '%EN CONTR%' AND
                                       upper(a.incidencia) NOT LIKE '%ANULAD%' THEN
                                   ' (EC)'
                                END) mensaje
                      FROM (SELECT i.orden,
                                   i.id_partido_incidencia,
                                   i.incidencia,
                                   i.detalle,
                                   TRIM(i.periodo || ' ' || i.tiempo) tiempo_juego,
                                   CASE i.local_visitante
                                     WHEN 'L' THEN
                                      l_club_local
                                     WHEN 'V' THEN
                                      l_club_visitante
                                   END club
                              FROM t_partido_incidencias i
                             WHERE i.id_partido = rw_partido.id_partido
                               AND i.notificado = 'N'
                               AND i.anulado = 'N'
                               AND upper(i.incidencia) LIKE 'GOL%') a) x;
          
            IF l_goles_a_notificar IS NOT NULL THEN
              DECLARE
                l_id_club t_clubes.id_club%TYPE;
                l_club    t_clubes.nombre_corto%TYPE;
                l_jugador t_partido_incidencias.detalle%TYPE;
                l_minuto  VARCHAR2(20);
              BEGIN
                SELECT x.id_club, x.club, x.jugador, x.minuto
                  INTO l_id_club, l_club, l_jugador, l_minuto
                  FROM (SELECT CASE i.local_visitante
                                 WHEN 'L' THEN
                                  rw_partido.id_club_local
                                 WHEN 'V' THEN
                                  rw_partido.id_club_visitante
                               END id_club,
                               CASE i.local_visitante
                                 WHEN 'L' THEN
                                  l_club_local
                                 WHEN 'V' THEN
                                  l_club_visitante
                               END club,
                               nvl(i.detalle,
                                   CASE i.local_visitante
                                     WHEN 'L' THEN
                                      l_club_local
                                     WHEN 'V' THEN
                                      l_club_visitante
                                   END) jugador,
                               CASE
                                 WHEN i.tiempo IS NULL THEN
                                  TRIM(i.periodo)
                                 WHEN instr(i.tiempo, '''') > 0 THEN
                                  i.tiempo
                                 ELSE
                                  i.tiempo || ''''
                               END minuto,
                               row_number() over(ORDER BY i.orden DESC, i.id_partido_incidencia DESC) rn
                          FROM t_partido_incidencias i
                         WHERE i.id_partido = rw_partido.id_partido
                           AND i.notificado = 'N'
                           AND i.anulado = 'N'
                           AND upper(i.incidencia) LIKE 'GOL%') x
                 WHERE x.rn = 1;
              
                l_imagen_gol_url := k_imagenes_fan.f_url_imagen_gol(i_id_club     => l_id_club,
                                                                    i_nombre_club => l_club,
                                                                    i_jugador     => l_jugador,
                                                                    i_marcador    => nvl(to_char(l_goleslocal),
                                                                                         '0') ||
                                                                                     ' - ' ||
                                                                                     nvl(to_char(l_golesvisitante),
                                                                                         '0'),
                                                                    i_minuto      => l_minuto);
              EXCEPTION
                WHEN OTHERS THEN
                  l_imagen_gol_url := NULL;
              END;
            END IF;
          END IF;
        END;
      
        $if k_modulo.c_instalado_msj $then
        -- Notifica la actualización en el resultado del partido en juego de forma silenciosa
        IF l_estado = 'J' AND l_club_local IS NOT NULL AND
           l_club_visitante IS NOT NULL THEN
          -- EN JUEGO
          BEGIN
            l_tiempo_juego := CASE
                                WHEN l_tiempo_juego LIKE '%:%' THEN
                                 substr(l_tiempo_juego,
                                        1,
                                        instr(l_tiempo_juego, ':') - 1)
                                ELSE
                                 l_tiempo_juego
                              END;
            l_tiempo_5_min := MOD(to_number(l_tiempo_juego), 5) = 0;
          EXCEPTION
            WHEN OTHERS THEN
              l_tiempo_juego := NULL;
              l_tiempo_5_min := FALSE;
          END;
        
          IF (nvl(l_goleslocal_antes, -1) <> nvl(l_goleslocal, -1)) OR
             (nvl(l_golesvisitante_antes, -1) <> nvl(l_golesvisitante, -1)) OR
             (nvl(l_estado_juego_antes, 'X') <> nvl(l_estado_juego, 'X')) OR
             (nvl(l_tiempo_juego_antes, 'X') <> nvl(l_tiempo_juego, 'X') AND
             l_tiempo_5_min) OR l_goles_a_notificar IS NOT NULL THEN
            DECLARE
              l_json_object json_object_t;
              l_result      PLS_INTEGER;
              --
              l_mensaje VARCHAR2(4000) := 'Partido en Juego';
            BEGIN
              IF l_estado_juego = 'PT' THEN
                IF l_tiempo_juego IS NOT NULL THEN
                  l_mensaje := '1T - ' || l_tiempo_juego || ' min.';
                ELSE
                  l_mensaje := '1T en Juego';
                END IF;
              ELSIF l_estado_juego = 'ET' THEN
                l_mensaje := 'Entretiempo';
              ELSIF l_estado_juego = 'ST' THEN
                IF l_tiempo_juego IS NOT NULL THEN
                  l_mensaje := '2T - ' || l_tiempo_juego || ' min.';
                ELSE
                  l_mensaje := '2T en Juego';
                END IF;
              END IF;
            
              IF l_goles_a_notificar IS NOT NULL THEN
                IF l_mensaje IS NOT NULL THEN
                  l_mensaje := l_mensaje || chr(10) || chr(10) ||
                               l_goles_a_notificar;
                ELSE
                  l_mensaje := l_goles_a_notificar;
                END IF;
              END IF;
            
              l_json_object := NEW json_object_t();
              l_json_object.put('tipo', 'PARTIDO'); --TODO: convertir a constante
              l_json_object.put('identificador', rw_partido.id_partido);
              l_json_object.put('unaAlerta', 'S'); -- alerta silenciosa
              l_json_object.put('dato1', rw_partido.id_club_local);
              l_json_object.put('dato2', rw_partido.id_club_visitante);
              l_json_object.put('dato3', rw_partido.id_torneo);
              IF l_goles_a_notificar IS NOT NULL AND
                 l_imagen_gol_url IS NOT NULL THEN
                l_json_object.put('imagen', l_imagen_gol_url);
              END IF;
            
              l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local || ' ' ||
                                                                              l_goleslocal ||
                                                                              ' - ' ||
                                                                              l_golesvisitante || ' ' ||
                                                                              l_club_visitante,
                                                             i_contenido   => l_mensaje,
                                                             i_datos_extra => l_json_object.to_clob,
                                                             i_suscripcion => 'ESPECIAL_EXTRAS' || '&&' || --TODO: convertir a constante
                                                                              k_dispositivo.f_suscripcion_division(l_id_division));
            
              IF l_result = k_mensajeria.c_ok AND
                 l_goles_a_notificar IS NOT NULL THEN
                UPDATE t_partido_incidencias i
                   SET i.notificado = 'S'
                 WHERE i.id_partido_incidencia IN
                       (SELECT to_number(column_value)
                          FROM TABLE(l_goles_a_notificar_ids));
              END IF;
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
    l_url_base             t_importador_urls.descripcion%TYPE;
    l_canal_importacion    t_divisiones.canal_importacion%TYPE;
    l_incluir_alineaciones t_torneos.incluir_alineaciones%TYPE;
    l_incluir_incidencias  t_torneos.incluir_incidencias%TYPE;
  BEGIN
    -- verificamos si ya existe una importación en ejecución
    IF f_llavear_importacion_partido = 'N' THEN
      RETURN;
    END IF;
    lp_actualizar_importacion_partido('E');
  
    -- obtenemos datos de importacion del torneo
    lp_datos_importacion_torneo(i_id_torneo            => lf_id_torneo_partido(i_id_partido),
                                o_url_base             => l_url_base,
                                o_canal_importacion    => l_canal_importacion,
                                o_incluir_alineaciones => l_incluir_alineaciones,
                                o_incluir_incidencias  => l_incluir_incidencias);
  
    -- obtenemos los datos a través del WS
    k_datos_fan.p_partido(i_url_base             => l_url_base,
                          i_canal_importacion    => l_canal_importacion,
                          i_partido              => lf_id_importacion_partido(i_id_partido),
                          i_incluir_alineaciones => CASE
                                                     l_incluir_alineaciones
                                                      WHEN 'S' THEN
                                                       TRUE
                                                      ELSE
                                                       FALSE
                                                    END,
                          i_incluir_incidencias  => CASE
                                                     l_incluir_incidencias
                                                      WHEN 'S' THEN
                                                       TRUE
                                                      ELSE
                                                       FALSE
                                                    END,
                          o_ok                   => l_ok,
                          o_response             => l_datos);
  
    -- actualizamos la cabecera de los partidos
    IF l_ok = 'S' THEN
      p_importar_partido(i_id_partido => NULL, i_partido => l_datos);
    ELSE
      DECLARE
        l_descripcion VARCHAR2(30);
        --
        l_id_usu_envio t_usuarios.id_usuario%TYPE := 1; --demouser
        l_id_grupo     t_grupos.id_grupo%TYPE := 332; --grupo de monitoreo
        l_des_grupo    t_grupos.descripcion%TYPE := 'Monitoreo Reto Sports';
        l_contenido    t_grupo_mensajes.contenido%TYPE;
        l_ref_mensaje  t_grupo_mensajes.ref_mensaje%TYPE := NULL;
      BEGIN
        -- Obtiene datos del partido
        BEGIN
          SELECT p.id_club_local || '-' || p.id_club_visitante
            INTO l_descripcion
            FROM t_partidos p
           WHERE p.id_partido = i_id_partido;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      
        -- Registra mensaje en el grupo de monitoreo
        l_contenido := substr('Error en Importación de Partido ' || '#' ||
                              i_id_partido || ' ' || l_descripcion ||
                              chr(10) || l_datos,
                              1,
                              2000);
        /*
        -- Comentado temporalmente para no llenar de mensajes el grupo
        BEGIN
          INSERT INTO t_grupo_mensajes a
            (id_grupo, id_usuario, contenido, ref_mensaje)
          VALUES
            (l_id_grupo, l_id_usu_envio, l_contenido, l_ref_mensaje);
        EXCEPTION
          WHEN OTHERS THEN
            dbms_output.put_line('Error al registrar mensaje de error en k_datos_fan.p_partido. ' || '#' ||
                                 i_id_partido);
        END;
        */
      
        -- Envía correo de error inesperado
        $if k_modulo.c_instalado_msj $then
        /*IF k_mensajeria.f_enviar_correo(i_subject         => 'Error en Importación de Partido ' || '#' ||
                                                             i_id_partido || ' ' ||
                                                             l_descripcion,
                                        i_body            => l_datos,
                                        i_to              => k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS'),
                                        i_prioridad_envio => k_mensajeria.c_prioridad_importante) <>
           k_mensajeria.c_ok THEN
          dbms_output.put_line('Error al enviar correo de error en k_datos_fan.p_partido. ' || '#' ||
                               i_id_partido);
        END IF;*/
        DECLARE
          l_json_object json_object_t;
          l_result      PLS_INTEGER;
        BEGIN
          l_json_object := NEW json_object_t();
          l_json_object.put('tipo', 'GRUPO'); --TODO: convertir a constante
          l_json_object.put('id_grupo', to_char(l_id_grupo));
          l_json_object.put('nombre_grupo', l_des_grupo);
          l_json_object.put('usuario', k_usuario.f_alias(l_id_usu_envio));
          l_json_object.put('mensaje', l_contenido);
        
          l_result := k_mensajeria.f_enviar_notificacion(i_titulo          => NULL,
                                                         i_contenido       => NULL,
                                                         i_datos_extra     => l_json_object.to_clob,
                                                         i_prioridad_envio => k_mensajeria.c_prioridad_importante,
                                                         i_suscripcion     => 'MENSAJERIA' || '&&' || --TODO: convertir a constante
                                                                              k_dispositivo.c_suscripcion_grupo || '_' ||
                                                                              l_id_grupo || '&&' || '!' ||
                                                                              k_dispositivo.c_suscripcion_usuario || '_' ||
                                                                              l_id_usu_envio);
        EXCEPTION
          WHEN OTHERS THEN
            dbms_output.put_line('Error al enviar notificacion de error en k_datos_fan.p_partido. ' || '#' ||
                                 i_id_partido);
        END;
        $end
        raise_application_error(-20501,
                                'Error en k_datos_fan.p_partido: ' ||
                                l_datos);
      END;
    END IF;
    lp_actualizar_importacion_partido('D');
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      raise_application_error(-20502, SQLERRM);
  END;

BEGIN
  -- Initialization
  dbms_output.enable(1000000);
END;
/
