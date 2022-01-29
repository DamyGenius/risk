prompt Importing table t_parametros...
set feedback off
set define off
insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR, ID_DOMINIO)
values ('ID_IDIOMA_ISO', 'Código del Idioma por defecto segun estandar ISO 639-1', 'es', null);

insert into t_parametros (ID_PARAMETRO, DESCRIPCION, VALOR, ID_DOMINIO)
values ('ID_PAIS_ISO', 'Código del País por defecto segun estandar ISO 3166-1 alpha-2', 'PY', null);

prompt Done.
