-- Add/modify columns 
alter table T_DIVISIONES add tipo_equipos VARCHAR2(1);
-- Add comments to the columns 
comment on column T_DIVISIONES.tipo_equipos
  is 'Tipo de equipos (C-Club, S-Selección)';
alter table T_DIVISIONES
  add constraint CK_DIVISIONES_TIPO_EQUIPOS
  check (TIPO_EQUIPOS IN ('C', 'S'));
