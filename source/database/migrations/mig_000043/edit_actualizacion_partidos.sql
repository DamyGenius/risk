BEGIN
  EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE = ''-4:0''';

  -- Crear el trabajo diario de actualización de partidos
  k_trabajo.p_editar_trabajo(i_id_trabajo    => k_trabajo.c_actualizacion_partidos,
                             i_editar_accion => TRUE);
END;
