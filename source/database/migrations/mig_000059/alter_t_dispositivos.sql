-- Add/modify columns 
alter table T_DISPOSITIVOS add zona_horaria VARCHAR2(8);
-- Add comments to the columns 
comment on column T_DISPOSITIVOS.zona_horaria
  is 'Zona horaria del dispositivo (en horas)';
