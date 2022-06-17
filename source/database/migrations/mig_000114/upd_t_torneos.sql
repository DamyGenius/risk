UPDATE t_torneos a
   SET a.id_importacion   = 6571,
       a.desc_importacion = 'Paraguay - Torneo Apertura 2022'
 WHERE a.id_torneo = 'PRI-APE22';

UPDATE t_torneos a
   SET a.id_importacion   = 6609,
       a.desc_importacion = 'Chile - Campeonato PlanVital 2022'
 WHERE a.id_torneo = 'PRH-CAM22';

UPDATE t_torneos a
   SET a.id_importacion   = 6577,
       a.desc_importacion = 'CONMEBOL - Copa Sudamericana 2022'
 WHERE a.id_torneo = 'SUD-TEM22';

UPDATE t_torneos a
   SET a.id_importacion   = 6566,
       a.desc_importacion = 'CONMEBOL - Copa Libertadores 2022'
 WHERE a.id_torneo = 'LIB-TEM22';

UPDATE t_torneos a
   SET a.id_importacion   = 6573,
       a.desc_importacion = 'Paraguay - División Intermedia 2022'
 WHERE a.id_torneo = 'INT-TEM22';

UPDATE t_torneos a
   SET a.id_importacion   = 5704,
       a.desc_importacion = 'CONMEBOL - Eliminatorias Sudamericanas Qatar 2022'
 WHERE a.id_torneo = 'ELS-QAT22';

UPDATE t_torneos a
   SET a.desc_importacion = 'Uruguay - Torneo Apertura 2022'
 WHERE a.id_torneo = 'PRU-APE22';
