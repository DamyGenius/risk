prompt Importing table t_divisiones...
set feedback off
set define off

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('DEM', 'DIVISIÓN DEMO', 177, NULL, NULL);

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('PRI', 'PRIMERA DIVISIÓN', 177, 'SPO', 'deportes.futbol.paraguay');

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('INT', 'INTERMEDIA', 177, 'SPO', 'deportes.futbol.paraguayb');

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('PRB', 'PRIMERA B', 177, NULL, NULL);

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('PRC', 'PRIMERA C', 177, NULL, NULL);

insert into t_divisiones (ID_DIVISION, DESCRIPCION, ID_PAIS, ID_URL, CANAL_IMPORTACION)
values ('RES', 'RESERVA', 177, NULL, NULL);

prompt Done.
