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
  FUNCTION f_puntaje_usuario(i_id_torneo  IN t_partidos.id_torneo%TYPE,
                             i_id_usuario IN t_predicciones.id_usuario%TYPE,
                             i_id_jornada IN t_partidos.id_jornada%TYPE DEFAULT NULL)
    RETURN NUMBER;

  -- Actualiza el ranking de todos los grupos.
  PROCEDURE p_actualizar_ranking;

  -- Cierra todas las predicciones de un partido.
  PROCEDURE p_cerrar_predicciones(i_id_partido IN t_partidos.id_partido%TYPE);

  -- Finaliza el trabajo de un partido en juego, si el partido ya está finalizado.
  PROCEDURE p_cerrar_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE);

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
            --AND j.estado = 'C' --Confirmado --TODO: Descomentar una vez que tenga el estado C
         AND (j.id_usuario = i_id_usuario OR i_id_usuario IS NULL);
  
  BEGIN
  
    FOR c IN c_predicciones LOOP
      l_puntaje := f_calcular_puntaje(c.id_usuario, c.id_partido);
      UPDATE t_predicciones j
         SET j.puntos = l_puntaje, j.estado = 'L' --Liquidado
       WHERE j.rowid = c.fila;
    END LOOP;
  
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
  FUNCTION f_puntaje_usuario(i_id_torneo  IN t_partidos.id_torneo%TYPE,
                             i_id_usuario IN t_predicciones.id_usuario%TYPE,
                             i_id_jornada IN t_partidos.id_jornada%TYPE DEFAULT NULL)
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
         AND (p.id_jornada >= i_id_jornada OR i_id_jornada IS NULL);
    EXCEPTION
      WHEN no_data_found THEN
        l_puntaje := NULL;
      WHEN OTHERS THEN
        l_puntaje := NULL;
    END;
  
    RETURN l_puntaje;
  
  END;

  -- Actualiza el ranking de todos los grupos.
  PROCEDURE p_actualizar_ranking IS
  BEGIN
    MERGE INTO t_grupo_usuarios d
    USING (SELECT n.my_rank, n.puntaje, n.id_grupo, n.id_usuario, n.alias
             FROM v_ranking_usuarios n) s
    ON (d.id_grupo = s.id_grupo AND d.id_usuario = s.id_usuario)
    WHEN MATCHED THEN
      UPDATE SET d.puntos = s.puntaje, d.ranking = s.my_rank;
  END;

  -- Cierra todas las predicciones de un partido.
  PROCEDURE p_cerrar_predicciones(i_id_partido IN t_partidos.id_partido%TYPE) IS
    l_fecha_inicio TIMESTAMP WITH TIME ZONE := current_timestamp + (900 / 86400); --dentro de 900 segs.
  BEGIN
    IF i_id_partido IS NULL THEN
      raise_application_error(-20000, 'Parámetro i_id_partido inválido');
    END IF;
  
    -- Cambia estado de partido a En Juego  
    UPDATE t_partidos p
       SET p.estado = 'J' --En Juego
     WHERE p.id_partido = i_id_partido
       AND p.estado = 'M'; --Programado es el estado previo a En Juego
  
    -- Cambia estado de predicciones a Confirmado
    IF SQL%FOUND THEN
      UPDATE t_predicciones p
         SET p.estado = 'C' --Confirmado
       WHERE p.id_partido = i_id_partido
         AND p.estado = 'P'; --Pendiente es el estado previo a Confirmado
    END IF;
  
    -- Crea el trabajo del partido en juego
    k_planificador.p_crear_o_editar_trabajo(i_id_trabajo   => k_planificador.c_partido_en_juego,
                                            i_parametros   => '{"id_partido":"' ||
                                                              i_id_partido || '"}',
                                            i_fecha_inicio => l_fecha_inicio);
  
  END;

  -- Finaliza el trabajo de un partido en juego, si el partido ya está finalizado.
  PROCEDURE p_cerrar_partido_en_juego(i_id_partido IN t_partidos.id_partido%TYPE) IS
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
      -- estado finalizado
      -- Crea el trabajo del partido en juego
      k_planificador.p_editar_trabajo(i_id_trabajo => k_planificador.c_partido_en_juego,
                                      i_parametros => '{"id_partido":"' ||
                                                      i_id_partido || '"}',
                                      i_fecha_fin  => current_timestamp);
    END IF;
  END;

BEGIN
  -- Initialization
  NULL;
END;
/
