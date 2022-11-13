UPDATE t_notificacion_plantillas a
   SET a.plantilla = '{"data":{"title":"$(titulo)","body":"$(contenido)","image":"$(imagen)","largeIcon":"$(icono)"}}'
 WHERE a.id_aplicacion = 'IOS'
   AND a.id_plantilla = 'GEN';
