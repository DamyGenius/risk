prompt Importing table t_parametros...
set feedback off
set define off
insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR, ID_DOMINIO)
values ('TIEMPO_EXPIRACION_CLAVE_TEMPORAL', 'Tiempo de expiración de la clave temporal en horas', '1', null);

prompt Done.
