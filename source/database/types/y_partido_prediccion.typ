CREATE OR REPLACE TYPE y_partido_prediccion UNDER y_partido
(
/**
Agrupa datos de un partido.

%author dmezac 14/7/2020 19:28:53
*/

/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 jtsoya539

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

  predic_goles_local     NUMBER(3),
  predic_goles_visitante NUMBER(3),
  sincronizacion         NUMBER(3),
/**
Constructor del objeto sin parámetros.

%author dmezac 14/7/2020 19:28:53
%return Objeto del tipo y_partido_prediccion.
*/
  CONSTRUCTOR FUNCTION y_partido_prediccion RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author dmezac 14/7/2020 19:28:53
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_partido_prediccion IS

  CONSTRUCTOR FUNCTION y_partido_prediccion RETURN SELF AS RESULT AS
  BEGIN
    self.id_partido        := NULL;
    self.id_torneo         := NULL;
    self.id_club_local     := NULL;
    self.id_club_visitante := NULL;
    self.fecha             := NULL;
    self.hora              := NULL;
    self.id_jornada        := NULL;
    self.id_estadio        := NULL;
    self.goles_local       := NULL;
    self.goles_visitante   := NULL;
    self.estado            := NULL;

    self.predic_goles_local     := NULL;
    self.predic_goles_visitante := NULL;
    self.sincronizacion         := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_partido_prediccion;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                   := NEW y_partido_prediccion();
    l_objeto.id_partido        := l_json_object.get_number('id_partido');
    l_objeto.id_torneo         := l_json_object.get_string('id_torneo');
    l_objeto.id_club_local     := l_json_object.get_string('id_club_local');
    l_objeto.id_club_visitante := l_json_object.get_string('id_club_visitante');
    l_objeto.fecha             := l_json_object.get_date('fecha');
    l_objeto.hora              := l_json_object.get_string('hora');
    l_objeto.id_jornada        := l_json_object.get_number('id_jornada');
    l_objeto.id_estadio        := l_json_object.get_number('id_estadio');
    l_objeto.goles_local       := l_json_object.get_number('goles_local');
    l_objeto.goles_visitante   := l_json_object.get_number('goles_visitante');
    l_objeto.estado            := l_json_object.get_string('estado');
  
    l_objeto.predic_goles_local     := l_json_object.get_string('predic_goles_local');
    l_objeto.predic_goles_visitante := l_json_object.get_string('predic_goles_visitante');
    l_objeto.sincronizacion         := l_json_object.get_string('sincronizacion');

    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_partido', self.id_partido);
    l_json_object.put('id_torneo', self.id_torneo);
    l_json_object.put('id_club_local', self.id_club_local);
    l_json_object.put('id_club_visitante', self.id_club_visitante);
    l_json_object.put('fecha', self.fecha);
    l_json_object.put('hora', self.hora);
    l_json_object.put('id_jornada', self.id_jornada);
    l_json_object.put('id_estadio', self.id_estadio);
    l_json_object.put('goles_local', self.goles_local);
    l_json_object.put('goles_visitante', self.goles_visitante);
    l_json_object.put('estado', self.estado);

    l_json_object.put('predic_goles_local', self.predic_goles_local);
    l_json_object.put('predic_goles_visitante', self.predic_goles_visitante);
    l_json_object.put('sincronizacion', self.sincronizacion);
    RETURN l_json_object.to_clob;
  END;

END;
/
