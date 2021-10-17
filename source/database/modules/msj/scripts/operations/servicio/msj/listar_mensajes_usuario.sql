/* ==================== T_OPERACIONES ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

  l_varchar2(1) :=q'!75!';
  l_clob(2) :=q'!S!';
  l_clob(3) :=q'!LISTAR_MENSAJES_USUARIO!';
  l_clob(4) :=q'!MSJ!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!!';
  l_clob(7) :=q'!0.1.0!';
  l_varchar2(8) :=q'!1!';
  l_clob(9) :=q'!PAGINA_PARAMETROS!';

  insert into t_operaciones
  (
     "ID_OPERACION"
    ,"TIPO"
    ,"NOMBRE"
    ,"DOMINIO"
    ,"ACTIVO"
    ,"DETALLE"
    ,"VERSION_ACTUAL"
    ,"NIVEL_LOG"
    ,"PARAMETROS_AUTOMATICOS"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
  );

end;
/
/* ==================== T_OPERACION_PARAMETROS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

end;
/
/* ==================== T_SERVICIOS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

  l_varchar2(1) :=q'!75!';
  l_clob(2) :=q'!C!';
  l_varchar2(3) :=q'!!';
  l_varchar2(4) :=q'!!';
  l_clob(5) :=q'!SELECT a.id_notificacion,
       --b.id_usuario,
       --b.alias alias_usuario,
       --k_usuario.f_version_avatar(b.alias) version_avatar,
       a.titulo,
       a.contenido,
       a.fecha_envio fecha
  FROM t_notificaciones a, t_usuarios b
 WHERE (a.id_usuario = b.id_usuario OR a.suscripcion = 'GENERAL&&default')
   AND b.id_usuario = k_sistema.f_valor_parametro_number('ID_USUARIO')
   AND (b.fecha_creacion <= a.fecha_envio OR b.fecha_creacion IS NULL)
   AND a.estado = 'E'
 ORDER BY id_notificacion DESC!';
  l_clob(6) :=q'!!';

  insert into t_servicios
  (
     "ID_SERVICIO"
    ,"TIPO"
    ,"CANTIDAD_EJECUCIONES"
    ,"FECHA_ULTIMA_EJECUCION"
    ,"CONSULTA_SQL"
    ,"SQL_ULTIMA_EJECUCION"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_number(l_varchar2(3))
    ,to_date(l_varchar2(4),'DD.MM.YYYY HH24:MI:SS')
    ,l_clob(5)
    ,l_clob(6)
  );

end;
/
/* ==================== T_REPORTES ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

end;
/
/* ==================== T_TRABAJOS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

end;
/
/* ==================== T_ROL_PERMISOS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

  l_varchar2(1) :=q'!2!';
  l_clob(2) :=q'!SERVICIO:MSJ:LISTAR_MENSAJES_USUARIO!';
  l_clob(3) :=q'!N!';
  l_clob(4) :=q'!N!';
  l_clob(5) :=q'!N!';
  l_clob(6) :=q'!N!';

  insert into t_rol_permisos
  (
     "ID_ROL"
    ,"ID_PERMISO"
    ,"CONSULTAR"
    ,"INSERTAR"
    ,"ACTUALIZAR"
    ,"ELIMINAR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
  );

  l_varchar2(1) :=q'!4!';
  l_clob(2) :=q'!SERVICIO:MSJ:LISTAR_MENSAJES_USUARIO!';
  l_clob(3) :=q'!N!';
  l_clob(4) :=q'!N!';
  l_clob(5) :=q'!N!';
  l_clob(6) :=q'!N!';

  insert into t_rol_permisos
  (
     "ID_ROL"
    ,"ID_PERMISO"
    ,"CONSULTAR"
    ,"INSERTAR"
    ,"ACTUALIZAR"
    ,"ELIMINAR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
  );

end;
/
