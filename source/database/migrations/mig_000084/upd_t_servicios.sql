UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_division,
       a.descripcion,
       a.id_pais,
       a.detalle,
       k_archivo.f_version_archivo(''T_DIVISIONES'', ''LOGO'', a.id_division) version_logo,
       k_usuario.f_suscripto_notificacion(k_sistema.f_id_usuario,
                                          k_dispositivo.f_suscripcion_division(a.id_division)) suscripto
  FROM t_divisiones a'
 WHERE a.id_servicio = 73;
