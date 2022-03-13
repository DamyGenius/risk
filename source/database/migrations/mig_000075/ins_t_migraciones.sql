prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000075', 'Retornar Estado de Juego en servicios de Partidos, Predicciones y Jornadas.');

prompt Done.
