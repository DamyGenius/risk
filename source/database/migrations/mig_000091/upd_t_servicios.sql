UPDATE t_servicios a
   SET a.consulta_sql = 'SELECT a.id_torneo,
       a.id_division,
       a.temporada,
       a.titulo,
       a.denominacion_oficial,
       a.titulo_alternativo,
       b.descripcion desc_division,
       b.descripcion_corta desc_corta_division,
       (SELECT decode(nvl(COUNT(1), 0), 0, ''N'', ''S'')
          FROM t_usuario_divisiones x
         WHERE x.id_usuario = k_sistema.f_id_usuario
           AND x.id_division = a.id_division) siguiendo,
       k_usuario.f_suscripto_notificacion(k_sistema.f_id_usuario,
                                          k_dispositivo.f_suscripcion_division(a.id_division)) suscripto,
       (SELECT y.ranking
          FROM t_grupo_torneo_usuarios y
         WHERE y.id_grupo =
               k_puntajes_fan.f_grupo_general_torneo(a.id_torneo)
           AND y.id_torneo = a.id_torneo
           AND y.id_usuario = k_sistema.f_id_usuario) ranking
  FROM t_torneos a, t_divisiones b
 WHERE a.actual = ''S''
   AND a.id_division = b.id_division'
 WHERE a.id_servicio = 74;
