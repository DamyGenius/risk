prompt Importing table t_significados...
set feedback off
set define off
insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_IMAGEN', 'BMP', 'IMAGEN BMP', 'image/bmp', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_IMAGEN', 'GIF', 'IMAGEN GIF', 'image/gif', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_IMAGEN', 'JPEG', 'IMAGEN JPEG', 'image/jpeg', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_IMAGEN', 'PNG', 'IMAGEN PNG', 'image/png', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_IMAGEN', 'SVG', 'IMAGEN SVG', 'image/svg+xml', 'N');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'BMP', 'DOCUMENTO BMP', 'image/bmp', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'GIF', 'DOCUMENTO GIF', 'image/gif', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'JPEG', 'DOCUMENTO JPEG', 'image/jpeg', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'PNG', 'DOCUMENTO PNG', 'image/png', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'SVG', 'DOCUMENTO SVG', 'image/svg+xml', 'N');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'DOC', 'DOCUMENTO DOC', 'application/octet-stream', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'DOCX', 'DOCUMENTO DOCX', 'application/octet-stream', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('EXTENSION_DOCUMENTO', 'PDF', 'DOCUMENTO PDF', 'application/pdf', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_CLAVE', 'A', 'ACCESO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_CLAVE', 'T', 'TRANSACCIONAL', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_SESION', 'A', 'ACTIVO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_SESION', 'X', 'EXPIRADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_SESION', 'F', 'FINALIZADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_PERSONA', 'F', 'F�SICA', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_PERSONA', 'J', 'JUR�DICA', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_APLICACION', 'W', 'WEB', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_APLICACION', 'M', 'MOBILE', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_APLICACION', 'D', 'DESKTOP', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_USUARIO', 'A', 'ACTIVO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_USUARIO', 'I', 'INACTIVO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_USUARIO', 'B', 'BLOQUEADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_SERVICIO', 'S', 'SOAP', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_SERVICIO', 'R', 'REST', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_CLAVE', 'N', 'NUEVO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_CLAVE', 'A', 'ACTIVO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_CLAVE', 'B', 'BLOQUEADO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DIRECCION_PARAMETRO', 'I', 'ENTRADA', 'IN', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DIRECCION_PARAMETRO', 'O', 'SALIDA', 'OUT', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DIRECCION_PARAMETRO', 'A', 'AMBOS', 'IN OUT', 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_DATO_PARAMETRO', 'S', 'STRING', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_DATO_PARAMETRO', 'N', 'NUMBER', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_DATO_PARAMETRO', 'B', 'BOOLEAN', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('TIPO_DATO_PARAMETRO', 'D', 'DATE', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DOMINIO_SERVICIO', 'GEN', 'GENERAL', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DOMINIO_SERVICIO', 'AUT', 'AUTENTICACION', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DOMINIO_SERVICIO', 'API', 'SERVICIO', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('DOMINIO_SERVICIO', 'FAN', 'FANTASY', null, 'S');

insert into t_significados (DOMINIO, CODIGO, SIGNIFICADO, REFERENCIA, ACTIVO)
values ('ESTADO_SESION', 'I', 'INV�LIDO', null, 'S');

prompt Done.
