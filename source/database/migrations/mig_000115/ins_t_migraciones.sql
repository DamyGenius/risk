prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000115', 'Mejora en manejo de importación de partidos en juego por medio de llaveo de parámetro.');

prompt Done.
