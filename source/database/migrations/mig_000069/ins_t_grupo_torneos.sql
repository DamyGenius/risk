prompt Importing table t_grupos...
set feedback off
set define off

INSERT INTO t_grupo_torneos
  (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
  SELECT x.id_grupo, x.id_torneo, x.id_jornada_inicio, x.id_jornada_fin
    FROM t_grupos x
   WHERE NOT EXISTS (SELECT 1
            FROM t_grupo_torneos y
           WHERE y.id_torneo = x.id_torneo
             AND y.id_grupo = x.id_grupo);

prompt Done.
