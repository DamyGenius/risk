prompt Agregando campos de fecha y duración a T_OPERACION_LOGS...
alter table T_OPERACION_LOGS add
(
  fecha_hora_inicio TIMESTAMP(2) WITH TIME ZONE,
  fecha_hora_fin    TIMESTAMP(2) WITH TIME ZONE,
  duracion          INTERVAL DAY(3) TO SECOND(2)
);
comment on column T_OPERACION_LOGS.fecha_hora_inicio
  is 'Fecha/hora de inicio de la ejecución de la operación';
comment on column T_OPERACION_LOGS.fecha_hora_fin
  is 'Fecha/hora de fin de la ejecución de la operación';
comment on column T_OPERACION_LOGS.duracion
  is 'Duración de la ejecución de la operación';
prompt Done.
