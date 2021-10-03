prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000041', ' Agregar id_pais a t_clubes.');

prompt Done.
