INSERT INTO t_usuario_divisiones
  (id_usuario, id_division)
  SELECT a.id_usuario,
         upper(REPLACE(a.suscripcion, 'category_', '')) id_division
    FROM t_usuario_suscripciones a
   WHERE a.suscripcion LIKE '%category%'
     AND NOT EXISTS
   (SELECT 1
            FROM t_usuario_divisiones x
           WHERE x.id_usuario = a.id_usuario
             AND x.id_division =
                 upper(REPLACE(a.suscripcion, 'category_', '')));
