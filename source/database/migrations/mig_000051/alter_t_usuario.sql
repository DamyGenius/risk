-- Add/modify columns 
alter table T_USUARIOS add fecha_creacion date;
-- Add comments to the columns 
comment on column T_USUARIOS.fecha_creacion
  is 'Fecha de creacion del usuario';
