prompt Importing table t_notificacion_plantillas...
set feedback off
set define off
insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, DETALLE, PLANTILLA)
values ('AND', 'MSA', 'MENSAJERIA_AMIGO', 'S', 'Notificaciones de mensajería individual para la plataforma Android', '{"data":{"type":"$(tipo)","friend_id":"$(id_amistad)","sender":"$(usuario)","message":"$(mensaje)"}}');

prompt Done.
