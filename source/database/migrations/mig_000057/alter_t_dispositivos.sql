-- Add/modify columns 
alter table T_DISPOSITIVOS add version_aplicacion VARCHAR2(100);
-- Add comments to the columns 
comment on column T_DISPOSITIVOS.version_aplicacion
  is 'Version de la aplicacion';
