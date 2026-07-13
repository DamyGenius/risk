prompt Actualizando plantilla de notificacion ESPECIAL_EXTRAS...
set feedback off
set define off

update t_notificacion_plantillas
   set plantilla = '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)","data1":"$(dato1)","data2":"$(dato2)","data3":"$(dato3)","image":"$(imagen)"}}'
 where id_aplicacion = 'AND'
   and id_plantilla = 'EEX';

prompt Done.