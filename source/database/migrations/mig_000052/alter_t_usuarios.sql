-- Add/modify columns 
alter table T_USUARIOS add prueba VARCHAR2(1);
alter table T_USUARIOS modify prueba default 'N';
-- Add comments to the columns 
comment on column T_USUARIOS.prueba
  is '¿Es usuario de prueba?';
