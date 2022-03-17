DECLARE
  CURSOR c_usuarios IS
    SELECT DISTINCT a.id_usuario, c.id_division
      FROM t_predicciones a, t_partidos b, t_torneos c
     WHERE a.id_partido = b.id_partido
       AND b.id_torneo = c.id_torneo;
BEGIN
  FOR c IN c_usuarios LOOP
    BEGIN
      k_usuario.p_suscribir_notificacion(c.id_usuario,
                                         k_dispositivo.f_suscripcion_division(c.id_division));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(c.id_usuario),
                                               k_dispositivo.f_suscripcion_division(c.id_division));
    END;
  END LOOP;
END;
