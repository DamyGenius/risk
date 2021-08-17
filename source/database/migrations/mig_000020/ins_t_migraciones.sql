prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000020', 'Cantidad de predicciones en listado de predicciones.');

prompt Done.
