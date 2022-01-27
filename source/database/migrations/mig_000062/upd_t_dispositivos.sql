UPDATE t_dispositivos a
   SET a.zona_horaria = k_util.f_zona_horaria(a.zona_horaria)
 WHERE a.zona_horaria IS NOT NULL;
