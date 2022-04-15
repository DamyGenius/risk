prompt Importing table t_errores...
set feedback off
set define off
insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000021', 'Failed to follow', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000021', 'Error al seguir', 'API', null, null);

prompt Done.
