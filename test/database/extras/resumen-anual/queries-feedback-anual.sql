select b.alias, a.*, a.rowid
 from t_usuario_calificaciones a, t_usuarios b
 where a.id_usuario=b.id_usuario
 and a.anio='2022'
;
