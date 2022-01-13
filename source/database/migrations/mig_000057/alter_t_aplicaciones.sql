-- Add/modify columns 
alter table T_APLICACIONES add version_minima VARCHAR2(100);
-- Add comments to the columns 
comment on column T_APLICACIONES.version_minima
  is 'Version minima de la aplicacion';
