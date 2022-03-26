prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000080', 'Guardar y eliminar escudos de clubes de un partido en juego.');

prompt Done.
