UPDATE t_trabajos a
   SET a.accion = 'DECLARE
  CURSOR c_torneos IS
    SELECT id_torneo FROM t_torneos WHERE actual = ''S'';
BEGIN
  FOR tor IN c_torneos LOOP
    k_importacion_fan.p_importar_partidos(tor.id_torneo);
    k_puntajes_fan.p_planificar_partidos(tor.id_torneo);
  END LOOP;
END;'
 WHERE a.id_trabajo = 54;

UPDATE t_trabajos a
   SET a.accion = 'DECLARE
  l_id_partido t_partidos.id_partido%TYPE := &ID_PARTIDO;
  l_id_torneo  t_partidos.id_torneo%TYPE;
  l_id_jornada t_partidos.id_jornada%TYPE;
BEGIN
  BEGIN
    SELECT p.id_torneo, p.id_jornada
      INTO l_id_torneo, l_id_jornada
      FROM t_partidos p
     WHERE p.id_partido = l_id_partido;
  EXCEPTION
    WHEN no_data_found THEN
      raise_application_error(-20001, ''Partido no registrado.'');
    WHEN OTHERS THEN
      raise_application_error(-20002,
                              ''Error al obtener partido: '' || SQLERRM);
  END;

  k_puntajes_fan.p_cerrar_partido_en_juego(l_id_partido);
  k_puntajes_fan.p_actualizar_puntajes(l_id_partido);
  -- Procesar grupo de la jornada
  k_puntajes_fan.p_procesar_grupo_jornada(l_id_torneo, l_id_jornada);
  -- Recalcular ranking de grupos
  k_puntajes_fan.p_actualizar_ranking(l_id_torneo);
END;'
 WHERE a.id_trabajo = 57;
