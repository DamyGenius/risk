prompt Importing table t_operaciones...
set feedback off
set define off
insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (69, 'T', 'PRE_CIERRE_PREDICCIONES_{ID_PARTIDO}', 'FAN', 'S', 'Trabajo de pre-cierre de predicciones de partido programado', '0.1.0', 0, null);

prompt Done.
