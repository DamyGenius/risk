prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000096', 'Convertir campos Date a Timestamp en tabla de partidos.');

prompt Done.
