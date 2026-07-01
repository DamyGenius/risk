update t_monitoreos a
   set a.causa = 'Posibles causas:
-La versión del Driver NO ES COMPATIBLE con la Versión del Navegador.',
       a.consulta_sql = 'SELECT y.info
  FROM (WITH v_test AS (SELECT k_datos_fan.f_test datos FROM dual)
         SELECT to_char(CASE
                          WHEN datos IS json THEN
                           (SELECT CASE
                                     WHEN nvl(substr(j.version_driver,
                                                     1,
                                                     instr(j.version_driver, ''.'') - 1),
                                              ''-1'') <>
                                          nvl(substr(j.version_chrome,
                                                     1,
                                                     instr(j.version_chrome, ''.'') - 1),
                                              ''-2'') THEN
                                      ''Servicio de Datos: Versión Driver: '' ||
                                      nvl(substr(j.version_driver,
                                                 1,
                                                 instr(j.version_driver, ''.'') - 1),
                                          ''[null]'') || '', Versión Chrome: '' ||
                                      nvl(substr(j.version_chrome,
                                                 1,
                                                 instr(j.version_chrome, ''.'') - 1),
                                          ''[null]'')
                                   END
                              FROM json_table(datos,
                                              ''$'' columns(version_driver path
                                                      ''$.versionDriver'',
                                                      version_chrome path
                                                      ''$.versionChrome'')) j)
                          ELSE
                           NULL
                        END) info
           FROM v_test x) y
          WHERE y.info IS NOT NULL',
       a.plan_accion = '-Verificar la URL: https://www.rama.com.py/proyecto-ne-wsdatos/rest/test
-Verificar compatibilidad del driver con el navegador.',
       a.prioridad = 2,
       a.frecuencia = '6H'
where a.id_monitoreo='503';

