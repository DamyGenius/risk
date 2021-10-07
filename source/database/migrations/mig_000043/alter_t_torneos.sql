alter table T_TORNEOS add id_url VARCHAR2(3);
alter table T_TORNEOS add id_importacion VARCHAR2(50);
alter table T_TORNEOS
  add constraint FK_TORNEOS_URLS foreign key (ID_URL)
  references T_IMPORTADOR_URLS (ID_URL);
