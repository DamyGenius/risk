prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000082', 'Ajuste para consulta de web service de imagenes cuando el request supera los 32.000 bytes.');

prompt Done.
