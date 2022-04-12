prompt Importing table t_notificacion_plantillas...
set feedback off
set define off
insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'GEN', 'GENERAL', 'S', 'Notificaciones generales para la plataforma Android', '{"data":{"title":"$(titulo)","body":"$(contenido)","image":"$(imagen)","largeIcon":"$(icono)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'ESP', 'ESPECIAL', 'S', 'Notificaciones especiales para la plataforma Android', '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'EEX', 'ESPECIAL_EXTRAS', 'S', 'Notificaciones especiales con datos extras para la plataforma Android', '{"data":{"title":"$(titulo)","body":"$(contenido)","type":"$(tipo)","id":"$(identificador)","alertOnce":"$(unaAlerta)","data1":"$(dato1)","data2":"$(dato2)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'MSJ', 'MENSAJERIA', 'S', 'Notificaciones de mensajería para la plataforma Android', '{"data":{"type":"$(tipo)","group_id":"$(id_grupo)","group_name":"$(nombre_grupo)","sender":"$(usuario)","message":"$(mensaje)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'MSA', 'MENSAJERIA_AMIGO', 'S', 'Notificaciones de mensajería individual para la plataforma Android', '{"data":{"type":"$(tipo)","friend_id":"$(id_amistad)","sender":"$(usuario)","message":"$(mensaje)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('IOS', 'GEN', 'GENERAL', 'S', 'Notificaciones generales para la plataforma iOS', '{"aps":{"alert":"$(contenido)"}}');

prompt Done.
