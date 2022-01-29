UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_amistad_mensaje,
       a.id_amistad,
       a.id_usuario,
       b.alias alias_usuario,
       k_usuario.f_version_avatar(b.alias) version_avatar,
       a.contenido,
       a.ref_mensaje,
       CAST(a.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha
  FROM t_amigo_mensajes a, t_usuarios b, t_amigos c
 WHERE a.id_usuario = b.id_usuario
   AND a.id_amistad = c.id_amistad
   AND (c.id_usuario_solicitante = k_sistema.f_id_usuario OR
       c.id_usuario_solicitado = k_sistema.f_id_usuario)
   AND (c.fecha_aceptacion <= a.fecha)
   AND c.aceptado = ''S''
 ORDER BY id_amistad_mensaje DESC'
 WHERE a.id_servicio = 72;

UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_comentario,
       a.tipo,
       a.referencia,
       a.id_usuario,
       b.alias alias_usuario,
       k_usuario.f_version_avatar(b.alias) version_avatar,
       a.contenido,
       a.ref_comentario,
       CAST(a.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha
  FROM t_comentarios a, t_usuarios b
 WHERE a.id_usuario = b.id_usuario
 ORDER BY id_comentario DESC'
 WHERE a.id_servicio = 64;

UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_grupo_mensaje,
       a.id_grupo,
       a.id_usuario,
       b.alias alias_usuario,
       k_usuario.f_version_avatar(b.alias) version_avatar,
       a.contenido,
       a.ref_mensaje,
       CAST(a.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha
  FROM t_grupo_mensajes a, t_usuarios b, t_grupo_usuarios c
 WHERE a.id_usuario = b.id_usuario
   AND a.id_grupo = c.id_grupo
   AND c.id_usuario = k_sistema.f_id_usuario
   AND (c.fecha_aceptacion <= a.fecha)
   AND c.estado = ''A''
   AND c.aceptado = ''S''
 ORDER BY id_grupo_mensaje DESC'
 WHERE a.id_servicio = 68;
