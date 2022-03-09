prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000073', 'Ajuste para listar grupos de usuarios que ya no forman parte.');

prompt Done.
