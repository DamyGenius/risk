prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000126', 'Fix al listar divisiones si suscripto y siguiendo.');

prompt Done.
