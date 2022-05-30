prompt Importing table t_significados...
set feedback off
set define off
insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', 'M', 'MENSUAL', 'M,S,D,12H,6H,2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', 'S', 'SEMANAL', 'S,D,12H,6H,2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', 'D', 'DIARIA', 'D,12H,6H,2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', '12H', 'CADA 12 HORAS', '12H,6H,2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', '6H', 'CADA 6 HORAS', '6H,2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', '2H', 'CADA 2 HORAS', '2H,H', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('FRECUENCIA_MONITOREO', 'H', 'CADA HORA', 'H', 'S');

prompt Done.
