prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000066', 'Centralizar definición de parámetros de la sesión para servicios y reportes.');

prompt Done.
