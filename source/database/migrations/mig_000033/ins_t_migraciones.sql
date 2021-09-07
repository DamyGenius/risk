prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000033', 'Mejora en logs al enviar mensaje grupal e individual.');

prompt Done.
