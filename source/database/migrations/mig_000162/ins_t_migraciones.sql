prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000162', 'Ampliar campos de parametros, usuarios y sesiones.');

prompt Done.
