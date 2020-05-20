CREATE OR REPLACE TYPE y_dispositivo UNDER y_objeto
(
/**
Agrupa datos de un dispositivo.

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

/** Identificador del dispositivo */
  id_dispositivo NUMBER(15),
/* Token del dispositivo */
  token_dispositivo VARCHAR2(500),
/* Nombre del sistema operativo */
  nombre_sistema_operativo VARCHAR2(100),
/* Version del sistema operativo */
  version_sistema_operativo VARCHAR2(100),
/* Tipo del dispositivo */
  tipo VARCHAR2(100),
/* Nombre del navegador */
  nombre_navegador VARCHAR2(100),
/* Version del navegador */
  version_navegador VARCHAR2(100),
/* Token de notificacion del dispositivo */
  token_notificacion VARCHAR2(500),

/**
Constructor del objeto sin par�metros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_dispositivo.
*/
  CONSTRUCTOR FUNCTION y_dispositivo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.

%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/

CREATE OR REPLACE TYPE BODY y_dispositivo IS

  CONSTRUCTOR FUNCTION y_dispositivo RETURN SELF AS RESULT AS
  BEGIN
    self.id_dispositivo            := NULL;
    self.token_dispositivo         := NULL;
    self.nombre_sistema_operativo  := NULL;
    self.version_sistema_operativo := NULL;
    self.tipo                      := NULL;
    self.nombre_navegador          := NULL;
    self.version_navegador         := NULL;
    self.token_notificacion        := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_dispositivo y_dispositivo;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_dispositivo                           := NEW y_dispositivo();
    l_dispositivo.id_dispositivo            := l_json_object.get_number('id_dispositivo');
    l_dispositivo.token_dispositivo         := l_json_object.get_string('token_dispositivo');
    l_dispositivo.nombre_sistema_operativo  := l_json_object.get_string('nombre_sistema_operativo');
    l_dispositivo.version_sistema_operativo := l_json_object.get_string('version_sistema_operativo');
    l_dispositivo.tipo                      := l_json_object.get_string('tipo');
    l_dispositivo.nombre_navegador          := l_json_object.get_string('nombre_navegador');
    l_dispositivo.version_navegador         := l_json_object.get_string('version_navegador');
    l_dispositivo.token_notificacion        := l_json_object.get_string('token_notificacion');
  
    RETURN l_dispositivo;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_dispositivo', self.id_dispositivo);
    l_json_object.put('token_dispositivo', self.token_dispositivo);
    l_json_object.put('nombre_sistema_operativo',
                      self.nombre_sistema_operativo);
    l_json_object.put('version_sistema_operativo',
                      self.version_sistema_operativo);
    l_json_object.put('tipo', self.tipo);
    l_json_object.put('nombre_navegador', self.nombre_navegador);
    l_json_object.put('version_navegador', self.version_navegador);
    l_json_object.put('token_notificacion', self.token_notificacion);
    RETURN l_json_object.to_clob;
  END;

END;
/
