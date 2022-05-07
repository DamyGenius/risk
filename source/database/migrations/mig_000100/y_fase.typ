CREATE OR REPLACE TYPE y_fase UNDER y_objeto
(
/**
Agrupa datos de una fase de torneo con sus grupos, jornadas y partidos correspondientes.

%author dmezac 5/5/2022 23:03:15
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

  id_fase     NUMBER(3),
  descripcion VARCHAR2(50),
  grupos      y_torneo_grupos,
  jornadas    y_jornadas,
  partidos    y_partidos,

/**
Constructor del objeto sin parámetros.

%author dmezac 5/5/2022 23:03:15
%return Objeto del tipo y_fase.
*/
  CONSTRUCTOR FUNCTION y_fase RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author dmezac 5/5/2022 23:03:15
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_fase IS

  CONSTRUCTOR FUNCTION y_fase RETURN SELF AS RESULT AS
  BEGIN
    self.id_fase     := NULL;
    self.descripcion := NULL;
    self.grupos      := NEW y_torneo_grupos();
    self.jornadas    := NEW y_jornadas();
    self.partidos    := NEW y_partidos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_fase        y_fase;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_fase             := NEW y_fase();
    l_fase.id_fase     := l_json_object.get_number('id_fase');
    l_fase.descripcion := l_json_object.get_string('descripcion');
    l_fase.grupos      := NULL; -- TODO
    l_fase.jornadas    := NULL; -- TODO
    l_fase.partidos    := NULL; -- TODO
  
    RETURN l_fase;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_fase', self.id_fase);
    l_json_object.put('descripcion', self.descripcion);
  
    IF self.grupos IS NULL THEN
      l_json_object.put_null('grupos');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.grupos.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.grupos(i).to_json));
        i := self.grupos.next(i);
      END LOOP;
      l_json_object.put('grupos', l_json_array);
    END IF;
  
    IF self.jornadas IS NULL THEN
      l_json_object.put_null('jornadas');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.jornadas.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.jornadas(i).to_json));
        i := self.jornadas.next(i);
      END LOOP;
      l_json_object.put('jornadas', l_json_array);
    END IF;
  
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
