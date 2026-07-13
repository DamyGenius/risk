prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000161', 'Agregar URLs de imagenes en notificaciones de partido.');

prompt Done.