prompt Importing table t_grupo_usuarios...
set feedback off
set define off

insert into t_grupo_usuarios (ID_GRUPO, ID_USUARIO, PUNTOS, RANKING, ESTADO, TOKEN_ACTIVACION, ACEPTADO)
values ((select id_grupo
          from t_grupos
         where descripcion = 'Grupo General 1'
           and id_torneo = 'PRI-DEMO'), 1, 6, 1, 'A', null, null);

insert into t_grupo_usuarios (ID_GRUPO, ID_USUARIO, PUNTOS, RANKING, ESTADO, TOKEN_ACTIVACION, ACEPTADO)
values ((select id_grupo
          from t_grupos
         where descripcion = 'Grupo Privado 1'
           and id_torneo = 'PRI-DEMO'), 1, 6, 1, 'A', null, null);

insert into t_grupo_usuarios (ID_GRUPO, ID_USUARIO, PUNTOS, RANKING, ESTADO, TOKEN_ACTIVACION, ACEPTADO)
values ((select id_grupo
          from t_grupos
         where descripcion = 'Grupo Privado 2'
           and id_torneo = 'PRI-DEMO'), 2, 6, 1, 'A', null, null);

insert into t_grupo_usuarios (ID_GRUPO, ID_USUARIO, PUNTOS, RANKING, ESTADO, TOKEN_ACTIVACION, ACEPTADO)
values ((select id_grupo
          from t_grupos
         where descripcion = 'Grupo Privado 2'
           and id_torneo = 'PRI-DEMO'), 1, 6, 1, 'P', null, 'N');

prompt Done.
