prompt Importing table t_notificacion_plantillas...
set feedback off
set define off
insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'EEX', 'ESPECIAL_EXTRAS', 'S', 'Notificaciones especiales con datos extras para la plataforma Android', '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)","data1":"$(dato1)","data2":"$(dato2)"}}');

prompt Done.
