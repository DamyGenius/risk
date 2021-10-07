CREATE OR REPLACE PROCEDURE p_procesar_grupo_jornada(i_id_jornada IN NUMBER) IS
  /* DEPRECADO: Utilizar k_puntajes_fan.p_procesar_grupo_jornada en su lugar */
  l_id_grupo  t_grupos.id_grupo%TYPE;
  l_id_torneo t_partidos.id_torneo%TYPE;
  c_tipo_grupo CONSTANT t_grupos.tipo%TYPE := 'GLO';
BEGIN
  l_id_torneo := k_sistema.f_valor_parametro_string(k_sistema.c_torneo);

  BEGIN
    SELECT a.id_grupo
      INTO l_id_grupo
      FROM t_grupos a
     WHERE a.tipo = c_tipo_grupo
       AND a.id_torneo = l_id_torneo
       AND a.id_jornada_inicio = i_id_jornada
       AND a.id_jornada_fin = i_id_jornada;
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;

  IF l_id_grupo IS NULL THEN
    INSERT INTO t_grupos
      (id_torneo,
       descripcion,
       tipo,
       id_usuario_administrador,
       fecha_creacion,
       id_jornada_inicio,
       estado,
       situacion,
       id_club,
       todos_invitan,
       id_jornada_fin)
    VALUES
      (l_id_torneo,
       'Jornada ' || to_char(i_id_jornada),
       c_tipo_grupo,
       NULL,
       NULL,
       i_id_jornada,
       'A',
       'A',
       NULL,
       'N',
       i_id_jornada)
    RETURNING id_grupo INTO l_id_grupo;
  END IF;

  INSERT INTO t_grupo_usuarios
    (id_grupo, id_usuario, estado, aceptado)
    SELECT DISTINCT l_id_grupo id_grupo,
                    a.id_usuario,
                    'A' estado,
                    'S' aceptado
      FROM t_predicciones a, t_partidos p
     WHERE a.id_partido = p.id_partido
       AND p.id_jornada = i_id_jornada
       AND p.id_torneo = l_id_torneo
       AND a.id_usuario IN (SELECT x.id_usuario
                              FROM t_grupo_usuarios x
                             WHERE x.id_grupo = 1
                               AND x.estado = 'A')
       AND NOT EXISTS (SELECT 1
              FROM t_grupo_usuarios y
             WHERE y.id_grupo = l_id_grupo
               AND y.id_usuario = a.id_usuario);

  -- actualizamos el ranking
  -- TODO: actualizar solo el ranking de este grupo y torneo
  k_puntajes_fan.p_actualizar_ranking;

  -- Inactivar los grupos globales de jornadas anteriores
  BEGIN
    UPDATE t_grupos a
       SET a.estado = 'I'
     WHERE a.tipo = c_tipo_grupo
       AND a.id_torneo = l_id_torneo
       AND a.id_jornada_inicio < i_id_jornada
       AND a.id_jornada_fin = a.id_jornada_inicio
       AND a.estado = 'A';
  END;

END;
/
