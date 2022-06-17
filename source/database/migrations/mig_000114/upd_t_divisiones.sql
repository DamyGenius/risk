UPDATE t_divisiones x
   SET x.importado = 'S'
 WHERE x.id_division IN
       (SELECT y.id_division FROM t_torneos y WHERE y.importado = 'S');

UPDATE t_divisiones x
   SET x.id_url = 'SPO'
 WHERE x.id_division IN
       (SELECT y.id_division FROM t_torneos y WHERE y.importado = 'S');

UPDATE t_divisiones x
   SET x.canal_importacion =
       (SELECT z.id_importacion
          FROM t_torneos z
         WHERE z.id_division = x.id_division
           AND z.importado = 'S')
 WHERE x.id_division IN
       (SELECT y.id_division FROM t_torneos y WHERE y.importado = 'S');
--
UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 6571,
       a.desc_importacion_torneo = 'Paraguay - Torneo Apertura 2022'
 WHERE a.id_division = 'PRI';

UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 6609,
       a.desc_importacion_torneo = 'Chile - Campeonato PlanVital 2022'
 WHERE a.id_division = 'PRH';

UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 6577,
       a.desc_importacion_torneo = 'CONMEBOL - Copa Sudamericana 2022'
 WHERE a.id_division = 'SUD';

UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 6566,
       a.desc_importacion_torneo = 'CONMEBOL - Copa Libertadores 2022'
 WHERE a.id_division = 'LIB';

UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 6573,
       a.desc_importacion_torneo = 'Paraguay - División Intermedia 2022'
 WHERE a.id_division = 'INT';

UPDATE t_divisiones a
   SET a.id_importacion_torneo   = 5704,
       a.desc_importacion_torneo = 'CONMEBOL - Eliminatorias Sudamericanas Qatar 2022'
 WHERE a.id_division = 'ELS';

UPDATE t_divisiones a
   SET a.desc_importacion_torneo = 'Uruguay - Torneo Apertura 2022'
 WHERE a.id_division = 'PRU';
