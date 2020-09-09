prompt Importing table t_aplicaciones...
set feedback off
set define off
insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, CLAVE, DETALLE, VERSION_ACTUAL, TIEMPO_EXPIRACION_ACCESS_TOKEN, TIEMPO_EXPIRACION_REFRESH_TOKEN, TEMPLATE_NOTIFICACION, PLATAFORMA_NOTIFICACION)
values ('WIN', 'WINDOWS', 'D', 'S', 'u0jVxK7vw3b4O1/pnJnFD5CzoY4lyvRfwC/yUfXscFk=', 'Aplicaci�n para la plataforma Windows', '0.1.0', 900, 5, null, 'wns');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, CLAVE, DETALLE, VERSION_ACTUAL, TIEMPO_EXPIRACION_ACCESS_TOKEN, TIEMPO_EXPIRACION_REFRESH_TOKEN, TEMPLATE_NOTIFICACION, PLATAFORMA_NOTIFICACION)
values ('AND', 'ANDROID', 'M', 'S', 'azVd94zazPu/+q5ZHqoL1v6wccamHV3oWoALYWQK0Z8=', 'Aplicaci�n m�vil para la plataforma Android', '0.1.0', 900, 5, '{"notification":{"title":"$(titulo)","body":"$(contenido)","image":"http://www.infocancha.com/Resources/Images/Noticia/2018/07/2-10950-20180704-090314.jpg"}}', 'fcm');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, CLAVE, DETALLE, VERSION_ACTUAL, TIEMPO_EXPIRACION_ACCESS_TOKEN, TIEMPO_EXPIRACION_REFRESH_TOKEN, TEMPLATE_NOTIFICACION, PLATAFORMA_NOTIFICACION)
values ('IOS', 'IOS', 'M', 'S', '7C+o70uaWg7q4INnuzryHorFzbjNQOCWjrYZzWDQmLA=', 'Aplicaci�n m�vil para la plataforma iOS', '0.1.0', 900, 5, '{"aps":{"alert":"$(contenido)"}}', 'apns');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, CLAVE, DETALLE, VERSION_ACTUAL, TIEMPO_EXPIRACION_ACCESS_TOKEN, TIEMPO_EXPIRACION_REFRESH_TOKEN, TEMPLATE_NOTIFICACION, PLATAFORMA_NOTIFICACION)
values ('MSJ', 'RISK MSJ', 'S', 'S', 'Hkru7cXdu6FdIqhA9Q4XJqTgW/pW651rDjlSyLczKwI=', 'Servicio para env�o de mensajes a los usuarios a trav�s de Correo electr�nico (E-mail), Mensaje de texto (SMS) y Notificaci�n push', '0.1.0', 86400, 10000, null, null);

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, CLAVE, DETALLE, VERSION_ACTUAL, TIEMPO_EXPIRACION_ACCESS_TOKEN, TIEMPO_EXPIRACION_REFRESH_TOKEN, TEMPLATE_NOTIFICACION, PLATAFORMA_NOTIFICACION)
values ('TEST', 'RISK TEST', 'W', 'S', 'KM1gROAnPUAZykrHcOOJRAC1jkcnyBVLRWXcRD3pjvQ=', 'Cliente HTTP para pruebas de Servicios Web', '0.1.0', 3600, 5, null, null);

prompt Done.
