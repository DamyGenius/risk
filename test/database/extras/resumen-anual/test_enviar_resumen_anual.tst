PL/SQL Developer Test script 3.0
43
DECLARE

  CURSOR c_usuarios IS
    SELECT *
      FROM (SELECT a.*, a.rowid
              FROM t_usuarios a
             WHERE a.estado = 'A'
               AND a.direccion_correo IS NOT NULL
                  -- que hayan pronosticado al menos un partido
               AND (SELECT nvl(COUNT(r.id_partido), 0) pronosticos
                      FROM t_torneos      t,
                           t_divisiones   d,
                           t_partidos     p,
                           t_predicciones r
                     WHERE t.id_division = d.id_division
                       AND t.id_torneo = p.id_torneo
                       AND p.id_partido = r.id_partido
                       AND nvl(t.prueba, 'N') = 'N'
                       AND t.temporada = :i_anio
                       AND r.id_usuario = a.id_usuario) > 0
                  -- que no haya sido enviado el resumen
               AND NOT EXISTS
             (SELECT 1
                      FROM t_correos c
                     WHERE c.mensaje_subject LIKE
                           '%tu resumen del ' || :i_anio || '%'
                       AND c.id_usuario = a.id_usuario)
             ORDER BY a.alias)
    --WHERE rownum < 20
    ;

BEGIN

  FOR cu IN c_usuarios LOOP
    -- Call the procedure
    p_enviar_resumen_anual(i_alias => cu.alias,
                           i_anio  => :i_anio,
                           i_force => FALSE);
    -- Delay para prevenir spam
    dbms_session.sleep(4);
  END LOOP;

END;
2
i_alias
1
damian.meza.py
-5
i_anio
1
2022
5
0
