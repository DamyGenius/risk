alter table T_MONITOREOS add frecuencia VARCHAR2(3) default 'D' not null;
comment on column T_MONITOREOS.frecuencia
  is 'Frecuencia de ejecución del monitoreo';
alter table T_MONITOREOS
  drop constraint CK_MONITOREOS_FRECUENCIA;
alter table T_MONITOREOS
  add constraint CK_MONITOREOS_FRECUENCIA
  check (FRECUENCIA IN ('H', '2H', '6H', '12H', 'D', 'S', 'M'));
