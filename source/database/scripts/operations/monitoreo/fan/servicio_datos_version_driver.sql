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

  l_varchar2(1) :=q'!503!';
  l_clob(2) :=q'!M!';
  l_clob(3) :=q'!SERVICIO_DATOS_VERSION_DRIVER!';
  l_clob(4) :=q'!FAN!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!Error en driver del servicio de datos!';
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

  l_varchar2(1) :=q'!503!';
  l_clob(2) :=q'!Posibles causas:
-La versión del Driver NO ES COMPATIBLE con la Versión del Navegador.
-El servicio /proyecto-ne-wsdatos está ABAJO.
-El servidor Tomcat está ABAJO.!';
  l_clob(3) :=q'!SELECT y.info
  FROM (WITH v_test AS (SELECT k_datos_fan.f_test datos FROM dual)
         SELECT to_char(CASE
                          WHEN datos IS json THEN
                           (SELECT CASE
                                     WHEN nvl(substr(j.version_driver,
                                                     1,
                                                     instr(j.version_driver, '.') - 1),
                                              '-1') <>
                                          nvl(substr(j.version_chrome,
                                                     1,
                                                     instr(j.version_chrome, '.') - 1),
                                              '-2') THEN
                                      'Servicio de Datos: Versión Driver: ' ||
                                      nvl(substr(j.version_driver,
                                                 1,
                                                 instr(j.version_driver, '.') - 1),
                                          '[null]') || ', Versión Chrome: ' ||
                                      nvl(substr(j.version_chrome,
                                                 1,
                                                 instr(j.version_chrome, '.') - 1),
                                          '[null]')
                                   END
                              FROM json_table(datos,
                                              '$' columns(version_driver path
                                                      '$.versionDriver',
                                                      version_chrome path
                                                      '$.versionChrome')) j)
                          WHEN datos LIKE '%HTTP Status 404%' THEN
                           'Servicio de Datos: HTTP Status 404 – Not Found'
                          WHEN datos LIKE
                               '%This version of ChromeDriver only supports%' THEN
                           'Servicio de Datos: Versión de Driver NO COMPATIBLE con Versión de Navegador'
                          ELSE
                           'Servicio de Datos: Error Desconocido'
                        END) info
           FROM v_test x) y
          WHERE y.info IS NOT NULL!';
  l_clob(4) :=q'!-Verificar la URL: https://www.rama.com.py/proyecto-ne-wsdatos/rest/test
-Verificar estado del servidor Tomcat.
-Verificar estado del servicio /proyecto-ne-wsdatos.
-Verificar compatibilidad del driver con el navegador.!';
  l_varchar2(5) :=q'!1!';
  l_varchar2(6) :=q'!!';
  l_varchar2(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_varchar2(9) :=q'!!';
  l_varchar2(10) :=q'!1!';
  l_varchar2(11) :=q'!2!';
  l_clob(12) :=q'!H!';
  l_clob(13) :=q'!!';

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
