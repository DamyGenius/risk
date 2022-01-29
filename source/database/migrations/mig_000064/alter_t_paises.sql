alter table T_PAISES
  add constraint UK_PAISES_ISO_ALPHA_2 unique (ISO_ALPHA_2);
alter table T_PAISES
  add constraint UK_PAISES_ISO_ALPHA_3 unique (ISO_ALPHA_3);
alter table T_PAISES
  add constraint UK_PAISES_ISO_NUMERIC unique (ISO_NUMERIC);
