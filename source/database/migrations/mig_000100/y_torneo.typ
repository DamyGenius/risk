CREATE OR REPLACE TYPE y_torneo UNDER y_objeto
(
/**
Agrupa datos de un torneo con sus fases correspondientes.

%author dmezac 6/5/2022 11:55:21
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

  id_torneo   VARCHAR2(12),
  descripcion VARCHAR2(50),
  fases       y_objetos,

/**
Constructor del objeto sin parámetros.

%author dmezac 6/5/2022 11:55:21
%return Objeto del tipo y_torneo.
*/
  CONSTRUCTOR FUNCTION y_torneo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author dmezac 6/5/2022 11:55:21
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_torneo IS

  CONSTRUCTOR FUNCTION y_torneo RETURN SELF AS RESULT AS
  BEGIN
    self.id_torneo   := NULL;
    self.descripcion := NULL;
    self.fases       := NEW y_objetos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_torneo      y_torneo;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_torneo             := NEW y_torneo();
    l_torneo.id_torneo   := l_json_object.get_string('id_torneo');
    l_torneo.descripcion := l_json_object.get_string('descripcion');
    l_torneo.fases       := NULL; -- TODO
  
    RETURN l_torneo;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_torneo', self.id_torneo);
    l_json_object.put('descripcion', self.descripcion);
  
    IF self.fases IS NULL THEN
      l_json_object.put_null('fases');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.fases.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.fases(i).to_json));
        i := self.fases.next(i);
      END LOOP;
      l_json_object.put('fases', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
