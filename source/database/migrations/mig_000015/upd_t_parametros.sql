UPDATE t_parametros a
   SET a.valor = '^[A-Za-z0-9-_.]{1,50}$'
 WHERE a.id_parametro = 'REGEXP_VALIDAR_ALIAS_USUARIO';
