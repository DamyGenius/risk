CREATE OR REPLACE TYPE y_amigo UNDER y_objeto
(
/**
Agrupa datos de Usuarios Amigos.

%author dmezac 15/3/2021 14:54:26
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

/** Identificador del usuario */
  id_usuario NUMBER(10),
/** Alias del usuario (identificador para autenticacion) */
  alias_usuario VARCHAR2(300),
/** Version del avatar del usuario */
  version_avatar NUMBER(10),
/** Puntos en el ranking general */
  puntos NUMBER(15),
/** Ranking general */
  ranking NUMBER(6),
/** Token de aceptacion */
  token_aceptacion VARCHAR2(50),
/** Solicitud aceptada? (S/N) */
  aceptado VARCHAR2(1),
/** Tipo (SOLICITANTE/SOLICITADO) */
  tipo VARCHAR2(12),

  CONSTRUCTOR FUNCTION y_amigo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_amigo IS

  CONSTRUCTOR FUNCTION y_amigo RETURN SELF AS RESULT AS
  BEGIN
    self.id_usuario       := NULL;
    self.alias_usuario    := NULL;
    self.version_avatar   := NULL;
    self.puntos           := NULL;
    self.ranking          := NULL;
    self.token_aceptacion := NULL;
    self.aceptado         := NULL;
    self.tipo             := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_amigo;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                  := NEW y_amigo();
    l_objeto.id_usuario       := l_json_object.get_number('id_usuario');
    l_objeto.alias_usuario    := l_json_object.get_string('alias_usuario');
    l_objeto.version_avatar   := l_json_object.get_string('version_avatar');
    l_objeto.puntos           := l_json_object.get_number('puntos');
    l_objeto.ranking          := l_json_object.get_number('ranking');
    l_objeto.token_aceptacion := l_json_object.get_string('token_aceptacion');
    l_objeto.aceptado         := l_json_object.get_string('aceptado');
    l_objeto.tipo             := l_json_object.get_string('tipo');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_usuario', self.id_usuario);
    l_json_object.put('alias_usuario', self.alias_usuario);
    l_json_object.put('version_avatar', self.version_avatar);
    l_json_object.put('puntos', self.puntos);
    l_json_object.put('ranking', self.ranking);
    l_json_object.put('token_aceptacion', self.token_aceptacion);
    l_json_object.put('aceptado', self.aceptado);
    l_json_object.put('tipo', self.tipo);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
