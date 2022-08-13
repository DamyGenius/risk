prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000121', 'Retornar datos del torneo actual en servicio de listar divisiones.');

prompt Done.
