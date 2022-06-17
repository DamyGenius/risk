-- Drop primary, unique and foreign key constraints 
alter table T_TORNEOS
  drop constraint FK_TORNEOS_URLS;
-- Drop columns 
alter table T_TORNEOS drop column id_url;
alter table T_TORNEOS drop column id_importacion;
-- Add/modify columns 
alter table T_TORNEOS add id_importacion NUMBER(15);
alter table T_TORNEOS add desc_importacion VARCHAR2(200);
-- Add comments to the columns 
comment on column T_TORNEOS.importado
  is '¿El torneo ingresa al proceso de importación? (S/N)';
comment on column T_TORNEOS.id_importacion
  is 'Identificador del torneo importado.';
comment on column T_TORNEOS.desc_importacion
  is 'Descripción del torneo importado.';

