UPDATE t_grupos a
   SET a.id_jornada_inicio = NULL
--SELECT a.*, a.rowid FROM t_grupos a
 WHERE a.tipo = 'GLO'
   AND a.id_club IS NULL
   AND a.id_jornada_inicio = 1
   AND a.id_jornada_fin IS NULL;
