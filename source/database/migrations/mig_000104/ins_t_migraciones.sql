prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000104', 'Monitoreo de sesiones expiradas.');

prompt Done.
