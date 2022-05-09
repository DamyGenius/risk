UPDATE t_operacion_parametros a
   SET a.obligatorio = 'N'
 WHERE a.id_operacion IN (78)
   AND a.nombre = 'TORNEO';
