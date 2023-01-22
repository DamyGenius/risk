-- Add/modify columns 
alter table T_USUARIO_CLAVES add fecha_expiracion TIMESTAMP(2) WITH TIME ZONE;
-- Add comments to the columns 
comment on column T_USUARIO_CLAVES.fecha_expiracion
  is 'Fecha de expiracion de la clave';
