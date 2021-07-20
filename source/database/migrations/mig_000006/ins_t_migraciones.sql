prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000006', 'Envío de correo de invitación a descargar la app al solicitar amistad o invitar a grupo a correo no catastrado.');

prompt Done.
