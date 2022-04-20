prompt Importing table t_torneos...
set feedback off
set define off

insert into t_torneos (ID_TORNEO, ID_DIVISION, TEMPORADA, TITULO, DENOMINACION_OFICIAL, SALDO_INICIAL, ACTUAL, ID_URL, ID_IMPORTACION, TITULO_ALTERNATIVO, PRUEBA)
values ('LIB-TEM22', 'LIB', 2022, 'COPA LIBERTADORES 2022', 'COPA CONMEBOL LIBERTADORES 2022', null, 'S', 'SPO', 'deportes.futbol.libertadores', null, 'N');

prompt Done.
