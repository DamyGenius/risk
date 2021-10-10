prompt Importing table t_operacion_parametros...
set feedback off
set define off
insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (40, 'TIPO', '0.1.0', 3, 'S', 'S', null, 1, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (40, 'ID_PAIS', '0.1.0', 4, 'S', 'N', null, null, 'N', null, null, null, null);

prompt Done.
