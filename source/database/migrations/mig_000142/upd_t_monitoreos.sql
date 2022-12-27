UPDATE t_monitoreos a
   SET a.consulta_sql = 'SELECT b.id_torneo, b.titulo, COUNT(1) cantidad_partidos
  FROM t_partidos a, t_torneos b
 WHERE a.id_torneo = b.id_torneo
   AND ((a.id_club_local IS NULL AND
       (a.nombre_club_local IS NULL OR EXISTS
        (SELECT 1
             FROM t_equipos_tmp m
            WHERE m.nombre_corto = a.nombre_club_local))) OR
       (a.id_club_visitante IS NULL AND
       (a.nombre_club_visitante IS NULL OR EXISTS
        (SELECT 1
             FROM t_equipos_tmp m
            WHERE m.nombre_corto = a.nombre_club_visitante))))
 GROUP BY b.id_torneo, b.titulo'
 WHERE a.id_monitoreo = 504;
