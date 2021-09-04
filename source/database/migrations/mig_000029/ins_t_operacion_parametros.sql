prompt Importing table t_operacion_parametros...
set feedback off
set define off
insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (71, 'ID_AMISTAD', '0.1.0', 1, 'S', 'N', null, null, 'S', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (71, 'CONTENIDO', '0.1.0', 2, 'S', 'S', null, null, 'S', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (71, 'REF_MENSAJE', '0.1.0', 3, 'S', 'N', null, null, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (72, 'ID_AMISTAD', '0.1.0', 1, 'S', 'N', null, null, 'S', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (72, 'PAGINA_PARAMETROS', '0.1.0', 10, 'S', 'O', 'Y_PAGINA_PARAMETROS', null, 'N', null, null, null, null);

prompt Done.
