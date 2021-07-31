prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000013', 'Agregar campo estado_juego a t_partidos.');

prompt Done.
