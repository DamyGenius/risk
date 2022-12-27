prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000142', 'Tabla temporal de equipos pendientes de alta.');

prompt Done.
