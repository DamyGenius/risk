--fecha_expiracion
ALTER TABLE t_invitaciones ADD fecha_expiracion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_expiracion_n = FROM_TZ(CAST(fecha_expiracion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_invitaciones SET fecha_expiracion = null;
ALTER TABLE t_invitaciones MODIFY fecha_expiracion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_expiracion = fecha_expiracion_n;
ALTER TABLE t_invitaciones DROP COLUMN fecha_expiracion_n;
--fecha_creacion
ALTER TABLE t_invitaciones ADD fecha_creacion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_creacion_n = FROM_TZ(CAST(fecha_creacion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_invitaciones SET fecha_creacion = null;
ALTER TABLE t_invitaciones MODIFY fecha_creacion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_creacion = fecha_creacion_n;
ALTER TABLE t_invitaciones DROP COLUMN fecha_creacion_n;
--fecha_aceptacion
ALTER TABLE t_invitaciones ADD fecha_aceptacion_n TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_aceptacion_n = FROM_TZ(CAST(fecha_aceptacion AS TIMESTAMP), 'ETC/UTC');
UPDATE t_invitaciones SET fecha_aceptacion = null;
ALTER TABLE t_invitaciones MODIFY fecha_aceptacion TIMESTAMP(0) WITH TIME ZONE;
UPDATE t_invitaciones SET fecha_aceptacion = fecha_aceptacion_n;
ALTER TABLE t_invitaciones DROP COLUMN fecha_aceptacion_n;
