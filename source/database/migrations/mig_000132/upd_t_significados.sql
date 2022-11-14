UPDATE t_significados a
   SET a.significado = 'PENDIENTE - INVITADO'
 WHERE a.dominio = 'ESTADO_GRUPO_USUARIO'
   AND a.codigo = 'P';
