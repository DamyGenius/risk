prompt Importing table t_significados...
set feedback off
set define off
insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_EQUIPO', 'S', 'SELECCIÓN', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_EQUIPO', 'C', 'CLUB', null, 'S');

prompt Done.
