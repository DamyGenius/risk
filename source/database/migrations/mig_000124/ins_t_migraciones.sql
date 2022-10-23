prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000124', 'Recibir como parámetro al listar clubes el código ISO Alpha 2 del país.');

prompt Done.
