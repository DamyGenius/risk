-- Add/modify columns 
alter table T_TORNEOS add fecha_ultima_importacion TIMESTAMP(0) WITH TIME ZONE;
-- Add comments to the columns 
comment on column T_TORNEOS.fecha_ultima_importacion
  is 'Fecha de la última importación.';
