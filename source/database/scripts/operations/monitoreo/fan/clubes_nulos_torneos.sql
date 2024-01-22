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

  l_varchar2(1) :=q'!504!';
  l_clob(2) :=q'!M!';
  l_clob(3) :=q'!CLUBES_NULOS_TORNEOS!';
  l_clob(4) :=q'!FAN!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!Torneos con clubes pendientes de alta!';
  l_clob(7) :=q'!0.1.0!';
  l_varchar2(8) :=q'!1!';
  l_clob(9) :=q'!!';

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
/* ==================== T_MONITOREOS ==================== */
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

  l_varchar2(1) :=q'!504!';
  l_clob(2) :=q'!Existen partidos en el torneo con clubes que están pendientes de ser dados de alta en el sistema.!';
  l_clob(3) :=q'!SELECT b.id_torneo, b.titulo, COUNT(1) cantidad_partidos
  FROM t_partidos a, t_torneos b
 WHERE a.id_torneo = b.id_torneo
   AND b.actual = 'S'
   AND ((a.id_club_local IS NULL AND
       (a.nombre_club_local IS NULL OR EXISTS
        (SELECT 1
             FROM t_equipos_tmp m
            WHERE m.nombre_corto = a.nombre_club_local))) OR
       (a.id_club_visitante IS NULL AND
       (a.nombre_club_visitante IS NULL OR EXISTS
        (SELECT 1
             FROM t_equipos_tmp m
            WHERE m.nombre_corto = a.nombre_club_visitante))))
 GROUP BY b.id_torneo, b.titulo!';
  l_clob(4) :=q'!Verificar y dar de alta manualmente los clubes pendientes con sus respectivos logos.!';
  l_varchar2(5) :=q'!1!';
  l_varchar2(6) :=q'!!';
  l_varchar2(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_varchar2(9) :=q'!!';
  l_varchar2(10) :=q'!1!';
  l_varchar2(11) :=q'!2!';
  l_clob(12) :=q'!D!';
  l_clob(13) :=q'!!';
  l_varchar2(14) :=q'!!';

  insert into t_monitoreos
  (
     "ID_MONITOREO"
    ,"CAUSA"
    ,"CONSULTA_SQL"
    ,"PLAN_ACCION"
    ,"PRIORIDAD"
    ,"CANTIDAD_EJECUCIONES"
    ,"FECHA_ULTIMA_EJECUCION"
    ,"CANTIDAD_EJECUCIONES_CONFLICTO"
    ,"FECHA_ULTIMA_EJECUCION_CONFLICTO"
    ,"ID_ROL_RESPONSABLE"
    ,"NIVEL_AVISO"
    ,"FRECUENCIA"
    ,"COMENTARIOS"
    ,"ID_USUARIO_RESPONSABLE"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,l_clob(3)
    ,to_char(l_clob(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_timestamp_tz(l_varchar2(7),'DD.MM.YYYY HH24:MI:SSXFF TZR')
    ,to_number(l_varchar2(8))
    ,to_timestamp_tz(l_varchar2(9),'DD.MM.YYYY HH24:MI:SSXFF TZR')
    ,to_number(l_varchar2(10))
    ,to_number(l_varchar2(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_number(l_varchar2(14))
  );

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

end;
/
