prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000017', 'Limpiar alias de usuario en caso de ser usuario externo para catastro.');

prompt Done.
