prompt Importing table t_notificacion_plantillas...
set feedback off
set define off
insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'GEN', 'GENERAL', 'S', 'Notificaciones generales para la plataforma Android', '{"data":{"title":"$(titulo)","body":"$(contenido)","image":"https://image.freepik.com/foto-gratis/pelota-futbol-campo-futbol-hierba-verde_34263-98.jpg"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'MSJ', 'MENSAJERIA', 'S', 'Notificaciones de mensajería para la plataforma Android', '{"data":{"type":"$(tipo)","group_id":"$(id_grupo)","group_name":"$(nombre_grupo)","sender":"$(usuario)","message":"$(mensaje)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('IOS', 'GEN', 'GENERAL', 'S', 'Notificaciones generales para la plataforma iOS', '{"aps":{"alert":"$(contenido)"}}');

prompt Done.
