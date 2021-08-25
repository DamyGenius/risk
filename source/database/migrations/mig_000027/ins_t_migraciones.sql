prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000027', 'Eliminar fecha de expiración de suscripciones a notificaciones push.');

prompt Done.
