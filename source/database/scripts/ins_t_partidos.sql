prompt Importing table t_partidos...
set feedback off
set define off
insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'CER', 'NAC', to_date('01-08-2020', 'dd-mm-yyyy'), '18:00', 1, null, 2, 1, 'F');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'LIB', 'GUA', to_date('01-08-2020', 'dd-mm-yyyy'), '20:00', 1, null, 0, 0, 'F');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'OLI', 'LUQ', to_date('02-08-2020', 'dd-mm-yyyy'), '19:00', 1, null, 1, 1, 'F');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'LUQ', 'CER', to_date('08-08-2020', 'dd-mm-yyyy'), '18:00', 2, null, null, null, 'M');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'NAC', 'LIB', to_date('08-08-2020', 'dd-mm-yyyy'), '20:00', 2, null, null, null, 'M');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'GUA', 'OLI', to_date('09-08-2020', 'dd-mm-yyyy'), '19:00', 2, null, null, null, 'M');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'CER', 'GUA', to_date('15-08-2020', 'dd-mm-yyyy'), '18:00', 3, null, null, null, 'R');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'LIB', 'LUQ', to_date('15-08-2020', 'dd-mm-yyyy'), '20:00', 3, null, null, null, 'R');

insert into t_partidos (ID_TORNEO, ID_CLUB_LOCAL, ID_CLUB_VISITANTE, FECHA, HORA, ID_JORNADA, ID_ESTADIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO)
values ('PRI-DEMO', 'OLI', 'NAC', to_date('16-08-2020', 'dd-mm-yyyy'), '19:00', 3, null, null, null, 'R');

prompt Done.
