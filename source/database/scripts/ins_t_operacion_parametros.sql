prompt Importing table t_operacion_parametros...
set feedback off
set define off

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (0, 'DIRECCION_IP', 1, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (0, 'CLAVE_APLICACION', 2, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (0, 'ACCESS_TOKEN', 3, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (0, 'USUARIO', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (1, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (1, 'CLAVE', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (1, 'TIPO_CLAVE', 3, 'S', 'S', null, null, 'N', 'A', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (2, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (2, 'ACCESS_TOKEN', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (2, 'REFRESH_TOKEN', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (2, 'TOKEN_DISPOSITIVO', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (3, 'ACCESS_TOKEN', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (3, 'ESTADO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'CLAVE', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'NOMBRE', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'APELLIDO', 4, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'DIRECCION_CORREO', 5, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'NUMERO_TELEFONO', 6, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (4, 'ID_CLUB', 7, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (5, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (5, 'CLAVE', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (5, 'TIPO_CLAVE', 3, 'S', 'S', null, null, 'N', 'A', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (6, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (6, 'CLAVE_ANTIGUA', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (6, 'CLAVE_NUEVA', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (6, 'TIPO_CLAVE', 4, 'S', 'S', null, null, 'N', 'A', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (7, 'ACCESS_TOKEN', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (8, 'PARAMETRO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (9, 'DOMINIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (9, 'CODIGO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (10, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (11, 'ACCESS_TOKEN_ANTIGUO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (11, 'REFRESH_TOKEN_ANTIGUO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (11, 'ACCESS_TOKEN_NUEVO', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (11, 'REFRESH_TOKEN_NUEVO', 4, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (12, 'CLAVE_APLICACION', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (14, 'DISPOSITIVO', 1, 'S', 'O', 'Y_DISPOSITIVO', null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (15, 'TOKEN_DISPOSITIVO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (15, 'LATITUD', 2, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (15, 'LONGITUD', 3, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (16, 'ID_PAIS', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (16, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (17, 'TIPO_TOKEN', 1, 'S', 'S', null, null, 'N', 'A', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (18, 'TABLA', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (18, 'CAMPO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (18, 'REFERENCIA', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (18, 'VERSION', 4, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (19, 'TABLA', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (19, 'CAMPO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (19, 'REFERENCIA', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (19, 'ARCHIVO', 4, 'S', 'O', 'Y_ARCHIVO', null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (20, 'FORMATO', 1, 'S', 'S', null, 4, 'S', 'PDF', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (21, 'TOKEN_DISPOSITIVO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (22, 'USUARIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (22, 'ESTADO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (23, 'TIPO_MENSAJERIA', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (23, 'DESTINO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (24, 'SECRET', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (24, 'OTP', 2, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (25, 'ID_DEPARTAMENTO', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (25, 'ID_PAIS', 2, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (25, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (26, 'ID_CIUDAD', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (26, 'ID_PAIS', 2, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (26, 'ID_DEPARTAMENTO', 3, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (26, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (27, 'ID_BARRIO', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (27, 'ID_PAIS', 2, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (27, 'ID_DEPARTAMENTO', 3, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (27, 'ID_CIUDAD', 4, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (27, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (28, 'REFERENCIA', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (29, 'DOMINIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (29, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (30, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (31, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (32, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (33, 'TIPO_MENSAJERIA', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (33, 'ID_MENSAJERIA', 2, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (33, 'ESTADO', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (33, 'RESPUESTA_ENVIO', 4, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (34, 'TIPO_MENSAJERIA', 1, 'S', 'S', null, 1, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (34, 'ESTADO', 2, 'S', 'S', null, 1, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (36, 'FORMATO', 1, 'S', 'S', null, 4, 'S', 'PDF', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (36, 'DOMINIO', 2, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (40, 'ID_CLUB', 1, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (40, 'ID_DIVISION', 2, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (41, 'DESCRIPCION', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (41, 'TIPO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (41, 'ID_JORNADA_INICIO', 3, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (41, 'TODOS_INVITAN', 4, 'S', 'S', null, null, 'S', 'N', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (41, 'ID_CLUB', 5, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'USUARIO_ANTIGUO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'USUARIO_NUEVO', 2, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'NOMBRE', 3, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'APELLIDO', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'DIRECCION_CORREO', 5, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'NUMERO_TELEFONO', 6, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (42, 'ID_CLUB', 7, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (43, 'PARTIDO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (43, 'USUARIO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (43, 'GOLES_CLUB_LOCAL', 3, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (43, 'GOLES_CLUB_VISITANTE', 4, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (43, 'ID_SINCRONIZACION', 5, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (44, 'PARTIDO', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (44, 'TORNEO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (44, 'ESTADO', 3, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'PARTIDO', 1, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'TORNEO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'USUARIO', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'ESTADOS_PARTIDOS', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'ESTADOS_PREDICCIONES', 5, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'PAGINA_PARAMETROS', 6, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (45, 'ORDEN', 7, 'S', 'S', null, 4, 'N', 'ASC', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'ID_GRUPO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'DESCRIPCION', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'TIPO', 3, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'ID_JORNADA_INICIO', 4, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'TODOS_INVITAN', 5, 'S', 'S', null, null, 'S', 'N', null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (46, 'ID_CLUB', 6, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (47, 'TORNEO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (47, 'JORNADA', 2, 'S', 'N', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (47, 'ESTADO', 3, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (47, 'USUARIO', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (47, 'INCLUIR_PARTIDOS', 5, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (48, 'ID_GRUPO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (49, 'MIS_GRUPOS', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (49, 'TIPO_GRUPO', 2, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (49, 'ACEPTADO', 3, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (49, 'INCLUIR_USUARIOS', 4, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (49, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (50, 'SERVICIO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (51, 'ID_GRUPO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (52, 'ID_GRUPO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (52, 'USUARIO', 2, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (53, 'ID_GRUPO', 1, 'S', 'N', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (53, 'RESPUESTA', 2, 'S', 'S', null, 8, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (55, 'ID_PARTIDO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (56, 'ID_PARTIDO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (57, 'ID_PARTIDO', 1, 'S', 'S', null, null, 'S', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (58, 'ID_ERROR', 1, 'S', 'S', null, null, 'N', null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE)
values (58, 'PAGINA_PARAMETROS', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null);

prompt Done.
