CREATE OR REPLACE TYPE y_club UNDER y_objeto
(
/**
Agrupa datos de un club.

%author jtsoya539 30/3/2020 11:13:53
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

  id_club        VARCHAR2(5),
  nombre_oficial VARCHAR2(100),
  nombre_corto   VARCHAR2(100),
  otros_nombres  VARCHAR2(100),
  fundacion      DATE,
  pagina_web     VARCHAR2(200),
  twitter        VARCHAR2(100),
  facebook       VARCHAR2(100),
  id_division    VARCHAR2(3),

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_club.
*/
  CONSTRUCTOR FUNCTION y_club RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_club IS

  CONSTRUCTOR FUNCTION y_club RETURN SELF AS RESULT AS
  BEGIN
    self.id_club        := NULL;
    self.nombre_oficial := NULL;
    self.nombre_corto   := NULL;
    self.otros_nombres  := NULL;
    self.fundacion      := NULL;
    self.pagina_web     := NULL;
    self.twitter        := NULL;
    self.facebook       := NULL;
    self.id_division    := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_club;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                := NEW y_club();
    l_objeto.id_club        := l_json_object.get_string('id_club');
    l_objeto.nombre_oficial := l_json_object.get_string('nombre_oficial');
    l_objeto.nombre_corto   := l_json_object.get_string('nombre_corto');
    l_objeto.otros_nombres  := l_json_object.get_string('otros_nombres');
    l_objeto.fundacion      := l_json_object.get_date('fundacion');
    l_objeto.pagina_web     := l_json_object.get_string('pagina_web');
    l_objeto.twitter        := l_json_object.get_string('twitter');
    l_objeto.facebook       := l_json_object.get_string('facebook');
    l_objeto.id_division    := l_json_object.get_string('id_division');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_club', self.id_club);
    l_json_object.put('nombre_oficial', self.nombre_oficial);
    l_json_object.put('nombre_corto', self.nombre_corto);
    l_json_object.put('otros_nombres', self.otros_nombres);
    l_json_object.put('fundacion', self.fundacion);
    l_json_object.put('pagina_web', self.pagina_web);
    l_json_object.put('twitter', self.twitter);
    l_json_object.put('facebook', self.facebook);
    l_json_object.put('id_division', self.id_division);
    RETURN l_json_object.to_clob;
  END;

END;
/
