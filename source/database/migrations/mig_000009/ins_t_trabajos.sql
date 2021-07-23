prompt Importing table t_trabajos...
set feedback off
set define off
insert into t_trabajos (ID_TRABAJO, TIPO, ACCION, FECHA_INICIO, TIEMPO_INICIO, INTERVALO_REPETICION, FECHA_FIN, COMENTARIOS, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION)
values (69, 'PLSQL_BLOCK', 'BEGIN
  k_puntajes_fan.p_alistar_cierre_predicciones(&ID_PARTIDO);
END;', null, -900, null, null, 'Trabajo de pre-cierre de predicciones de partido programado', null, null);

prompt Done.
