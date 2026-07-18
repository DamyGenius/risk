prompt Importing table t_dato_definiciones...
set feedback off
set define off

insert into t_dato_definiciones (TABLA, CAMPO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO)
values ('T_PARTIDO_INCIDENCIAS', 'IMG_GOL_PUSH_ENVIOS', 'Cantidad de push con imagen de gol enviados', 1, 'ID_PARTIDO_INCIDENCIA', 'N');

prompt Done.
