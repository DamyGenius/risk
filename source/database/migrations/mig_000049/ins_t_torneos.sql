prompt Importing table t_torneos...
set feedback off
set define off
insert into t_torneos (ID_TORNEO, ID_DIVISION, TEMPORADA, TITULO, DENOMINACION_OFICIAL, SALDO_INICIAL, ACTUAL, ID_URL, ID_IMPORTACION, TITULO_ALTERNATIVO)
values ('ELS-QAT22', 'ELS', 2022, 'ELIMINATORIAS SUDAMERICANAS 2022', 'CLASIFICACIÓN DE LA CONMEBOL PARA LA COPA MUNDIAL DE FÚTBOL', null, 'S', 'SPO', 'deportes.futbol.eliminatorias', null);

prompt Done.
