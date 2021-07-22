prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000008', 'Actualiza cantidad máxima de sesiones activas por usuario.');

prompt Done.
