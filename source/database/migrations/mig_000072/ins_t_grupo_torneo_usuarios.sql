INSERT INTO t_grupo_torneo_usuarios
  (id_grupo, id_torneo, id_usuario, puntos, ranking)
  SELECT gr.id_grupo, 'PRI-APE22', gu.id_usuario, NULL, NULL
    FROM t_grupos gr, t_grupo_usuarios gu
   WHERE gr.id_grupo = gu.id_grupo
        --AND gu.id_usuario = l_id_usuario
     AND (gr.tipo = 'PRI' OR
         gr.id_grupo = k_puntajes_fan.f_grupo_general_torneo('PRI-APE22'))
     AND gr.estado = 'A'
     AND nvl(gu.estado, 'I') <> 'I'
     AND gr.id_division =
         (SELECT x.id_division
            FROM t_torneos x
           WHERE x.id_torneo = 'PRI-APE22')
     AND NOT EXISTS (SELECT 1
            FROM t_grupo_torneo_usuarios y
           WHERE y.id_grupo = gr.id_grupo
             AND y.id_usuario = gu.id_usuario
             AND y.id_torneo = 'PRI-APE22');

INSERT INTO t_grupo_torneo_usuarios
  (id_grupo, id_torneo, id_usuario, puntos, ranking)
  SELECT gr.id_grupo, 'ELS-QAT22', gu.id_usuario, NULL, NULL
    FROM t_grupos gr, t_grupo_usuarios gu
   WHERE gr.id_grupo = gu.id_grupo
        --AND gu.id_usuario = l_id_usuario
     AND (gr.tipo = 'PRI' OR
         gr.id_grupo = k_puntajes_fan.f_grupo_general_torneo('ELS-QAT22'))
     AND gr.estado = 'A'
     AND nvl(gu.estado, 'I') <> 'I'
     AND gr.id_division =
         (SELECT x.id_division
            FROM t_torneos x
           WHERE x.id_torneo = 'ELS-QAT22')
     AND NOT EXISTS (SELECT 1
            FROM t_grupo_torneo_usuarios y
           WHERE y.id_grupo = gr.id_grupo
             AND y.id_usuario = gu.id_usuario
             AND y.id_torneo = 'ELS-QAT22');
