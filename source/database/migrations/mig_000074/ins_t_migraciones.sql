prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000074', 'Recibir parámetro de contexto token_dispositivo en la Base de Datos.');

prompt Done.
