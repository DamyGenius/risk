prompt Importing table t_operaciones...
set feedback off
set define off
insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (71, 'S', 'ENVIAR_MENSAJE_AMIGO', 'FAN', 'S', null, '0.1.0', 1, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (72, 'S', 'LISTAR_MENSAJES_AMIGO', 'FAN', 'S', null, '0.1.0', 1, null);

prompt Done.
