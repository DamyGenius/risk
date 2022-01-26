prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000060', 'Convertir campos Date a Timestamp en tabla de invitaciones.');

prompt Done.
