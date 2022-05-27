prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000105', 'Monitoreo de error en versión de driver del servicio de datos.');

prompt Done.
