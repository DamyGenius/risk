prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000015', 'Agregar guión (-) a expresión regular para validación de alias de usuario.');

prompt Done.
