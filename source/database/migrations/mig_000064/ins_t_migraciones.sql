prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000064', 'Variables de sistema: país, idioma y zona horaria.');

prompt Done.
