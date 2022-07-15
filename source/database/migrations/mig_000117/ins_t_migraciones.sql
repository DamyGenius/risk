prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000117', 'Registrar grupos de la división del torneo, si no existen.');

prompt Done.
