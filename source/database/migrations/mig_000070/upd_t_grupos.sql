UPDATE t_grupos a
   SET a.id_division =
       (SELECT x.id_division
          FROM t_torneos x
         WHERE x.id_torneo = a.id_division);
