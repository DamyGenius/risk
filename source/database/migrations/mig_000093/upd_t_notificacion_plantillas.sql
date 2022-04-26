UPDATE t_notificacion_plantillas a
   SET a.plantilla = '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)","data1":"$(dato1)","data2":"$(dato2)","data3":"$(dato3)"}}'
 WHERE a.id_aplicacion = 'AND'
   AND a.id_plantilla = 'EEX';
