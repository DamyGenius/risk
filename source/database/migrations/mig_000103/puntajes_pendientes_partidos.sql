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

  l_varchar2(1) :=q'!501!';
  l_clob(2) :=q'!M!';
  l_clob(3) :=q'!PUNTAJES_PENDIENTES_PARTIDOS!';
  l_clob(4) :=q'!FAN!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!Partidos pendientes de contabilización de puntajes!';
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

  l_varchar2(1) :=q'!501!';
  l_clob(2) :=q'!ID_PARTIDO!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!1!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!N!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';

  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
  );

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

  l_varchar2(1) :=q'!501!';
  l_clob(2) :=q'!La importación de datos del partido puntual no finalizó exitosamente, y luego se actualizó el resultado manualmente o por el proceso diario del torneo.

Posibles causas:
-El partido fue suspendido o postergado.
-Problemas con el proveedor de datos.!';
  l_clob(3) :=q'!SELECT p.id_partido,
       p.id_torneo,
       k_util.f_formatear_titulo(l.nombre_corto) || ' ' ||
       p.goles_club_local || '-' || p.goles_club_visitante || ' ' ||
       k_util.f_formatear_titulo(v.nombre_corto) partido,
       p.fecha
  FROM t_partidos p, t_clubes l, t_clubes v, t_torneos t
 WHERE p.id_club_local = l.id_club
   AND p.id_club_visitante = v.id_club
   AND p.id_torneo = t.id_torneo
      --
   AND p.estado = 'F'
   AND EXISTS (SELECT 1
          FROM t_predicciones x
         WHERE x.id_partido = p.id_partido
           AND x.estado = 'C')
 ORDER BY p.fecha DESC!';
  l_clob(4) :=q'!En el caso de partido suspendido o postergado, se debe volver a correr el trabajo de importación del partido puntual una vez que éste se reanude.!';
  l_varchar2(5) :=q'!1!';
  l_varchar2(6) :=q'!!';
  l_varchar2(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_varchar2(9) :=q'!!';
  l_varchar2(10) :=q'!1!';
  l_varchar2(11) :=q'!1!';
  l_clob(12) :=q'!!';

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
    ,"COMENTARIOS"
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
