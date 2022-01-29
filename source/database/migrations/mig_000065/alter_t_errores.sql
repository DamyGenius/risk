-- Add/modify columns 
alter table T_ERRORES add id_idioma NUMBER(3);
alter table T_ERRORES add id_pais NUMBER(3);
-- Add comments to the columns 
comment on column T_ERRORES.id_idioma
  is 'Idioma del error';
comment on column T_ERRORES.id_pais
  is 'Pais del error';
-- Drop primary, unique and foreign key constraints 
alter table T_ERRORES
  drop constraint PK_ERRORES cascade;
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ERRORES
  add constraint UK_ERRORES unique (ID_ERROR, ID_IDIOMA, ID_PAIS);
alter table T_ERRORES
  add constraint FK_ERRORES_IDIOMAS foreign key (ID_IDIOMA)
  references T_IDIOMAS (ID_IDIOMA);
alter table T_ERRORES
  add constraint FK_ERRORES_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
