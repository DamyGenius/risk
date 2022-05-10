UPDATE t_operacion_parametros a
   SET a.obligatorio = 'N'
 WHERE a.id_operacion = 41
   AND a.nombre = 'ID_JORNADA_INICIO';
