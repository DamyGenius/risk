UPDATE t_operacion_parametros a
   SET a.obligatorio = 'N'
 WHERE a.id_operacion = 4
   AND a.nombre = 'DIRECCION_CORREO';
