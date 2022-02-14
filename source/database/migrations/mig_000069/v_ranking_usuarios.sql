CREATE OR REPLACE VIEW v_ranking_usuarios AS
WITH lv_puntaje_usuarios AS
 (SELECT k_puntajes_fan.f_puntaje_usuario(d.id_torneo,
                                          a.id_usuario,
                                          d.id_jornada_inicio,
                                          d.id_jornada_fin) puntaje,
         b.id_grupo,
         d.id_torneo,
         a.id_usuario,
         a.alias
    FROM t_usuarios a, t_grupo_usuarios b, t_grupos c, t_grupo_torneos d
   WHERE a.id_usuario = b.id_usuario
     AND b.id_grupo = c.id_grupo
     AND c.id_grupo = d.id_grupo
     AND c.estado = 'A'
     AND b.estado = 'A'
     AND a.estado = 'A')
SELECT rank() over(PARTITION BY id_grupo, id_torneo ORDER BY puntaje DESC NULLS LAST) my_rank,
       x.puntaje,
       x.id_grupo,
       x.id_torneo,
       x.id_usuario,
       x.alias
  FROM lv_puntaje_usuarios x;
