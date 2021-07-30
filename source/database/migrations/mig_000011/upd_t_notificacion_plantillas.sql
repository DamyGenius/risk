UPDATE t_notificacion_plantillas a
   SET a.plantilla = '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)"}}'
 WHERE a.id_plantilla = 'ESP'
   AND a.id_aplicacion = 'AND';
