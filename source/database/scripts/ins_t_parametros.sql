prompt Importing table t_parametros...
set feedback off
set define off

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('BASE_DATOS_PRODUCCION', 'Nombre de la Base de Datos del entorno de Producci�n', 'RISK');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CANTIDAD_MAXIMA_SESIONES_USUARIO', 'Cantidad m�xima permitida de sesiones activas por usuario', '2');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CLAVE_VALIDACION_ACCESS_TOKEN', 'Clave de validaci�n del Access Token', '9vVzzZbbUCcYE3cDnE+IVMrLF+8X8TPyK2cmC3Vu7M0=');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('LONGITUD_MINIMA_CLAVE_ACCESO', 'Longitud m�nima permitida para clave de acceso', '8');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('LONGITUD_MINIMA_CLAVE_TRANSACCIONAL', 'Longitud m�nima permitida para clave transaccional', '6');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NOMBRE_ROL_DEFECTO', 'Nombre del Rol que se agrega por defecto a un usuario cuando se registra', 'USUARIO');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_DIRECCION_CORREO', 'Expresi�n Regular para validaci�n de direcciones de correo electr�nico', '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_NUMERO_TELEFONO', 'Expresi�n Regular para validaci�n de n�meros de tel�fono', '^\+5959[6-9][1-9][0-9]{6}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_EXPIRACION_ACCESS_TOKEN', 'Tiempo de expiraci�n del Access Token en segundos', '300');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_EXPIRACION_REFRESH_TOKEN', 'Tiempo de expiraci�n del Refresh Token en horas', '5');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('URL_SERVICIOS_PRODUCCION', 'URL base de los Servicios Web del entorno de Producci�n', 'http://localhost:5000');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA', 'Cantidad por defecto de elementos por p�gina en paginaci�n de listas', '30');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA', 'Cantidad m�xima permitida de elementos por p�gina en paginaci�n de listas', '100');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('DIRECCION_CORREO_PRUEBAS', 'Direcci�n de correo electr�nico para pruebas', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NUMERO_TELEFONO_PRUEBAS', 'N�mero de tel�fono para pruebas', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('DIRECCION_CORREO_REMITENTE', 'Direcci�n de correo del remitente para mensajer�a', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NUMERO_TELEFONO_REMITENTE', 'N�mero de tel�fono del remitente para mensajer�a', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REPORTE_FORMATO_SALIDA_DEFECTO', 'Formato de salida por defecto para reportes', 'PDF');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('SUSCRIPCION_PRUEBAS', 'Tag o expresi�n destino para pruebas de notificaciones push', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_ALIAS_USUARIO', 'Expresi�n Regular para validaci�n de alias de usuario', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_TOLERANCIA_VALIDAR_OTP', 'Tiempo de tolerancia para validaci�n de OTP en segundos', '120');

prompt Done.
