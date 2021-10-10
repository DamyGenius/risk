alter table T_CLUBES add tipo VARCHAR2(1) default 'C' not null;
comment on column T_CLUBES.tipo
  is 'Tipo de equipo (C-Club, S-Selección)';
alter table T_CLUBES
  add constraint CK_CLUBES_TIPO
  check (TIPO IN ('C', 'S'));
