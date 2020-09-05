prompt Importing table t_trabajos...
set feedback off
set define off

insert into t_trabajos (ID_TRABAJO, NOMBRE, TIPO, ACTIVO, DOMINIO, ACCION, FECHA_INICIO, TIEMPO_INICIO, INTERVALO_REPETICION, FECHA_FIN, COMENTARIOS, VERSION_ACTUAL, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION)
values (54, 'ACTUALIZACION_PARTIDOS', 'PLSQL_BLOCK', 'S', 'FAN', 'BEGIN
  k_importacion_fan.p_importar_partidos;
  k_puntajes_fan.p_planificar_partidos;
END;', null, null, 'FREQ=DAILY;BYHOUR=12;', null, 'Trabajo de actualización y planificación de partidos', null, null, null);

insert into t_trabajos (ID_TRABAJO, NOMBRE, TIPO, ACTIVO, DOMINIO, ACCION, FECHA_INICIO, TIEMPO_INICIO, INTERVALO_REPETICION, FECHA_FIN, COMENTARIOS, VERSION_ACTUAL, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION)
values (55, 'CIERRE_PREDICCIONES_{ID_PARTIDO}', 'PLSQL_BLOCK', 'S', 'FAN', 'BEGIN
  k_puntajes_fan.p_cerrar_predicciones(&ID_PARTIDO);
  k_puntajes_fan.p_abrir_partido_en_juego(&ID_PARTIDO);
END;', null, -60, null, null, 'Trabajo de cierre de predicciones de partido programado', null, null, null);

insert into t_trabajos (ID_TRABAJO, NOMBRE, TIPO, ACTIVO, DOMINIO, ACCION, FECHA_INICIO, TIEMPO_INICIO, INTERVALO_REPETICION, FECHA_FIN, COMENTARIOS, VERSION_ACTUAL, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION)
values (56, 'PARTIDO_EN_JUEGO_{ID_PARTIDO}', 'PLSQL_BLOCK', 'S', 'FAN', 'BEGIN
  k_importacion_fan.p_importar_partidos;
  k_puntajes_fan.p_iniciar_cierre_partido_en_juego(&ID_PARTIDO);
END;', null, 900, 'FREQ=MINUTELY; INTERVAL=15;', null, 'Trabajo de actualización de partido en juego', null, null, null);

insert into t_trabajos (ID_TRABAJO, NOMBRE, TIPO, ACTIVO, DOMINIO, ACCION, FECHA_INICIO, TIEMPO_INICIO, INTERVALO_REPETICION, FECHA_FIN, COMENTARIOS, VERSION_ACTUAL, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION)
values (57, 'FIN_PARTIDO_{ID_PARTIDO}', 'PLSQL_BLOCK', 'S', 'FAN', 'BEGIN
  k_puntajes_fan.p_cerrar_partido_en_juego(&ID_PARTIDO);
  k_puntajes_fan.p_actualizar_puntajes(&ID_PARTIDO);
  -- Recalcular ranking de grupos
  k_puntajes_fan.p_actualizar_ranking;
END;', null, 10, null, null, 'Trabajo de cierre de partido en juego', null, null, null);

prompt Done.
