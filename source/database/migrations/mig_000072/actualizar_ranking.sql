begin
  -- Call the procedure
  k_puntajes_fan.p_procesar_grupo_jornada('PRI-APE22', 5);
  k_puntajes_fan.p_actualizar_ranking(i_id_torneo => 'PRI-APE22');
  --
  k_puntajes_fan.p_procesar_grupo_jornada('ELS-QAT22', 16);
  k_puntajes_fan.p_actualizar_ranking(i_id_torneo => 'ELS-QAT22');
end;
