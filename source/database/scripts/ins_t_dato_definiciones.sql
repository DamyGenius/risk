prompt Importing table t_dato_definiciones...
set feedback off
set define off

insert into t_dato_definiciones (TABLA, CAMPO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO)
values ('T_USUARIOS', 'ID_CLUB', 'Club favorito del usuario', 1, 'ALIAS', 'S');

prompt Done.
