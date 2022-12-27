--https://sportsdemo.co/html/v3/index.html?channel=deportes.futbol.eliminatorias&lang=es_LA

select a.*, a.rowid from t_divisiones a
where a.id_division = nvl('&id_division',a.id_division)
;
select a.*, a.rowid from t_torneos a
where a.id_division = nvl('&id_division',a.id_division)
order by a.temporada desc, a.titulo desc
;
-- para aumentar version de servicios
select a.*, a.rowid from t_operaciones a
where a.id_operacion in (73,74)
order by a.id_operacion
;
select a.*, a.rowid from t_operacion_parametros a
where a.id_operacion in (73,74)
order by a.id_operacion,a.orden
;
select a.*, a.rowid from t_partidos a
where a.id_torneo='ELS-QAT22'
order by a.id_partido desc;

select a.*, a.rowid from t_importador_urls a
;
select a.*, a.rowid from t_trabajos a
;
--select a.*, a.rowid from t_monitoreos a
SELECT b.id_division,
       b.descripcion,
       upper(a.desc_importacion) torneo_baja,
       upper(b.desc_importacion_torneo) torneo_alta
  FROM t_torneos a, t_divisiones b
 WHERE a.id_division = b.id_division
   AND (a.id_importacion != b.id_importacion_torneo OR
       a.desc_importacion != b.desc_importacion_torneo)
   AND b.importado = 'S'
   AND a.importado = 'S'
;
SELECT b.id_torneo, b.titulo, COUNT(1) cantidad_partidos
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
 GROUP BY b.id_torneo, b.titulo
;
SELECT b.id_club, b.nombre_corto, b.id_pais
  FROM t_archivos a, t_clubes b
 WHERE a.tabla(+) = 'T_CLUBES'
   AND a.campo(+) = 'ESCUDO'
   AND a.referencia(+) = b.id_club
   AND a.tabla IS NULL
 ORDER BY b.id_pais, b.nombre_oficial
 ;
select a.*, a.rowid from t_equipos_tmp a
order by a.id_division, a.nombre_corto
;
select a.id_club,a.nombre_oficial,a.id_division,a.nombre_corto,a.id_importacion,a.id_pais,a.tipo, a.rowid from t_clubes a
where a.id_club='COR'
--where a.tipo='S'
;
select a.*, a.rowid from t_archivos a
where a.campo='ESCUDO'
and a.referencia='COR'
;
select a.*, a.rowid from t_aplicaciones a
where a.id_aplicacion='AND'
;
select a.*, a.rowid from t_sesiones a
where a.id_usuario=21
and a.estado='A'
order by a.fecha_estado desc




