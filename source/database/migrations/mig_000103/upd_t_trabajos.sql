UPDATE t_trabajos
   SET accion = 'BEGIN
  k_puntajes_fan.p_cerrar_partido(&ID_PARTIDO);
END;'
 WHERE id_trabajo = 57;
