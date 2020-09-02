CREATE OR REPLACE VIEW v_ranking_usuarios AS
WITH lv_puntaje_usuarios AS
 (SELECT k_puntajes_fan.f_puntaje_usuario('PRI-APE20',
                                          a.id_usuario,
                                          c.id_jornada_inicio) puntaje,
         b.id_grupo,
         a.id_usuario,
         a.alias
    FROM t_usuarios a, t_grupo_usuarios b, t_grupos c
   WHERE a.id_usuario = b.id_usuario
     AND b.id_grupo = c.id_grupo
     AND c.estado = 'A'
     AND b.estado = 'A'
     AND a.estado = 'A')
SELECT rank() over(PARTITION BY id_grupo ORDER BY puntaje DESC NULLS LAST) my_rank,
       x.*
  FROM lv_puntaje_usuarios x;
