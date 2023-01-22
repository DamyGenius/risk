prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000144', 'Recuperar clave de usuario de Risk.');

prompt Done.
