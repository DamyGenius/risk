UPDATE t_trabajos a
   SET a.accion = 'BEGIN
  LOOP
    EXIT WHEN nvl(k_importacion_fan.f_llavear_importacion_partido, ''N'') = ''S'';
    sys.dbms_session.sleep(1);
  END LOOP;
  k_importacion_fan.p_importar_partido(&ID_PARTIDO);
  k_puntajes_fan.p_iniciar_cierre_partido_en_juego(&ID_PARTIDO);
END;'
 WHERE a.id_trabajo = 56;
