prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000140', 'Retornar URL de encuesta en servicio de calificaciones.');

prompt Done.
