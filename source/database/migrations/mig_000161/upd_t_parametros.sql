prompt Actualizando parametro URL_IMAGENES_SERVICIOS...
set feedback off
set define off

update t_parametros
   set valor = 'https://www.retosports.com.py/proyecto-ne-img'
 where id_parametro = 'URL_IMAGENES_SERVICIOS'
   and (valor is null or valor = 'https://www.rama.com.py/proyecto-ne-img');

prompt Done.