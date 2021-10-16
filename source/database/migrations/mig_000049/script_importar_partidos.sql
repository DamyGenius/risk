DECLARE
  CURSOR c_torneos IS
    SELECT id_torneo FROM t_torneos WHERE actual = 'S';
BEGIN
  FOR tor IN c_torneos LOOP
    k_importacion_fan.p_importar_partidos(tor.id_torneo);
    k_puntajes_fan.p_planificar_partidos(tor.id_torneo);
  END LOOP;
END;
