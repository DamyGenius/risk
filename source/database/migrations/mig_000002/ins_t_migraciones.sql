prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000002', 'Considerar como valor 0 los goles locales y visitantes cuando se recibe valor nulo.');

prompt Done.
