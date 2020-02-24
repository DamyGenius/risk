prompt Importing table t_parametros...
set feedback off
set define off
insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_DIRECCION_CORREO', 'Expresi�n Regular para validaci�n de direcciones de correo electr�nico', '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR)
values ('REGEXP_VALIDAR_NUMERO_TELEFONO', 'Expresi�n Regular para validaci�n de n�meros de tel�fono', '^(\+595|0)9[6-9][1-9][0-9]{6}$');

prompt Done.
