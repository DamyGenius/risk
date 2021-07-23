UPDATE t_trabajos a
   SET a.accion               = 'BEGIN
  k_importacion_fan.p_importar_partido(&ID_PARTIDO);
  LOOP
    EXIT WHEN nvl(k_importacion_fan.f_estado_importacion_partidos, ''D'') <> ''E'';
    sys.dbms_session.sleep(1);
  END LOOP;
  k_puntajes_fan.p_iniciar_cierre_partido_en_juego(&ID_PARTIDO);
END;',
       a.tiempo_inicio        = 60,
       a.intervalo_repeticion = 'FREQ=MINUTELY; INTERVAL=1;'
 WHERE a.id_trabajo IN (56);
