UPDATE t_dispositivo_suscripciones a
   SET a.fecha_expiracion = NULL
 WHERE a.fecha_expiracion IS NOT NULL;
