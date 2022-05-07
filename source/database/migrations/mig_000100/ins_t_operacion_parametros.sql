prompt Importing table t_operacion_parametros...
set feedback off
set define off
insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'TORNEO', '0.1.0', 1, 'S', 'S', null, null, 'S', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'FASE', '0.1.0', 2, 'S', 'N', null, null, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'GRUPO', '0.1.0', 3, 'S', 'N', null, null, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'JORNADA', '0.1.0', 4, 'S', 'N', null, null, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'USUARIO', '0.1.0', 5, 'S', 'S', null, null, 'N', null, null, null, null);

insert into t_operacion_parametros (ID_OPERACION, NOMBRE, VERSION, ORDEN, ACTIVO, TIPO_DATO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, DETALLE, VALORES_POSIBLES)
values (78, 'INCLUIR_PARTIDOS', '0.1.0', 6, 'S', 'S', null, null, 'N', null, null, null, null);

prompt Done.
