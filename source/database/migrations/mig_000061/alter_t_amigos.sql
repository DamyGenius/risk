--fecha_creacion
ALTER TABLE t_amigos ADD fecha_creacion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_amigos SET fecha_creacion_n = FROM_TZ(CAST(fecha_creacion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_amigos SET fecha_creacion = null;
ALTER TABLE t_amigos MODIFY fecha_creacion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_amigos SET fecha_creacion = fecha_creacion_n;
ALTER TABLE t_amigos DROP COLUMN fecha_creacion_n;
--fecha_aceptacion
ALTER TABLE t_amigos ADD fecha_aceptacion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_amigos SET fecha_aceptacion_n = FROM_TZ(CAST(fecha_aceptacion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_amigos SET fecha_aceptacion = null;
ALTER TABLE t_amigos MODIFY fecha_aceptacion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_amigos SET fecha_aceptacion = fecha_aceptacion_n;
ALTER TABLE t_amigos DROP COLUMN fecha_aceptacion_n;
