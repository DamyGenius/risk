prompt Importing table t_parametros...
set feedback off
set define off
insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('METODO_VALIDACION_CREDENCIALES', 'Método de validación de credenciales', 'RISK');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ENVIO_CORREOS_ACTIVO', 'Indica si está activo el envío de correos electrónicos (E-mail) (S/N)', 'N');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ENVIO_MENSAJES_ACTIVO', 'Indica si está activo el envío de mensajes de texto (SMS) (S/N)', 'N');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ENVIO_NOTIFICACIONES_ACTIVO', 'Indica si está activo el envío de notificaciones push (S/N)', 'N');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CONFIRMACION_DIRECCION_CORREO', 'Indica si está activa la confirmación de correo electrónico de usuarios (S/N)', 'S');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ESTADOS_ACTIVOS_USUARIO', 'Estados de usuario válidos para inicio de sesión. Separadas por coma. Ej.: A,P', 'A,P');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('BASE_DATOS_PRODUCCION', 'Nombre de la Base de Datos del entorno de Producción', 'RISK');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CANTIDAD_MAXIMA_SESIONES_USUARIO', 'Cantidad máxima permitida de sesiones activas por usuario', '2');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CLAVE_ENCRIPTACION_DESENCRIPTACION', 'Clave para encriptación y desencriptación. Generar con la función k_autenticacion.f_randombytes_hex', '26B9257BF16323A5919FAA48ABB7C575A50996698A0576C0DE0EE312AF6D2D60');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('CLAVE_VALIDACION_ACCESS_TOKEN', 'Clave de validación del Access Token. Generar con la función k_autenticacion.f_randombytes_base64', '9vVzzZbbUCcYE3cDnE+IVMrLF+8X8TPyK2cmC3Vu7M0=');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NOMBRE_ROL_DEFECTO', 'Nombre del Rol que se agrega por defecto a un usuario cuando se registra', 'USUARIO');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_DIRECCION_CORREO', 'Expresión Regular para validación de direcciones de correo electrónico', '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_NUMERO_TELEFONO', 'Expresión Regular para validación de números de teléfono', '^\+5959[6-9][1-9][0-9]{6}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_EXPIRACION_ACCESS_TOKEN', 'Tiempo de expiración del Access Token en segundos', '900');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_EXPIRACION_REFRESH_TOKEN', 'Tiempo de expiración del Refresh Token en horas', '720');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('URL_SERVICIOS_PRODUCCION', 'URL base de los Servicios Web del entorno de Producción', 'https://ne-project-api.azurewebsites.net');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA', 'Cantidad por defecto de elementos por página en paginación de listas', '30');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA', 'Cantidad máxima permitida de elementos por página en paginación de listas', '100');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('DIRECCION_CORREO_PRUEBAS', 'Dirección de correo electrónico para pruebas', 'demouser@risk.com');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NUMERO_TELEFONO_PRUEBAS', 'Número de teléfono para pruebas', '+595991000000');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('DIRECCION_CORREO_REMITENTE', 'Dirección de correo del remitente para mensajería', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('NUMERO_TELEFONO_REMITENTE', 'Número de teléfono del remitente para mensajería', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('GOOGLE_IDENTIFICADOR_CLIENTE', 'Identificador del cliente de los Servicios Web de Google', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('GOOGLE_EMISOR_TOKEN', 'Emisor del token de Google', 'accounts.google.com');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REPORTE_FORMATO_SALIDA_DEFECTO', 'Formato de salida por defecto para reportes', 'PDF');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('SUSCRIPCION_PRUEBAS', 'Tag o expresión destino para pruebas de notificaciones push', 'test');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_ALIAS_USUARIO', 'Expresión Regular para validación de alias de usuario', '^[A-Za-z0-9_]{1,50}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('TIEMPO_TOLERANCIA_VALIDAR_OTP', 'Tiempo de tolerancia para validación de OTP en segundos', '120');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ESTADO_IMPORTACION_PARTIDOS', 'Indica el estado de la importación de Partidos de Fantasy (E-En Ejecución/D-Detenido)', 'D');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('ZONA_HORARIA_PRODUCCION', 'Zona horaria  del entorno de Producción', '-3:0');

prompt Done.
