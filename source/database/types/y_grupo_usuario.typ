CREATE OR REPLACE TYPE y_grupo_usuario UNDER y_objeto
(
/**
Agrupa datos de Usuarios por Grupo de Predicciones.

%author jtsoya539 30/3/2020 10:54:26
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

/**  */
  id_usuario NUMBER(10),
/**  */
  puntos NUMBER(15),
/**  */
  ranking NUMBER(6),
/**  */
  estado VARCHAR2(1),
/**  */
  token_activacion VARCHAR2(50),
/** Invitación aceptada? (S/N) */
  aceptado VARCHAR2(1),

  CONSTRUCTOR FUNCTION y_grupo_usuario RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_grupo_usuario IS

  CONSTRUCTOR FUNCTION y_grupo_usuario RETURN SELF AS RESULT AS
  BEGIN
    self.id_usuario       := NULL;
    self.puntos           := NULL;
    self.ranking          := NULL;
    self.estado           := NULL;
    self.token_activacion := NULL;
    self.aceptado         := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_grupo_usuario;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                  := NEW y_grupo_usuario();
    l_objeto.id_usuario       := l_json_object.get_number('id_usuario');
    l_objeto.puntos           := l_json_object.get_number('puntos');
    l_objeto.ranking          := l_json_object.get_number('ranking');
    l_objeto.estado           := l_json_object.get_string('estado');
    l_objeto.token_activacion := l_json_object.get_string('token_activacion');
    l_objeto.aceptado         := l_json_object.get_string('aceptado');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_usuario', self.id_usuario);
    l_json_object.put('puntos', self.puntos);
    l_json_object.put('ranking', self.ranking);
    l_json_object.put('estado', self.estado);
    l_json_object.put('token_activacion', self.token_activacion);
    l_json_object.put('aceptado', self.aceptado);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
