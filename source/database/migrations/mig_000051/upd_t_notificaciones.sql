UPDATE t_notificaciones a
   SET a.id_usuario = to_number(regexp_substr(a.suscripcion, '\d+'))
 WHERE regexp_like(a.suscripcion, '(' || '&&user_' || ')\d+', 'i')
   AND a.suscripcion NOT LIKE '%&&!user_%'
   AND a.id_usuario IS NULL;
