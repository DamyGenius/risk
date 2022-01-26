--fecha_creacion
ALTER TABLE t_grupos ADD fecha_creacion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_grupos SET fecha_creacion_n = FROM_TZ(CAST(fecha_creacion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_grupos SET fecha_creacion = null;
ALTER TABLE t_grupos MODIFY fecha_creacion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_grupos SET fecha_creacion = fecha_creacion_n;
ALTER TABLE t_grupos DROP COLUMN fecha_creacion_n;
