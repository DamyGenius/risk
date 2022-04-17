CREATE OR REPLACE PACKAGE k_puntajes_fan IS

  /**
  Agrupa operaciones relacionadas con el calculo de puntajes de predicciones.
  
  %author dmezac 01/09/2020 23:28:59
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

  -- Calcula el puntaje realizado por un usuario en un partido.
  -- %param
  -- %return Puntaje realizado por un usuario en un partido. Nulo si no está definido
  FUNCTION f_calcular_puntaje(i_id_usuario IN t_predicciones.id_usuario%TYPE,
                              i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER;

  -- Actualiza los puntajes de los usuarios que predijeron en un partido finalizado.
  -- %param
  PROCEDURE p_actualizar_puntajes(i_id_partido IN t_partidos.id_partido%TYPE,
                                  i_id_usuario IN t_predicciones.id_usuario%TYPE := NULL);

  -- Actualiza los puntajes de todos los usuarios que predijeron en una jornada.
  -- %param
  PROCEDURE p_actualizar_puntajes(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                  i_id_jornada IN t_torneo_jornadas.id_jornada%TYPE);

  -- Retorna la sumatoria de puntos de predicciones de un usuario en un torneo.
  -- %param
  -- %return Puntaje de un usuario en un torneo a partir de una jornada. Nulo si no está definido
  FUNCTION f_puntaje_usuario(i_id_torneo         IN t_partidos.id_torneo%TYPE,
                             i_id_usuario        IN t_predicciones.id_usuario%TYPE,
                             i_id_jornada_inicio IN t_partidos.id_jornada%TYPE DEFAULT NULL,
                             i_id_jornada_fin    IN t_partidos.id_jornada%TYPE DEFAULT NULL)
    RETURN NUMBER;

  -- Actualiza el ranking de todos los grupos.
  PROCEDURE p_actualizar_ranking(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE DEFAULT NULL);

  -- Planifica el trabajo de los partidos programados del torneo.
  PROCEDURE p_planificar_partidos(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                  i_id_partido IN t_partidos.id_partido%TYPE DEFAULT NULL);

  -- Cierra todas las predicciones de un partido.
  PROCEDURE p_cerrar_predicciones(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Inicia el trabajo de un partido en juego.
  PROCEDURE p_abrir_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Inicia el trabajo de cierre de un partido en juego, si el partido está finalizado.
  PROCEDURE p_iniciar_cierre_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Finaliza el trabajo de un partido en juego, si el partido está finalizado.
  PROCEDURE p_cerrar_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Alista cierre de predicciones de partido programado
  PROCEDURE p_alistar_cierre_predicciones(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Procesa grupo global de la jornada
  PROCEDURE p_procesar_grupo_jornada(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                     i_id_jornada IN NUMBER);

  -- Retorna grupo general del torneo
  FUNCTION f_grupo_general_torneo(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE)
    RETURN NUMBER;

END;
/
CREATE OR REPLACE PACKAGE BODY k_puntajes_fan IS

  -- Retorna la sumatoria de goles de un partido. Nulo si no está definido
  FUNCTION lf_sumatoria_real(i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER IS
  
    l_sumatoria NUMBER(3);
  
  BEGIN
  
    SELECT p.goles_club_local + p.goles_club_visitante
      INTO l_sumatoria
      FROM t_partidos p
     WHERE p.id_partido = i_id_partido;
  
    RETURN l_sumatoria;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error en lf_sumatoria_real:' ||
                           dbms_utility.format_error_stack);
      RETURN NULL;
    
  END;

  -- Retorna la diferencia de goles de un partido. Nulo si no está definido
  FUNCTION lf_diferencia_real(i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER IS
  
    l_diferencia NUMBER(3);
  
  BEGIN
  
    SELECT p.goles_club_local - p.goles_club_visitante
      INTO l_diferencia
      FROM t_partidos p
     WHERE p.id_partido = i_id_partido;
  
    RETURN l_diferencia;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error en lf_diferencia_real:' ||
                           dbms_utility.format_error_stack);
      RETURN NULL;
    
  END;

  -- Retorna la sumatoria de goles de una prediccion. Nulo si no está definido
  FUNCTION lf_sumatoria_prediccion(i_id_usuario IN t_predicciones.id_usuario%TYPE,
                                   i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER IS
  
    l_sumatoria NUMBER(3);
  
  BEGIN
  
    SELECT p.goles_club_local + p.goles_club_visitante
      INTO l_sumatoria
      FROM t_predicciones p
     WHERE p.id_usuario = i_id_usuario
       AND p.id_partido = i_id_partido;
  
    RETURN l_sumatoria;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error en lf_sumatoria_prediccion:' ||
                           dbms_utility.format_error_stack);
      RETURN NULL;
    
  END;

  -- Retorna la diferencia de goles de una prediccion. Nulo si no está definido
  FUNCTION lf_diferencia_prediccion(i_id_usuario IN t_predicciones.id_usuario%TYPE,
                                    i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER IS
  
    l_diferencia NUMBER(3);
  
  BEGIN
  
    SELECT p.goles_club_local - p.goles_club_visitante
      INTO l_diferencia
      FROM t_predicciones p
     WHERE p.id_usuario = i_id_usuario
       AND p.id_partido = i_id_partido;
  
    RETURN l_diferencia;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error en lf_diferencia_prediccion:' ||
                           dbms_utility.format_error_stack);
      RETURN NULL;
    
  END;

  -- Calcula el puntaje realizado por un usuario en un partido.
  FUNCTION f_calcular_puntaje(i_id_usuario IN t_predicciones.id_usuario%TYPE,
                              i_id_partido IN t_predicciones.id_partido%TYPE)
    RETURN NUMBER IS
  
    l_puntaje_total   NUMBER(3) := NULL;
    l_sumatoria_real  NUMBER(3);
    l_diferencia_real NUMBER(3);
    l_sumatoria_pred  NUMBER(3);
    l_diferencia_pred NUMBER(3);
  
  BEGIN
  
    -- Obtenemos las diferencias y sumatorias
    l_sumatoria_real  := lf_sumatoria_real(i_id_partido);
    l_diferencia_real := lf_diferencia_real(i_id_partido);
    l_sumatoria_pred  := lf_sumatoria_prediccion(i_id_usuario, i_id_partido);
    l_diferencia_pred := lf_diferencia_prediccion(i_id_usuario,
                                                  i_id_partido);
  
    IF l_sumatoria_real IS NULL OR l_diferencia_real IS NULL OR
       l_sumatoria_pred IS NULL OR l_diferencia_pred IS NULL THEN
      NULL;
    ELSIF l_diferencia_real = l_diferencia_pred AND
          l_sumatoria_real = l_sumatoria_pred THEN
      l_puntaje_total := 6; --Tomar de T_PRE_TORNEO_PUNTAJES (id_puntaje 1)
    ELSIF l_diferencia_real = l_diferencia_pred AND l_diferencia_real != 0 THEN
      l_puntaje_total := 3; --Tomar de T_PRE_TORNEO_PUNTAJES (id_puntaje 2)
    ELSIF (l_diferencia_real > 0 AND l_diferencia_pred > 0) OR
          (l_diferencia_real = 0 AND l_diferencia_pred = 0) OR
          (l_diferencia_real < 0 AND l_diferencia_pred < 0) THEN
      l_puntaje_total := 2; --Tomar de T_PRE_TORNEO_PUNTAJES (id_puntaje 3)
    ELSE
      l_puntaje_total := 0;
    END IF;
  
    RETURN l_puntaje_total;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error en f_calcular_puntaje:' ||
                           dbms_utility.format_error_stack);
      RETURN NULL;
    
  END;

  -- Actualiza los puntajes de los usuarios que predijeron en un partido finalizado.
  PROCEDURE p_actualizar_puntajes(i_id_partido IN t_partidos.id_partido%TYPE,
                                  i_id_usuario IN t_predicciones.id_usuario%TYPE := NULL) IS
  
    l_puntaje t_grupo_usuarios.puntos%TYPE;
    --
    CURSOR c_predicciones IS
      SELECT j.*, j.rowid fila
        FROM t_predicciones j, t_partidos p
       WHERE j.id_partido = i_id_partido
         AND j.id_partido = p.id_partido
         AND p.estado = 'F' --Finalizado
         AND j.estado = 'C' --Confirmado
         AND (j.id_usuario = i_id_usuario OR i_id_usuario IS NULL);
  
  BEGIN
  
    FOR c IN c_predicciones LOOP
      l_puntaje := f_calcular_puntaje(c.id_usuario, c.id_partido);
      UPDATE t_predicciones j
         SET j.puntos = l_puntaje, j.estado = 'L' --Liquidado
       WHERE j.rowid = c.fila;
    
      $if k_modulo.c_instalado_msj $then
      -- Notifica el puntaje a todos los usuarios suscriptos
      DECLARE
        c_medalla    CONSTANT VARCHAR2(5) := chr(4036994439);
        c_serpentina CONSTANT VARCHAR2(5) := chr(4036988554);
        c_triste     CONSTANT VARCHAR2(5) := chr(4036991124);
        c_fuerza     CONSTANT VARCHAR2(5) := chr(4036989610);
        l_titulo  VARCHAR2(20);
        l_mensaje VARCHAR2(80);
        --
        l_result PLS_INTEGER;
      BEGIN
        l_titulo := '+' || to_char(l_puntaje) || ' Puntos';
        IF l_puntaje = 6 THEN
          l_titulo  := c_serpentina || ' ' || l_titulo || ' ' ||
                       c_serpentina;
          l_mensaje := '¡Felicidades! Pronosticaste el resultado exacto.' || ' ' ||
                       c_medalla;
        ELSIF l_puntaje = 3 THEN
          l_titulo  := c_serpentina || ' ' || l_titulo || ' ' ||
                       c_serpentina;
          l_mensaje := 'Pronosticaste el ganador y la diferencia de goles correcta.';
        ELSIF l_puntaje = 2 THEN
          l_titulo  := c_serpentina || ' ' || l_titulo || ' ' ||
                       c_serpentina;
          l_mensaje := 'Pronosticaste el ganador correcto.';
          IF c.goles_club_local = c.goles_club_visitante THEN
            l_mensaje := 'Pronosticaste correctamente el empate.';
          END IF;
        ELSIF l_puntaje = 0 THEN
          l_titulo  := substr(l_titulo, 2) || ' ' || c_triste;
          l_mensaje := 'Tu pronóstico fue incorrecto. ¡No te rindas!' || ' ' ||
                       c_fuerza;
        END IF;
      
        IF l_titulo IS NOT NULL OR l_mensaje IS NOT NULL THEN
          l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_titulo,
                                                         i_contenido   => l_mensaje,
                                                         i_datos_extra => NULL,
                                                         i_id_usuario  => c.id_usuario,
                                                         i_suscripcion => 'GENERAL'); --TODO: convertir a constante
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      $end
    
    END LOOP;
  
    -- Elimina la imagen del partido
    BEGIN
      k_importacion_fan.p_eliminar_escudos_partido(i_id_partido);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  
  END;

  -- Actualiza los puntajes de todos los usuarios que predijeron en una jornada.
  PROCEDURE p_actualizar_puntajes(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                  i_id_jornada IN t_torneo_jornadas.id_jornada%TYPE) IS
    CURSOR c_partidos IS
      SELECT p.*
        FROM t_partidos p
       WHERE p.id_torneo = i_id_torneo
         AND p.id_jornada = i_id_jornada
         AND p.estado = 'F' --Finalizado
      ;
  BEGIN
  
    FOR par IN c_partidos LOOP
      p_actualizar_puntajes(par.id_partido);
    END LOOP;
  
  END;

  -- Retorna la sumatoria de puntos de predicciones de un usuario en un torneo.
  FUNCTION f_puntaje_usuario(i_id_torneo         IN t_partidos.id_torneo%TYPE,
                             i_id_usuario        IN t_predicciones.id_usuario%TYPE,
                             i_id_jornada_inicio IN t_partidos.id_jornada%TYPE DEFAULT NULL,
                             i_id_jornada_fin    IN t_partidos.id_jornada%TYPE DEFAULT NULL)
    RETURN NUMBER IS
    l_puntaje t_grupo_usuarios.puntos%TYPE;
  BEGIN
  
    BEGIN
      SELECT /*nvl(*/
       SUM(nvl(j.puntos, 0)) /*, 0)*/
        INTO l_puntaje
        FROM t_predicciones j, t_partidos p
       WHERE p.id_torneo = i_id_torneo
         AND j.id_usuario = i_id_usuario
         AND j.id_partido = p.id_partido
         AND (p.id_jornada >= i_id_jornada_inicio OR
             i_id_jornada_inicio IS NULL)
         AND (p.id_jornada <= i_id_jornada_fin OR i_id_jornada_fin IS NULL);
    EXCEPTION
      WHEN no_data_found THEN
        l_puntaje := NULL;
      WHEN OTHERS THEN
        l_puntaje := NULL;
    END;
  
    RETURN l_puntaje;
  
  END;

  -- Actualiza el ranking de todos los grupos.
  PROCEDURE p_actualizar_ranking(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE DEFAULT NULL) IS
  BEGIN
    MERGE INTO t_grupo_torneo_usuarios d
    USING (SELECT n.my_rank,
                  n.puntaje,
                  n.id_grupo,
                  n.id_torneo,
                  n.id_usuario,
                  n.alias
             FROM v_ranking_usuarios n, t_grupo_torneos t
            WHERE n.id_grupo = t.id_grupo
              AND n.id_torneo = t.id_torneo
              AND t.id_torneo = nvl(i_id_torneo, t.id_torneo)) s
    ON (d.id_grupo = s.id_grupo AND d.id_torneo = s.id_torneo AND d.id_usuario = s.id_usuario)
    WHEN MATCHED THEN
      UPDATE SET d.puntos = s.puntaje, d.ranking = s.my_rank;
  END;

  -- Planifica el trabajo de los partidos programados del torneo.
  PROCEDURE p_planificar_partidos(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                  i_id_partido IN t_partidos.id_partido%TYPE DEFAULT NULL) IS
    l_id_torneo t_torneo_jornadas.id_torneo%TYPE;
    --
    CURSOR c_partidos IS
      SELECT p.id_partido, p.fecha fecha_inicio
        FROM t_partidos p, t_torneos t
       WHERE p.id_torneo = t.id_torneo
         AND p.id_torneo = l_id_torneo
         AND nvl(t.prueba, 'N') = 'N'
         AND (p.id_partido = i_id_partido OR i_id_partido IS NULL)
         AND p.estado = 'M' --Programado
      ;
    --
    CURSOR c_inicio_jornada IS
      WITH v_inicio_jornada AS
       (SELECT MIN(trunc(a.fecha)) fecha,
               a.id_torneo,
               a.id_jornada,
               initcap(TRIM(REPLACE(t.titulo, t.temporada, ''))) descripcion_torneo,
               t.id_division,
               initcap(j.titulo) descripcion_jornada
          FROM t_partidos a, t_torneos t, t_torneo_jornadas j
         WHERE a.id_torneo = t.id_torneo
           AND a.id_torneo = j.id_torneo
           AND a.id_jornada = j.id_jornada
           AND a.id_torneo = l_id_torneo
         GROUP BY a.id_torneo,
                  a.id_jornada,
                  t.titulo,
                  t.temporada,
                  t.id_division,
                  j.titulo)
      SELECT x.*
        FROM v_inicio_jornada x
       WHERE trunc(x.fecha) = trunc(SYSDATE) --Jornada que inicia en la fecha
         AND x.id_torneo = (SELECT tor.id_torneo
                              FROM t_torneos tor
                             WHERE tor.id_division IN ('PRI') --TODO: dinamizar
                               AND tor.actual = 'S');
  BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE = ''' ||
                      k_util.f_valor_parametro('ZONA_HORARIA') || '''';
  
    l_id_torneo := i_id_torneo;
  
    FOR par IN c_partidos LOOP
      -- Crea el trabajo de pre-cierre y cierre de predicciones
      -- TODO: Verificar si ya está creado con la misma fecha
      k_trabajo.p_crear_o_editar_trabajo(i_id_trabajo   => k_trabajo.c_pre_cierre_predicciones,
                                         i_parametros   => '{"id_partido":"' ||
                                                           par.id_partido || '"}',
                                         i_fecha_inicio => CAST(par.fecha_inicio AS
                                                                TIMESTAMP));
    
      k_trabajo.p_crear_o_editar_trabajo(i_id_trabajo   => k_trabajo.c_cierre_predicciones,
                                         i_parametros   => '{"id_partido":"' ||
                                                           par.id_partido || '"}',
                                         i_fecha_inicio => CAST(par.fecha_inicio AS
                                                                TIMESTAMP));
    END LOOP;
  
    $if k_modulo.c_instalado_msj $then
    -- Notifica el inicio de la jornada
    DECLARE
      l_result PLS_INTEGER;
    BEGIN
      FOR jor IN c_inicio_jornada LOOP
        l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => '¡Hoy empieza la ' ||
                                                                        jor.descripcion_jornada ||
                                                                        ' de ' ||
                                                                        jor.descripcion_torneo || '!',
                                                       i_contenido   => 'No te olvides de hacer tus pronósticos.' || ' ' ||
                                                                        chr(4036989873),
                                                       i_suscripcion => 'GENERAL' || '&&' || --TODO: convertir a constante
                                                                        k_dispositivo.f_suscripcion_division(jor.id_division));
      END LOOP;
    END;
    $end
  
  END;

  -- Cierra todas las predicciones de un partido.
  PROCEDURE p_cerrar_predicciones(i_id_partido IN t_partidos.id_partido%TYPE) IS
  BEGIN
    IF i_id_partido IS NULL THEN
      raise_application_error(-20000, 'Parámetro i_id_partido inválido');
    END IF;
  
    -- Cambia estado de predicciones del partido a Confirmado
    UPDATE t_partidos p
       SET p.estado_predicciones = 'C' --Confirmado
     WHERE p.id_partido = i_id_partido
       AND p.estado_predicciones = 'P'; --Pendiente
  
    -- Cambia estado de predicciones a Confirmado
    IF SQL%FOUND THEN
      UPDATE t_predicciones p
         SET p.estado = 'C' --Confirmado
       WHERE p.id_partido = i_id_partido
         AND p.estado = 'P'; --Pendiente
    END IF;
  
  END;

  -- Inicia el trabajo de un partido en juego.
  PROCEDURE p_abrir_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE) IS
    l_estado              t_partidos.estado%TYPE;
    l_estado_predicciones t_partidos.estado_predicciones%TYPE;
    l_id_club_local       t_clubes.id_club%TYPE;
    l_id_club_visitante   t_clubes.id_club%TYPE;
    l_club_local          t_clubes.nombre_corto%TYPE;
    l_club_visitante      t_clubes.nombre_corto%TYPE;
    l_id_division         t_divisiones.id_division%TYPE;
    --
    l_result PLS_INTEGER;
  BEGIN
    -- Obtiene datos del partido
    BEGIN
      SELECT t.id_division,
             p.estado,
             p.estado_predicciones,
             l.id_club id_club_local,
             v.id_club id_club_visitante,
             k_util.f_formatear_titulo(l.nombre_corto) club_local,
             k_util.f_formatear_titulo(v.nombre_corto) club_visitante
        INTO l_id_division,
             l_estado,
             l_estado_predicciones,
             l_id_club_local,
             l_id_club_visitante,
             l_club_local,
             l_club_visitante
        FROM t_partidos p, t_clubes l, t_clubes v, t_torneos t
       WHERE p.id_partido = i_id_partido
         AND p.id_club_local = l.id_club
         AND p.id_club_visitante = v.id_club
         AND p.id_torneo = t.id_torneo;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20001, 'Partido no registrado.');
      WHEN OTHERS THEN
        raise_application_error(-20002,
                                'Error al obtener estado del partido: ' ||
                                SQLERRM);
    END;
  
    IF l_estado IN ('M', 'J') AND l_estado_predicciones = 'C' THEN
      -- Crea el trabajo del partido en juego
      -- para partido programado o en juego con predicciones cerradas
      IF nvl(l_id_division, 'X') <> 'INT' THEN
        --TODO: Dinamizar divisiones que no tienen resultado en Vivo en Datafactory. Actualmente la Intermedia
        k_trabajo.p_crear_o_editar_trabajo(i_id_trabajo => k_trabajo.c_partido_en_juego,
                                           i_parametros => '{"id_partido":"' ||
                                                           i_id_partido || '"}');
      END IF;
      $if k_modulo.c_instalado_msj $then
      -- Notifica del partido en juego a todos los dispositivos suscriptos
      DECLARE
        l_json_object json_object_t;
        l_result      PLS_INTEGER;
      BEGIN
        l_json_object := NEW json_object_t();
        l_json_object.put('tipo', 'PARTIDO'); --TODO: convertir a constante
        l_json_object.put('identificador', i_id_partido);
        l_json_object.put('unaAlerta', 'S'); -- alerta silenciosa
        l_json_object.put('dato1', l_id_club_local);
        l_json_object.put('dato2', l_id_club_visitante);
      
        l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local ||
                                                                        ' vs. ' ||
                                                                        l_club_visitante,
                                                       i_contenido   => 'El partido ' ||
                                                                        'está comenzando.',
                                                       i_datos_extra => l_json_object.to_clob,
                                                       i_suscripcion => 'ESPECIAL_EXTRAS' || '&&' || --TODO: convertir a constante
                                                                        k_dispositivo.f_suscripcion_division(l_id_division));
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      $end
    
    END IF;
  END;

  -- Inicia el trabajo de cierre de un partido en juego, si el partido está finalizado.
  PROCEDURE p_iniciar_cierre_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE) IS
    l_estado t_partidos.estado%TYPE;
  BEGIN
    -- Obtener estado del partido
    BEGIN
      SELECT p.estado
        INTO l_estado
        FROM t_partidos p
       WHERE p.id_partido = i_id_partido;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20001, 'Partido no registrado.');
      WHEN OTHERS THEN
        raise_application_error(-20002,
                                'Error al obtener estado del partido: ' ||
                                SQLERRM);
    END;
  
    IF l_estado = 'F' THEN
      -- Inicia el trabajo de cierre del partido finalizado
      k_trabajo.p_crear_o_editar_trabajo(i_id_trabajo => k_trabajo.c_fin_partido,
                                         i_parametros => '{"id_partido":"' ||
                                                         i_id_partido || '"}');
    END IF;
  END;

  -- Finaliza el trabajo de un partido en juego, si el partido ya está finalizado.
  PROCEDURE p_cerrar_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE) IS
    l_estado            t_partidos.estado%TYPE;
    l_id_club_local     t_clubes.id_club%TYPE;
    l_id_club_visitante t_clubes.id_club%TYPE;
    l_club_local        t_clubes.nombre_corto%TYPE;
    l_club_visitante    t_clubes.nombre_corto%TYPE;
    l_goles_local       t_partidos.goles_club_local%TYPE;
    l_goles_visitante   t_partidos.goles_club_visitante%TYPE;
    l_id_division       t_divisiones.id_division%TYPE;
    --
    l_result PLS_INTEGER;
  BEGIN
    -- Obtiene datos del partido
    BEGIN
      SELECT t.id_division,
             p.estado,
             l.id_club id_club_local,
             v.id_club id_club_visitante,
             k_util.f_formatear_titulo(l.nombre_corto) club_local,
             k_util.f_formatear_titulo(v.nombre_corto) club_visitante,
             p.goles_club_local,
             p.goles_club_visitante
        INTO l_id_division,
             l_estado,
             l_id_club_local,
             l_id_club_visitante,
             l_club_local,
             l_club_visitante,
             l_goles_local,
             l_goles_visitante
        FROM t_partidos p, t_clubes l, t_clubes v, t_torneos t
       WHERE p.id_partido = i_id_partido
         AND p.id_club_local = l.id_club
         AND p.id_club_visitante = v.id_club
         AND p.id_torneo = t.id_torneo;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20001, 'Partido no registrado.');
      WHEN OTHERS THEN
        raise_application_error(-20002,
                                'Error al obtener estado del partido: ' ||
                                SQLERRM);
    END;
  
    IF l_estado = 'F' THEN
      -- Finaliza el trabajo del partido en juego
      -- para partido finalizado
      BEGIN
        k_trabajo.p_eliminar_trabajo(i_id_trabajo => k_trabajo.c_partido_en_juego,
                                     i_parametros => '{"id_partido":"' ||
                                                     i_id_partido || '"}');
      EXCEPTION
        WHEN OTHERS THEN
          IF SQLCODE = -27475 THEN
            -- el trabajo no existe
            NULL;
          ELSE
            RAISE;
          END IF;
      END;
      $if k_modulo.c_instalado_msj $then
      -- Notifica del partido finalizado a todos los dispositivos suscriptos
      DECLARE
        l_json_object json_object_t;
        l_result      PLS_INTEGER;
      BEGIN
        l_json_object := NEW json_object_t();
        l_json_object.put('tipo', 'PARTIDO'); --TODO: convertir a constante
        l_json_object.put('identificador', i_id_partido);
        l_json_object.put('unaAlerta', 'S'); -- alerta silenciosa
        l_json_object.put('dato1', l_id_club_local);
        l_json_object.put('dato2', l_id_club_visitante);
      
        l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local ||
                                                                        ' vs. ' ||
                                                                        l_club_visitante,
                                                       i_contenido   => 'El partido ' ||
                                                                        'finalizó ' ||
                                                                        l_goles_local || '-' ||
                                                                        l_goles_visitante || '.',
                                                       i_datos_extra => l_json_object.to_clob,
                                                       i_suscripcion => 'ESPECIAL_EXTRAS' || '&&' || --TODO: convertir a constante
                                                                        k_dispositivo.f_suscripcion_division(l_id_division));
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      $end
    END IF;
  END;

  -- Alista cierre de predicciones de partido programado
  PROCEDURE p_alistar_cierre_predicciones(i_id_partido IN t_partidos.id_partido%TYPE) IS
    l_estado              t_partidos.estado%TYPE;
    l_estado_predicciones t_partidos.estado_predicciones%TYPE;
    l_id_club_local       t_clubes.id_club%TYPE;
    l_id_club_visitante   t_clubes.id_club%TYPE;
    l_club_local          t_clubes.nombre_corto%TYPE;
    l_club_visitante      t_clubes.nombre_corto%TYPE;
    l_id_division         t_divisiones.id_division%TYPE;
    --
    l_result PLS_INTEGER;
  BEGIN
    -- Obtiene datos del partido
    BEGIN
      SELECT t.id_division,
             p.estado,
             p.estado_predicciones,
             l.id_club id_club_local,
             v.id_club id_club_visitante,
             k_util.f_formatear_titulo(l.nombre_corto) club_local,
             k_util.f_formatear_titulo(v.nombre_corto) club_visitante
        INTO l_id_division,
             l_estado,
             l_estado_predicciones,
             l_id_club_local,
             l_id_club_visitante,
             l_club_local,
             l_club_visitante
        FROM t_partidos p, t_clubes l, t_clubes v, t_torneos t
       WHERE p.id_partido = i_id_partido
         AND p.id_club_local = l.id_club
         AND p.id_club_visitante = v.id_club
         AND p.id_torneo = t.id_torneo;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20001, 'Partido no registrado.');
      WHEN OTHERS THEN
        raise_application_error(-20002,
                                'Error al obtener estado del partido: ' ||
                                SQLERRM);
    END;
  
    -- Guarda la imagen del partido para las notificaciones
    BEGIN
      k_importacion_fan.p_guardar_escudos_partido(i_id_partido);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  
    IF l_estado IN ('M') AND l_estado_predicciones = 'P' THEN
      $if k_modulo.c_instalado_msj $then
      -- Notifica del partido a comenzar a todos los dispositivos suscriptos
      DECLARE
        l_json_object json_object_t;
        l_result      PLS_INTEGER;
      BEGIN
        l_json_object := NEW json_object_t();
        l_json_object.put('tipo', 'PARTIDO'); --TODO: convertir a constante
        l_json_object.put('identificador', i_id_partido);
        l_json_object.put('unaAlerta', 'S'); -- alerta silenciosa
        l_json_object.put('dato1', l_id_club_local);
        l_json_object.put('dato2', l_id_club_visitante);
      
        l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => l_club_local ||
                                                                        ' vs. ' ||
                                                                        l_club_visitante,
                                                       i_contenido   => 'El partido comienza pronto. ' ||
                                                                        '¡No te olvides de pronosticar!',
                                                       i_datos_extra => l_json_object.to_clob,
                                                       i_suscripcion => 'ESPECIAL_EXTRAS' || '&&' || --TODO: convertir a constante
                                                                        k_dispositivo.f_suscripcion_division(l_id_division));
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      $end
    
    END IF;
  END;

  -- Procesa grupo global de la jornada
  PROCEDURE p_procesar_grupo_jornada(i_id_torneo  IN t_torneo_jornadas.id_torneo%TYPE,
                                     i_id_jornada IN NUMBER) IS
    c_tipo_grupo CONSTANT t_grupos.tipo%TYPE := 'GLO';
    l_id_grupo  t_grupos.id_grupo%TYPE;
    l_id_torneo t_partidos.id_torneo%TYPE;
  BEGIN
    l_id_torneo := i_id_torneo;
  
    -- Obtener grupo global de la jornada
    BEGIN
      SELECT a.id_grupo
        INTO l_id_grupo
        FROM t_grupos a, t_grupo_torneos b
       WHERE a.id_grupo = b.id_grupo
         AND a.tipo = c_tipo_grupo
         AND b.id_torneo = l_id_torneo
         AND b.id_jornada_inicio = i_id_jornada
         AND b.id_jornada_fin = i_id_jornada;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
    IF l_id_grupo IS NULL THEN
      -- Registrar grupo global de la jornada si no existe
      INSERT INTO t_grupos
        (id_division,
         descripcion,
         tipo,
         id_usuario_administrador,
         fecha_creacion,
         estado,
         situacion,
         id_club,
         todos_invitan)
      VALUES
        ((SELECT x.id_division
           FROM t_torneos x
          WHERE x.id_torneo = l_id_torneo),
         'Jornada ' || to_char(i_id_jornada),
         c_tipo_grupo,
         NULL,
         NULL,
         'A',
         'A',
         NULL,
         'N')
      RETURNING id_grupo INTO l_id_grupo;
    
      -- Registrar grupo global en el torneo
      INSERT INTO t_grupo_torneos
        (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
      VALUES
        (l_id_grupo, l_id_torneo, i_id_jornada, i_id_jornada);
    END IF;
  
    -- Registrar usuarios del grupo global de la jornada
    INSERT INTO t_grupo_usuarios
      (id_grupo, id_usuario, estado, aceptado)
      SELECT DISTINCT l_id_grupo id_grupo,
                      a.id_usuario,
                      'A' estado,
                      'S' aceptado
        FROM t_predicciones a, t_partidos p, t_usuarios u
       WHERE a.id_partido = p.id_partido
         AND p.id_jornada = i_id_jornada
         AND p.id_torneo = l_id_torneo
         AND a.id_usuario = u.id_usuario
         AND nvl(u.prueba, 'N') = 'N'
         AND EXISTS (SELECT 1
                FROM t_grupo_usuarios x
               WHERE x.id_grupo =
                     k_puntajes_fan.f_grupo_general_torneo(l_id_torneo)
                 AND x.id_usuario = a.id_usuario
                 AND x.estado = 'A')
         AND NOT EXISTS (SELECT 1
                FROM t_grupo_usuarios y
               WHERE y.id_grupo = l_id_grupo
                 AND y.id_usuario = a.id_usuario);
  
    -- Registrar usuarios del grupo global de la jornada en el torneo
    INSERT INTO t_grupo_torneo_usuarios
      (id_grupo, id_torneo, id_usuario)
      SELECT DISTINCT l_id_grupo   id_grupo,
                      l_id_torneo  id_torneo,
                      a.id_usuario
        FROM t_predicciones a, t_partidos p, t_usuarios u
       WHERE a.id_partido = p.id_partido
         AND p.id_jornada = i_id_jornada
         AND p.id_torneo = l_id_torneo
         AND a.id_usuario = u.id_usuario
         AND nvl(u.prueba, 'N') = 'N'
         AND EXISTS (SELECT 1
                FROM t_grupo_usuarios x
               WHERE x.id_grupo =
                     k_puntajes_fan.f_grupo_general_torneo(l_id_torneo)
                 AND x.id_usuario = a.id_usuario
                 AND x.estado = 'A')
         AND NOT EXISTS (SELECT 1
                FROM t_grupo_torneo_usuarios y
               WHERE y.id_grupo = l_id_grupo
                 AND y.id_torneo = l_id_torneo
                 AND y.id_usuario = a.id_usuario);
  
    -- Inactivar los grupos globales de jornadas anteriores
    UPDATE (SELECT a.estado
              FROM t_grupos a, t_grupo_torneos b
             WHERE a.id_grupo = b.id_grupo
               AND a.tipo = c_tipo_grupo
               AND b.id_torneo = l_id_torneo
               AND b.id_jornada_inicio < i_id_jornada
               AND b.id_jornada_fin = b.id_jornada_inicio
               AND a.estado = 'A') t
       SET t.estado = 'I';
  
  END;

  -- Retorna grupo general del torneo
  FUNCTION f_grupo_general_torneo(i_id_torneo IN t_torneo_jornadas.id_torneo%TYPE)
    RETURN NUMBER IS
    l_id_grupo t_grupos.id_grupo%TYPE;
  BEGIN
    SELECT g.id_grupo
      INTO l_id_grupo
      FROM t_grupos g, t_grupo_torneos gt
     WHERE g.id_grupo = gt.id_grupo
       AND g.tipo = 'GLO'
       AND g.id_club IS NULL
       AND gt.id_torneo = i_id_torneo
       AND gt.id_jornada_inicio IS NULL
       AND gt.id_jornada_fin IS NULL;
    RETURN l_id_grupo;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
  END;

BEGIN
  -- Initialization
  NULL;
END;
/
