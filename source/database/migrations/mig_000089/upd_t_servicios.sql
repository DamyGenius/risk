UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_division,
       a.descripcion,
       a.id_pais,
       a.detalle,
       a.descripcion_corta,
       k_archivo.f_version_archivo(''T_DIVISIONES'', ''LOGO'', a.id_division) version_logo,
       (SELECT decode(nvl(COUNT(1), 0), 0, ''N'', ''S'')
          FROM t_usuario_divisiones x
         WHERE x.id_usuario = k_sistema.f_id_usuario
           AND x.id_division = a.id_division) siguiendo,
       k_usuario.f_suscripto_notificacion(k_sistema.f_id_usuario,
                                          k_dispositivo.f_suscripcion_division(a.id_division)) suscripto
  FROM t_divisiones a'
 WHERE a.id_servicio = 73;
