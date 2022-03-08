INSERT INTO t_grupo_torneos
  (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
  SELECT gr.id_grupo, 'PRI-APE22', NULL, NULL
    FROM t_grupos gr
   WHERE (gr.tipo = 'PRI')
     AND gr.estado = 'A'
     AND gr.id_division =
         (SELECT x.id_division
            FROM t_torneos x
           WHERE x.id_torneo = 'PRI-APE22')
     AND NOT EXISTS (SELECT 1
            FROM t_grupo_torneos y
           WHERE y.id_grupo = gr.id_grupo
             AND y.id_torneo = 'PRI-APE22');

INSERT INTO t_grupo_torneos
  (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
  SELECT gr.id_grupo, 'ELS-QAT22', NULL, NULL
    FROM t_grupos gr
   WHERE (gr.tipo = 'PRI')
     AND gr.estado = 'A'
     AND gr.id_division =
         (SELECT x.id_division
            FROM t_torneos x
           WHERE x.id_torneo = 'ELS-QAT22')
     AND NOT EXISTS (SELECT 1
            FROM t_grupo_torneos y
           WHERE y.id_grupo = gr.id_grupo
             AND y.id_torneo = 'ELS-QAT22');
