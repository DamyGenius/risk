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
                                          k_dispositivo.f_suscripcion_division(a.id_division)) suscripto,
       -- Torneo Actual
       b.id_torneo,
       b.temporada,
       b.titulo,
       b.denominacion_oficial,
       b.titulo_alternativo,
       b.tipo,
       (SELECT y.ranking
          FROM t_grupo_torneo_usuarios y
         WHERE y.id_grupo =
               k_puntajes_fan.f_grupo_general_torneo(b.id_torneo)
           AND y.id_torneo = b.id_torneo
           AND y.id_usuario = k_sistema.f_id_usuario) ranking
  FROM t_divisiones a, t_torneos b
 WHERE a.id_division = b.id_division
   AND b.actual = ''S''
 ORDER BY a.descripcion'
 WHERE a.id_servicio = 73;
