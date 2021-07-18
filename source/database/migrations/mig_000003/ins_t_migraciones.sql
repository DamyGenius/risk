prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000003', 'Flexibilizar políticas de validación de claves de acceso');

prompt Done.
