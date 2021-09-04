prompt Importing table t_servicios...
set feedback off
set define off
insert into t_servicios (ID_SERVICIO, TIPO, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION, CONSULTA_SQL, SQL_ULTIMA_EJECUCION)
values (71, 'T', null, null, null, null);

insert into t_servicios (ID_SERVICIO, TIPO, CANTIDAD_EJECUCIONES, FECHA_ULTIMA_EJECUCION, CONSULTA_SQL, SQL_ULTIMA_EJECUCION)
values (72, 'C', null, null, 'SELECT a.id_amistad_mensaje,
       a.id_amistad,
       a.id_usuario,
       b.alias alias_usuario,
       k_usuario.f_version_avatar(b.alias) version_avatar,
       a.contenido,
       a.ref_mensaje,
       CAST(a.fecha at TIME ZONE
            k_util.f_valor_parametro(''ZONA_HORARIA_PRODUCCION'') AS DATE) fecha
  FROM t_amigo_mensajes a, t_usuarios b, t_amigos c
 WHERE a.id_usuario = b.id_usuario
   AND a.id_amistad = c.id_amistad
   AND (c.id_usuario_solicitante =
       k_sistema.f_valor_parametro_number(''ID_USUARIO'') OR
       c.id_usuario_solicitado =
       k_sistema.f_valor_parametro_number(''ID_USUARIO''))
   AND (c.fecha_aceptacion <= a.fecha)
   AND c.aceptado = ''S''
 ORDER BY id_amistad_mensaje DESC', null);

prompt Done.
