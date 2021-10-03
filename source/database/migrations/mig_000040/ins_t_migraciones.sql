prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000040', 'Agregar parámetro de torneo a servicio listar_grupos.');

prompt Done.
