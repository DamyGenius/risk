-- Add/modify columns 
alter table T_DISPOSITIVOS add id_pais NUMBER(3);
-- Add comments to the columns 
comment on column T_DISPOSITIVOS.id_pais
  is 'Pais del dispositivo';
-- Add constraints
alter table T_DISPOSITIVOS
  add constraint FK_DISPOSITIVOS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
