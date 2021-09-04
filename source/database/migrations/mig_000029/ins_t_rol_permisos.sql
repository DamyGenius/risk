prompt Importing table t_rol_permisos...
set feedback off
set define off
insert into t_rol_permisos (ID_ROL, ID_PERMISO, CONSULTAR, INSERTAR, ACTUALIZAR, ELIMINAR)
values (2, 'SERVICIO:FAN:ENVIAR_MENSAJE_AMIGO', 'N', 'N', 'N', 'N');

insert into t_rol_permisos (ID_ROL, ID_PERMISO, CONSULTAR, INSERTAR, ACTUALIZAR, ELIMINAR)
values (2, 'SERVICIO:FAN:LISTAR_MENSAJES_AMIGO', 'N', 'N', 'N', 'N');

insert into t_rol_permisos (ID_ROL, ID_PERMISO, CONSULTAR, INSERTAR, ACTUALIZAR, ELIMINAR)
values (4, 'SERVICIO:FAN:ENVIAR_MENSAJE_AMIGO', 'N', 'N', 'N', 'N');

insert into t_rol_permisos (ID_ROL, ID_PERMISO, CONSULTAR, INSERTAR, ACTUALIZAR, ELIMINAR)
values (4, 'SERVICIO:FAN:LISTAR_MENSAJES_AMIGO', 'N', 'N', 'N', 'N');

prompt Done.
