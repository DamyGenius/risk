-- Add/modify columns 
alter table T_DIVISIONES add id_url VARCHAR2(3);
alter table T_DIVISIONES add canal_importacion VARCHAR2(50);
alter table T_DIVISIONES add importado VARCHAR2(1) default 'N';
alter table T_DIVISIONES add id_importacion_torneo number(15);
alter table T_DIVISIONES add desc_importacion_torneo VARCHAR2(200);
-- Add comments to the columns 
comment on column T_DIVISIONES.id_division
  is 'Identificador de la división.';
comment on column T_DIVISIONES.descripcion
  is 'Descripción de la división.';
comment on column T_DIVISIONES.id_pais
  is 'Identificador de país de la división.';
comment on column T_DIVISIONES.detalle
  is 'Detalle de la división.';
comment on column T_DIVISIONES.descripcion_corta
  is 'Descripción corta de la división.';
comment on column T_DIVISIONES.id_url
  is 'Identificador de la URL de la división.';
comment on column T_DIVISIONES.canal_importacion
  is 'Canal de importación de la división.';
comment on column T_DIVISIONES.importado
  is '¿La división ingresa al proceso de importación? (S/N)';
comment on column T_DIVISIONES.id_importacion_torneo
  is 'Identificador del torneo actual importado.';
comment on column T_DIVISIONES.desc_importacion_torneo
  is 'Descripción del torneo actual importado.';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_DIVISIONES
  add constraint FK_DIVISIONES_URLS foreign key (ID_URL)
  references t_importador_urls (ID_URL);
