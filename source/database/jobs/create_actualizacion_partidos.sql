BEGIN
  -- Crear el trabajo diario de actualización de partidos
  k_planificador.p_crear_o_editar_trabajo(i_id_trabajo   => k_planificador.c_actualizacion_partidos,
                                          i_fecha_inicio => trunc(current_timestamp) + 0.5 --hoy a las 12hs
                                          );
END;
