prompt Importing table t_errores...
set feedback off
set define off

insert into t_errores (ID_ERROR, MENSAJE)
values ('ser0002', 'Error al procesar par�metros del servicio');

insert into t_errores (ID_ERROR, MENSAJE)
values ('ser0003', 'Operaci�n no autorizada');

insert into t_errores (ID_ERROR, MENSAJE)
values ('ser9999', 'Error inesperado');

prompt Done.
