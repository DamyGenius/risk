CREATE OR REPLACE PACKAGE k_importacion_fan IS

  /**
  Agrupa operaciones relacionadas con la importacion de datos de Fantasy.
  
  %author dmezac 31/08/2020 21:28:59
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2020 dmezac
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  g_salida CLOB := ''; -- Salida del output

  PROCEDURE p_importar_partidos(p_partidos IN CLOB);

END;
/
CREATE OR REPLACE PACKAGE BODY k_importacion_fan IS

  FUNCTION lf_buscar_partido(i_id_importacion IN NUMBER)
    RETURN NUMBER IS
    l_id_partido t_partidos.id_partido%TYPE;
  BEGIN
    SELECT id_partido
      INTO l_id_partido
      FROM t_partidos
     WHERE id_importacion = i_id_importacion;
    RETURN l_id_partido;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION lf_buscar_club(i_id_importacion IN NUMBER)
    RETURN VARCHAR2 IS
    l_id_club t_clubes.id_club%TYPE;
  BEGIN
    SELECT id_club
      INTO l_id_club
      FROM t_clubes
     WHERE id_importacion = i_id_importacion;
    RETURN l_id_club;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  PROCEDURE p_importar_partidos(p_partidos IN CLOB) IS
    v_partidos JSON_ARRAY_T;
    v_partido  JSON_OBJECT_T;

    l_id                t_partidos.id_importacion%TYPE;
    l_numerofecha       t_partidos.id_jornada%TYPE;
    l_id_club_local     t_partidos.id_club_local%TYPE;
    l_id_club_visitante t_partidos.id_club_visitante%TYPE;
    l_dia               VARCHAR2(30);
    l_hora              VARCHAR2(30);
    l_fecha_partido     DATE;
    l_id_partido        t_partidos.id_partido%TYPE;
    l_goleslocal        t_partidos.goles_club_local%TYPE;
    l_golesvisitante    t_partidos.goles_club_visitante%TYPE;
    l_estado            t_partidos.estado%TYPE;
  BEGIN
    v_partidos := JSON_ARRAY_T(p_partidos);

    FOR i IN 0 .. v_partidos.get_size - 1 LOOP
      v_partido := TREAT(v_partidos.get(i) AS JSON_OBJECT_T);

      l_id                := v_partido.get_number('id');
      DBMS_OUTPUT.put_line('index : ' || i || ' ' || 'id:' || l_id);
      l_numerofecha       := v_partido.get_number('numeroFecha');
      l_id_club_local     := lf_buscar_club(TREAT(v_partido.get('local') AS JSON_OBJECT_T).get_number('id'));
      l_id_club_visitante := lf_buscar_club(TREAT(v_partido.get('visitante') AS JSON_OBJECT_T).get_number('id'));

      l_dia  := v_partido.get_string('dia');
      l_hora := v_partido.get_string('hora');
      IF l_dia IS NOT NULL AND l_hora IS NOT NULL THEN
        l_fecha_partido := to_date(l_dia || ' ' || l_hora,
                                   'DD-MM-YYYY HH24:MI');
      ELSE
        l_fecha_partido := NULL;
      END IF;

      l_goleslocal     := v_partido.get_number('golesLocal');
      l_golesvisitante := v_partido.get_number('golesVisitante');
      l_estado         := v_partido.get_string('estado');

      IF l_estado not in ('F', 'S') THEN
        -- FINALIZADO O SUSPENDIDO
        l_goleslocal     := NULL;
        l_golesvisitante := NULL;
      END IF;

      l_id_partido := lf_buscar_partido(l_id);
      IF l_id_partido IS NOT NULL THEN
        UPDATE t_partidos p
           SET id_torneo            = 'PRI-APE20',--k_sistema.f_torneo, --TODO: obtener
               id_club_local        = l_id_club_local,
               id_club_visitante    = l_id_club_visitante,
               fecha                = trunc(l_fecha_partido),
               hora                 = to_char(l_fecha_partido, 'HH24:MI'),
               id_jornada           = l_numerofecha,
               id_estadio           = NULL,
               goles_club_local     = l_goleslocal,
               goles_club_visitante = l_golesvisitante,
               estado               = l_estado,
               id_importacion       = l_id
         WHERE p.id_partido = l_id_partido;
      ELSE
        INSERT INTO t_partidos
          (id_torneo, --TODO: obtener
           id_club_local,
           id_club_visitante,
           fecha,
           hora,
           id_jornada,
           id_estadio,
           goles_club_local,
           goles_club_visitante,
           estado,
           id_importacion)
        VALUES
          ('PRI-APE20', --k_sistema.f_torneo, --TODO: obtener
           l_id_club_local,
           l_id_club_visitante,
           trunc(l_fecha_partido),
           to_char(l_fecha_partido, 'HH24:MI'),
           l_numerofecha,
           NULL,
           l_goleslocal,
           l_golesvisitante,
           l_estado,
           l_id);
      END IF;

    END LOOP;
  END;

BEGIN
  -- Initialization
  DBMS_OUTPUT.ENABLE(1000000);
END;
/
