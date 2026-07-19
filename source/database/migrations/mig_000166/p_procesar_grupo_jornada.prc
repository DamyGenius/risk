CREATE OR REPLACE PROCEDURE p_procesar_grupo_jornada(i_id_jornada IN NUMBER) IS
  /*
  * DEPRECADO: Utilizar k_puntajes_fan.p_procesar_grupo_jornada en su lugar.
  * Se conserva por compatibilidad con la pagina 16 de RISK ADMIN (APEX).
  * El torneo depende del parametro de sesion k_sistema.c_torneo; no se valida
  * aqui y puede ser NULL si el contexto de la sesion no fue inicializado.
  * TODO: Hacer que la pagina informe el torneo y eliminar este procedimiento.
  */
  l_id_torneo t_partidos.id_torneo%TYPE;
BEGIN
  l_id_torneo := k_sistema.f_valor_parametro_string(k_sistema.c_torneo);

  k_puntajes_fan.p_procesar_grupo_jornada(i_id_torneo  => l_id_torneo,
                                          i_id_jornada => i_id_jornada);
END;
/
