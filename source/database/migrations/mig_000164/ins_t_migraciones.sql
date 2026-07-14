prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000164', 'Agregar consola de logs. Agregar logs de validación de imagenes.');

prompt Done.
