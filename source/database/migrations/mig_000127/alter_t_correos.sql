--fecha
alter table T_CORREOS add fecha TIMESTAMP(2) WITH TIME ZONE;
comment on column T_CORREOS.fecha
  is 'Fecha del correo electrónico';

--fecha_envio
alter table T_CORREOS add fecha_envio_n TIMESTAMP(0) WITH TIME ZONE;
update T_CORREOS set fecha_envio_n = FROM_TZ(CAST(fecha_envio AS TIMESTAMP), 'America/Asuncion');
update T_CORREOS set fecha_envio = null;
alter table T_CORREOS modify fecha_envio TIMESTAMP(0) WITH TIME ZONE;
update T_CORREOS set fecha_envio = fecha_envio_n;
alter table T_CORREOS drop column fecha_envio_n;
 
