prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000005', 'Registrar usuario en grupo general cuando nace activo.');

prompt Done.
