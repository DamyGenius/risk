--fecha
ALTER TABLE t_partidos ADD fecha_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_partidos SET fecha_n = FROM_TZ(CAST(fecha AS TIMESTAMP), 'America/Asuncion');
UPDATE t_partidos SET fecha = null;
ALTER TABLE t_partidos MODIFY fecha TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_partidos SET fecha = fecha_n;
ALTER TABLE t_partidos DROP COLUMN fecha_n;

