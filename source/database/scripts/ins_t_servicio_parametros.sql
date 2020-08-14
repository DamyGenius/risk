prompt Importing table t_servicio_parametros...
set feedback off
set define off

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (0, 'DIRECCION_IP', 'I', 'S', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (0, 'CLAVE_APLICACION', 'I', 'S', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (0, 'ACCESS_TOKEN', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (0, 'USUARIO', 'I', 'S', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (1, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (1, 'CLAVE', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (1, 'TIPO_CLAVE', 'I', 'S', null, 'N', 'A', 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (2, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (2, 'ACCESS_TOKEN', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (2, 'REFRESH_TOKEN', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (2, 'TOKEN_DISPOSITIVO', 'I', 'S', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (3, 'ACCESS_TOKEN', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (3, 'ESTADO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'CLAVE', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'NOMBRE', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'APELLIDO', 'I', 'S', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'DIRECCION_CORREO', 'I', 'S', null, 'S', null, 'S', 5, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (4, 'NUMERO_TELEFONO', 'I', 'S', null, 'N', null, 'S', 6, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (5, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (5, 'CLAVE', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (5, 'TIPO_CLAVE', 'I', 'S', null, 'N', 'A', 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (6, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (6, 'CLAVE_ANTIGUA', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (6, 'CLAVE_NUEVA', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (6, 'TIPO_CLAVE', 'I', 'S', null, 'N', 'A', 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (7, 'ACCESS_TOKEN', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (8, 'PARAMETRO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (9, 'DOMINIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (9, 'CODIGO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (10, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (11, 'ACCESS_TOKEN_ANTIGUO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (11, 'REFRESH_TOKEN_ANTIGUO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (11, 'ACCESS_TOKEN_NUEVO', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (11, 'REFRESH_TOKEN_NUEVO', 'I', 'S', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (12, 'CLAVE_APLICACION', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (14, 'DISPOSITIVO', 'I', 'O', 'Y_DISPOSITIVO', 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (16, 'ID_PAIS', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (16, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (17, 'TIPO_TOKEN', 'I', 'S', null, 'N', 'A', 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (18, 'TABLA', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (18, 'CAMPO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (18, 'REFERENCIA', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (18, 'VERSION', 'I', 'N', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (19, 'TABLA', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (19, 'CAMPO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (19, 'REFERENCIA', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (19, 'ARCHIVO', 'I', 'O', 'Y_ARCHIVO', 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (20, 'FORMATO', 'I', 'S', null, 'S', 'PDF', 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (21, 'TOKEN_DISPOSITIVO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (22, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (22, 'ESTADO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (23, 'TIPO_MENSAJERIA', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (23, 'DESTINO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (24, 'SECRET', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (24, 'OTP', 'I', 'N', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (25, 'ID_DEPARTAMENTO', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (25, 'ID_PAIS', 'I', 'N', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (25, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (26, 'ID_CIUDAD', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (26, 'ID_PAIS', 'I', 'N', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (26, 'ID_DEPARTAMENTO', 'I', 'N', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (26, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (27, 'ID_BARRIO', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (27, 'ID_PAIS', 'I', 'N', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (27, 'ID_DEPARTAMENTO', 'I', 'N', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (27, 'ID_CIUDAD', 'I', 'N', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (27, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (28, 'REFERENCIA', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (29, 'DOMINIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (29, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (30, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (31, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (32, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (33, 'TIPO_MENSAJERIA', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (33, 'ID_MENSAJERIA', 'I', 'N', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (33, 'ESTADO', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (33, 'RESPUESTA_ENVIO', 'I', 'S', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (40, 'ID_CLUB', 'I', 'S', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (40, 'ID_DIVISION', 'I', 'S', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (41, 'DESCRIPCION', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (41, 'TIPO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (41, 'ID_JORNADA_INICIO', 'I', 'N', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (41, 'TODOS_INVITAN', 'I', 'S', null, 'S', 'N', 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (41, 'ID_CLUB', 'I', 'S', null, 'N', null, 'S', 5, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'USUARIO_ANTIGUO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'USUARIO_NUEVO', 'I', 'S', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'NOMBRE', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'APELLIDO', 'I', 'S', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'DIRECCION_CORREO', 'I', 'S', null, 'N', null, 'S', 5, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (42, 'NUMERO_TELEFONO', 'I', 'S', null, 'N', null, 'S', 6, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (43, 'PARTIDO', 'I', 'N', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (43, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (43, 'GOLES_CLUB_LOCAL', 'I', 'N', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (43, 'GOLES_CLUB_VISITANTE', 'I', 'N', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (43, 'ID_SINCRONIZACION', 'I', 'N', null, 'S', null, 'S', 5, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (44, 'PARTIDO', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (44, 'TORNEO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (44, 'ESTADO', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (45, 'PARTIDO', 'I', 'N', null, 'N', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (45, 'TORNEO', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (45, 'ESTADO', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (45, 'USUARIO', 'I', 'S', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'ID_GRUPO', 'I', 'N', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'DESCRIPCION', 'I', 'S', null, 'S', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'TIPO', 'I', 'S', null, 'S', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'ID_JORNADA_INICIO', 'I', 'N', null, 'S', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'TODOS_INVITAN', 'I', 'S', null, 'S', 'N', 'S', 5, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (46, 'ID_CLUB', 'I', 'S', null, 'N', null, 'S', 6, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (47, 'TORNEO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (47, 'JORNADA', 'I', 'N', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (47, 'ESTADO', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (47, 'USUARIO', 'I', 'S', null, 'N', null, 'S', 4, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (48, 'ID_GRUPO', 'I', 'N', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (49, 'MIS_GRUPOS', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (49, 'TIPO_GRUPO', 'I', 'S', null, 'N', null, 'S', 2, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (49, 'ACEPTADO', 'I', 'S', null, 'N', null, 'S', 3, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (49, 'PAGINA_PARAMETROS', 'I', 'O', 'Y_PAGINA_PARAMETROS', 'N', null, 'S', 10, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (50, 'SERVICIO', 'I', 'S', null, 'S', null, 'S', 1, null, null);

insert into t_servicio_parametros (ID_SERVICIO, NOMBRE, DIRECCION, TIPO_DATO, FORMATO, OBLIGATORIO, VALOR_DEFECTO, ACTIVO, ORDEN, ETIQUETA, LONGITUD_MAXIMA)
values (51, 'ID_GRUPO', 'I', 'N', null, 'S', null, 'S', 1, null, null);

prompt Done.
