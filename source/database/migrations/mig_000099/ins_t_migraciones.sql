prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000099', 'Recuperar zona horaria al consultar datos del fixture de un torneo.');

prompt Done.
