prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000116', 'Fix en creación de trabajo de pre-cierre y cierre de predicciones.');

prompt Done.
