CREATE OR REPLACE TYPE y_grupo UNDER y_objeto
(
/**
Agrupa datos de Grupos de Predicciones.

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
  id_grupo NUMBER,
/**  */
  id_torneo VARCHAR2(12),
/**  */
  descripcion VARCHAR2(150),
/**  */
  tipo VARCHAR2(3),
/**  */
  id_usuario_administrador NUMBER(10),
/**  */
  fecha_creacion DATE,
/**  */
  id_jornada_inicio NUMBER(3),
/**  */
  estado VARCHAR2(1),
/**  */
  situacion VARCHAR2(1),
/**  */
  id_club VARCHAR2(5),
/** Todos los usuarios pueden invitar? (S/N) */
  todos_invitan VARCHAR2(1),
/** Usuarios */
  usuarios y_objetos,

  CONSTRUCTOR FUNCTION y_grupo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
CREATE OR REPLACE TYPE BODY y_grupo IS

  CONSTRUCTOR FUNCTION y_grupo RETURN SELF AS RESULT AS
  BEGIN
    self.id_grupo                 := NULL;
    self.id_torneo                := NULL;
    self.descripcion              := NULL;
    self.tipo                     := NULL;
    self.id_usuario_administrador := NULL;
    self.fecha_creacion           := NULL;
    self.id_jornada_inicio        := NULL;
    self.estado                   := NULL;
    self.situacion                := NULL;
    self.id_club                  := NULL;
    self.todos_invitan            := NULL;
    self.usuarios                 := NEW y_objetos();
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_grupo;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                          := NEW y_grupo();
    l_objeto.id_grupo                 := l_json_object.get_number('id_grupo');
    l_objeto.id_torneo                := l_json_object.get_string('id_torneo');
    l_objeto.descripcion              := l_json_object.get_string('descripcion');
    l_objeto.tipo                     := l_json_object.get_string('tipo');
    l_objeto.id_usuario_administrador := l_json_object.get_number('id_usuario_administrador');
    l_objeto.fecha_creacion           := l_json_object.get_date('fecha_creacion');
    l_objeto.id_jornada_inicio        := l_json_object.get_number('id_jornada_inicio');
    l_objeto.estado                   := l_json_object.get_string('estado');
    l_objeto.situacion                := l_json_object.get_string('situacion');
    l_objeto.id_club                  := l_json_object.get_string('id_club');
    l_objeto.todos_invitan            := l_json_object.get_string('todos_invitan');
    l_objeto.usuarios                 := NULL; -- TODO
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_grupo', self.id_grupo);
    l_json_object.put('id_torneo', self.id_torneo);
    l_json_object.put('descripcion', self.descripcion);
    l_json_object.put('tipo', self.tipo);
    l_json_object.put('id_usuario_administrador',
                      self.id_usuario_administrador);
    l_json_object.put('fecha_creacion', self.fecha_creacion);
    l_json_object.put('id_jornada_inicio', self.id_jornada_inicio);
    l_json_object.put('estado', self.estado);
    l_json_object.put('situacion', self.situacion);
    l_json_object.put('id_club', self.id_club);
    l_json_object.put('todos_invitan', self.todos_invitan);
  
    IF self.usuarios IS NULL THEN
      l_json_object.put_null('usuarios');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.usuarios.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.usuarios(i).to_json));
        i := self.usuarios.next(i);
      END LOOP;
      l_json_object.put('usuarios', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
