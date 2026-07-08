prompt Importing table t_aplicaciones...
set feedback off
set define off

merge into t_aplicaciones a
using (select 'MAC' id_aplicacion,
              'MACOS' nombre,
              'D' tipo,
              'S' activo,
              'uHX9I0dfQHOD9fnELzHCRB0eakTLFiVKGrQmJnljyCI=' clave,
              'Aplicacion para la plataforma macOS' detalle,
              '0.1.0' version_actual,
              43200 tiempo_expiracion_access_token,
              8640 tiempo_expiracion_refresh_token,
              'fcm' plataforma_notificacion
         from dual) b
on (a.id_aplicacion = b.id_aplicacion)
when matched then
  update
     set a.nombre = b.nombre,
         a.tipo = b.tipo,
         a.activo = b.activo,
         a.clave = nvl(a.clave, b.clave),
         a.detalle = b.detalle,
         a.version_actual = b.version_actual,
         a.tiempo_expiracion_access_token = b.tiempo_expiracion_access_token,
         a.tiempo_expiracion_refresh_token = b.tiempo_expiracion_refresh_token,
         a.plataforma_notificacion = b.plataforma_notificacion
when not matched then
  insert
    (id_aplicacion,
     nombre,
     tipo,
     activo,
     clave,
     detalle,
     version_actual,
     tiempo_expiracion_access_token,
     tiempo_expiracion_refresh_token,
     plataforma_notificacion)
  values
    (b.id_aplicacion,
     b.nombre,
     b.tipo,
     b.activo,
     b.clave,
     b.detalle,
     b.version_actual,
     b.tiempo_expiracion_access_token,
     b.tiempo_expiracion_refresh_token,
     b.plataforma_notificacion);

prompt Done.
