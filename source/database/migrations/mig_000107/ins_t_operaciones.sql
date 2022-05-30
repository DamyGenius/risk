prompt Importing table t_operaciones...
set feedback off
set define off
insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2000, 'T', 'MONITOREO_CONFLICTOS_MENSUAL', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Mensual', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2001, 'T', 'MONITOREO_CONFLICTOS_SEMANAL', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Semanal', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2002, 'T', 'MONITOREO_CONFLICTOS_DIARIO', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Diaria', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2003, 'T', 'MONITOREO_CONFLICTOS_12_HORAS', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Cada 12 Horas', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2004, 'T', 'MONITOREO_CONFLICTOS_6_HORAS', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Cada 6 Horas', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2005, 'T', 'MONITOREO_CONFLICTOS_2_HORAS', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Cada 2 Horas', '0.1.0', 0, null);

insert into t_operaciones (ID_OPERACION, TIPO, NOMBRE, DOMINIO, ACTIVO, DETALLE, VERSION_ACTUAL, NIVEL_LOG, PARAMETROS_AUTOMATICOS)
values (2006, 'T', 'MONITOREO_CONFLICTOS_HORA', 'GEN', 'S', 'Trabajo de monitoreo de conflictos - Frecuencia Cada Hora', '0.1.0', 0, null);

prompt Done.
