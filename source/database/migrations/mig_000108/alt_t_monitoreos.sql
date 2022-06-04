-- Add/modify columns 
alter table T_MONITOREOS add id_usuario_responsable NUMBER(10);
-- Add comments to the columns 
comment on column T_MONITOREOS.id_usuario_responsable
  is 'Identificador del usuario responsable';
