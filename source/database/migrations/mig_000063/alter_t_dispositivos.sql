alter table T_DISPOSITIVOS add id_idioma NUMBER(3);
comment on column T_DISPOSITIVOS.id_idioma
  is 'Idioma del dispositivo';
alter table T_DISPOSITIVOS
  add constraint FK_DISPOSITIVOS_IDIOMAS foreign key (ID_IDIOMA)
  references T_IDIOMAS (ID_IDIOMA);
