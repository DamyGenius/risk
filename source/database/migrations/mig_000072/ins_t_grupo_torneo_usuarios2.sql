INSERT INTO t_grupo_torneo_usuarios
  SELECT a.id_grupo, 'PRI-CLA21', a.id_usuario, a.puntos, a.ranking
    FROM t_grupo_usuarios a
   WHERE /*a.id_grupo = 1
     AND*/ EXISTS (SELECT x.*
            FROM t_grupo_torneos x
           WHERE x.id_grupo = a.id_grupo
             AND x.id_torneo = 'PRI-CLA21')
     AND NOT EXISTS (SELECT 1
            FROM t_grupo_torneo_usuarios y
           WHERE y.id_grupo = a.id_grupo
             AND y.id_torneo = 'PRI-CLA21'
             AND y.id_usuario = a.id_usuario);
