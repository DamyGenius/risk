prompt Importing table t_significados...
set feedback off
set define off
insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_INVITACION', 'A', 'ACEPTADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_INVITACION', 'C', 'CANCELADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_INVITACION', 'P', 'PENDIENTE DE ACEPTACIÓN', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_INVITACION', 'X', 'EXPIRADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_INVITACION', 'A', 'AMISTAD', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_INVITACION', 'G', 'GRUPO', null, 'S');

prompt Done.
