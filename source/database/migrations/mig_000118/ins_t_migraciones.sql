prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000118', 'Retornar nombre de los clubes en listar jornadas, fases y partidos cuando la aplicación es IOS.');

prompt Done.
