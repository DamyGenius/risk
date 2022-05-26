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

  l_varchar2(1) :=q'!54!';
  l_clob(2) :=q'!T!';
  l_clob(3) :=q'!ACTUALIZACION_PARTIDOS!';
  l_clob(4) :=q'!FAN!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!Trabajo de actualización y planificación de partidos!';
  l_clob(7) :=q'!0.1.0!';
  l_varchar2(8) :=q'!0!';
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

  l_varchar2(1) :=q'!54!';
  l_clob(2) :=q'!PLSQL_BLOCK!';
  l_clob(3) :=q'!DECLARE
  CURSOR c_torneos IS
    SELECT id_torneo FROM t_torneos WHERE actual = 'S';
BEGIN
  FOR tor IN c_torneos LOOP
    k_importacion_fan.p_importar_partidos(tor.id_torneo);
    k_puntajes_fan.p_planificar_partidos(tor.id_torneo);
  END LOOP;
END;!';
  l_varchar2(4) :=q'!!';
  l_varchar2(5) :=q'!!';
  l_clob(6) :=q'!FREQ=DAILY;BYHOUR=12;!';
  l_varchar2(7) :=q'!!';
  l_clob(8) :=q'!Trabajo de actualización y planificación de partidos!';
  l_varchar2(9) :=q'!!';
  l_varchar2(10) :=q'!!';

  insert into t_trabajos
  (
     "ID_TRABAJO"
    ,"TIPO"
    ,"ACCION"
    ,"FECHA_INICIO"
    ,"TIEMPO_INICIO"
    ,"INTERVALO_REPETICION"
    ,"FECHA_FIN"
    ,"COMENTARIOS"
    ,"CANTIDAD_EJECUCIONES"
    ,"FECHA_ULTIMA_EJECUCION"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_timestamp_tz(l_varchar2(4),'DD.MM.YYYY HH24:MI:SSXFF TZR')
    ,to_number(l_varchar2(5))
    ,to_char(l_clob(6))
    ,to_timestamp_tz(l_varchar2(7),'DD.MM.YYYY HH24:MI:SSXFF TZR')
    ,to_char(l_clob(8))
    ,to_number(l_varchar2(9))
    ,to_date(l_varchar2(10),'DD.MM.YYYY HH24:MI:SS')
  );

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
