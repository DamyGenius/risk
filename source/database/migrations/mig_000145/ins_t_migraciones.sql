prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000145', 'Retornar estado de clave de acceso en servicio de datos del usuario.');

prompt Done.
