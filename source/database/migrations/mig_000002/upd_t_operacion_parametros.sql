UPDATE t_operacion_parametros a
   SET a.obligatorio = 'N'
 WHERE a.id_operacion = 43
   AND a.nombre IN ('GOLES_CLUB_LOCAL', 'GOLES_CLUB_VISITANTE');
