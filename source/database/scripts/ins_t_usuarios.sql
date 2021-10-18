prompt Importing table t_usuarios...
set feedback off
set define off
insert into t_usuarios (ID_USUARIO, ALIAS, ID_PERSONA, ESTADO, DIRECCION_CORREO, NUMERO_TELEFONO, PRUEBA)
values (1, 'demouser', 1, 'A', 'demouser@risk.com', null, 'S');

insert into t_usuarios (ID_USUARIO, ALIAS, ID_PERSONA, ESTADO, DIRECCION_CORREO, NUMERO_TELEFONO, PRUEBA)
values (2, 'msjuser', null, 'A', null, null, null);

prompt Done.
