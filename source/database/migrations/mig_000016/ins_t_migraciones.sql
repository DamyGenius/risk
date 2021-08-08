prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000016', 'Mensaje de caracteres inválidos específicos en validación de alias de usuario.');

prompt Done.
