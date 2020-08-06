prompt Importing table t_predicciones...
set feedback off
set define off
insert into t_predicciones (ID_PARTIDO, ID_USUARIO, GOLES_CLUB_LOCAL, GOLES_CLUB_VISITANTE, ESTADO, PUNTOS, ID_SINCRONIZACION)
values ((select min(id_partido)
          from t_partidos
         where estado = 'F'), 1, 2, 1, 'P', 6, null);

prompt Done.
