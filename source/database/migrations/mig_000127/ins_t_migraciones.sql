prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000127', 'Convertir campo fecha_envio de Date a Timestamp y agregar campo fecha como Timestamp en tabla de correos.');

prompt Done.
