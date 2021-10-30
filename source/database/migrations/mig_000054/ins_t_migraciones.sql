prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000054', 'Notificación por correo en caso de error en importación de partidos.');

prompt Done.
