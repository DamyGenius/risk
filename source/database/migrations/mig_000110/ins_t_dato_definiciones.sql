prompt Importing table t_dato_definiciones...
set feedback off
set define off
insert into t_dato_definiciones (TABLA, CAMPO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO)
values ('T_USUARIOS', 'CALIFICA_IOS', 'Usuario califica aplicación de iOS', 5, 'ALIAS', 'S');

insert into t_dato_definiciones (TABLA, CAMPO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO)
values ('T_USUARIOS', 'ACEPTA_TYC', 'Usuario acepta términos y condiciones', 6, 'ALIAS', 'S');

prompt Done.


