--select a.*, a.rowid from t_predicciones a;

--select a.*, a.rowid from t_torneos a
--where a.temporada='&temporada';

--Tus pronosticos del 2022
--Tus aciertos
SELECT COUNT(DISTINCT d.id_division) competencias,
       COUNT(DISTINCT t.id_torneo) torneos,
       COUNT(r.id_partido) pronosticos,
       SUM(CASE r.puntos
             WHEN 6 THEN
              1
             ELSE
              0
           END) resultado_exacto,
       SUM(CASE r.puntos
             WHEN 3 THEN
              1
             ELSE
              0
           END) ganador_correcto_diferencia_correcta,
       SUM(CASE r.puntos
             WHEN 2 THEN
              1
             ELSE
              0
           END) ganador_correcto_empate
  FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
 WHERE t.id_division = d.id_division
   AND t.id_torneo = p.id_torneo
   AND p.id_partido = r.id_partido
   AND nvl(t.prueba, 'N') = 'N'
   AND t.temporada = '&temporada'
   AND r.id_usuario = &id_usuario;

--Tus competencias cantidad
SELECT ceil(count(DISTINCT d.id_division)/3) filas
  FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
 WHERE t.id_division = d.id_division
   AND t.id_torneo = p.id_torneo
   AND p.id_partido = r.id_partido
   AND nvl(t.prueba, 'N') = 'N'
   AND t.temporada = '&temporada'
   AND r.id_usuario = &id_usuario;
   
--Tus competencias
SELECT DISTINCT d.id_division, d.descripcion, d.descripcion_corta
  FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
 WHERE t.id_division = d.id_division
   AND t.id_torneo = p.id_torneo
   AND p.id_partido = r.id_partido
   AND nvl(t.prueba, 'N') = 'N'
   AND t.temporada = '&temporada'
   AND r.id_usuario = &id_usuario;

--Tus mejores resultados
SELECT nvl(SUM(CASE
             WHEN gr.id_jornada_inicio IS NULL AND gr.id_jornada_fin IS NULL AND
                  gr.id_fase_inicio IS NULL AND gr.id_fase_fin IS NULL THEN
              1
             ELSE
              0
           END),0) resultado_ganador_torneo,
       nvl(SUM(CASE
             WHEN gr.id_jornada_inicio IS NOT NULL AND
                  gr.id_jornada_fin IS NOT NULL THEN
              1
             ELSE
              0
           END),0) resultado_ganador_fecha,
       nvl(SUM(CASE
             WHEN gr.id_jornada_inicio IS NULL AND gr.id_jornada_fin IS NULL AND
                  gr.id_fase_inicio IS NOT NULL AND gr.id_fase_fin IS NOT NULL THEN
              1
             ELSE
              0
           END),0) resultado_ganador_fase
--n.*,g.*,gr.*
  FROM t_torneos               t,
       t_grupo_torneo_usuarios n,
       t_grupos                g,
       t_grupo_torneos         gr
 WHERE t.id_torneo = n.id_torneo
   AND n.id_grupo = g.id_grupo
   AND g.id_grupo = gr.id_grupo
   AND g.tipo = 'GLO'
   AND t.temporada = '&temporada'
   AND n.ranking = 1
   AND n.id_usuario = &id_usuario;

--Todos tus resultados
SELECT d.id_division,
       d.descripcion,
       t.id_torneo,
       t.titulo,
       n.puntos,
       n.ranking,
       (SELECT COUNT(nn.id_usuario)
          FROM t_grupo_torneo_usuarios nn
         WHERE nn.id_grupo = n.id_grupo
           AND nn.id_torneo = n.id_torneo) participantes,
       
       CASE
         WHEN n.ranking = 1 THEN
          'S'
         ELSE
          'N'
       END ganador_torneo
--n.*,g.*,gr.*
  FROM t_torneos               t,
       t_divisiones            d,
       t_grupo_torneo_usuarios n,
       t_grupos                g,
       t_grupo_torneos         gr
 WHERE t.id_torneo = n.id_torneo
   AND t.id_division = d.id_division
   AND n.id_grupo = g.id_grupo
   AND g.id_grupo = gr.id_grupo
   AND g.tipo = 'GLO'
   AND t.temporada = '&temporada'
   AND n.id_usuario = &id_usuario
      --
   AND gr.id_jornada_inicio IS NULL
   AND gr.id_jornada_fin IS NULL
   AND gr.id_fase_inicio IS NULL
   AND gr.id_fase_fin IS NULL;
