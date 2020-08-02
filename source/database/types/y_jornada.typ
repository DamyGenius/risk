CREATE OR REPLACE TYPE y_jornada UNDER y_objeto
(
/**
Agrupa datos de una jornada con sus partidos correspondientes.

%author dmezac 1/8/2020 22:50:43
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

  id_torneo  VARCHAR2(12),
  id_jornada NUMBER(3),
  titulo     VARCHAR2(50),
  estado     VARCHAR2(1),
  partidos   y_partidos,

/**
Constructor del objeto sin parámetros.

%author dmezac 1/8/2020 22:50:43
%return Objeto del tipo y_jornada.
*/
  CONSTRUCTOR FUNCTION y_jornada RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author dmezac 1/8/2020 22:50:43
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_jornada IS

  CONSTRUCTOR FUNCTION y_jornada RETURN SELF AS RESULT AS
  BEGIN
    self.id_torneo  := NULL;
    self.id_jornada := NULL;
    self.titulo     := NULL;
    self.estado     := NULL;
    self.partidos   := NEW y_partidos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_jornada     y_jornada;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_jornada            := NEW y_jornada();
    l_jornada.id_torneo  := l_json_object.get_string('id_torneo');
    l_jornada.id_jornada := l_json_object.get_number('id_jornada');
    l_jornada.titulo     := l_json_object.get_string('titulo');
    l_jornada.estado     := l_json_object.get_string('estado');
    l_jornada.partidos   := NULL; -- TODO
  
    RETURN l_jornada;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_torneo', self.id_torneo);
    l_json_object.put('id_jornada', self.id_jornada);
    l_json_object.put('titulo', self.titulo);
    l_json_object.put('estado', self.estado);
  
    IF self.partidos IS NULL THEN
      l_json_object.put_null('partidos');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.partidos.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.partidos(i).to_json));
        i := self.partidos.next(i);
      END LOOP;
      l_json_object.put('partidos', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
