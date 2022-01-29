prompt Importing table t_errores...
set feedback off
set define off
insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000001', 'Grupo inexistente', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000001', 'Group does not exist', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000002', 'Error al buscar grupo', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000002', 'Failed to find group', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000003', 'El usuario no está registrado. Se le envía una invitación.', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000003', 'The user is not registered. An invitation is sent.', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000004', 'Solicitud inexistente', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000004', 'There is no request', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000005', 'Sólo en grupos privados se puede invitar usuarios', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000005', 'Only in private groups you can invite users', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000006', 'Error al solicitar amistad', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000006', 'Failed to request friendship', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000007', 'Usuario es amigo o tiene una solicitud pendiente', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000007', 'User is a friend or has a pending request', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000008', 'El usuario no está registrado', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000008', 'The user is not registered', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000009', 'Usuario no puede solicitarse amistad a sí mismo', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000009', 'User cannot request friendship to himself', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000010', 'Sólo los grupos privados se pueden editar', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000010', 'Only private groups can be edited', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000011', 'Sólo el administrador puede editar los datos del grupo', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000011', 'Only admin can edit group', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000012', 'Sólo el administrador puede invitar usuarios al grupo', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000012', 'Only admin can invite users to the group', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000013', 'Usuario ya pertenece al grupo o tiene una invitación pendiente', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000013', 'User already belongs to the group or has a pending invitation', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000014', 'Error al crear invitación', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000014', 'Failed to invite', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000015', 'Comentario duplicado', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000015', 'Duplicate comment', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000016', 'Error al realizar comentario', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000016', 'Failed to comment', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000017', 'Reaccion duplicada', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000017', 'Duplicate reaction', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000018', 'Error al reaccionar', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000018', 'Failed to react', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000019', 'Mensaje duplicado', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000019', 'Duplicate message', 'API', 38, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000020', 'Error al enviar mensaje', 'API', null, null);

insert into t_errores (ID_ERROR, MENSAJE, ID_DOMINIO, ID_IDIOMA, ID_PAIS)
values ('fan0000020', 'Failed to send message', 'API', 38, null);

prompt Done.
