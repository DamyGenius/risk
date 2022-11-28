prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000137', 'Invitar a usuarios de otro grupo al crear uno nuevo.');

prompt Done.
