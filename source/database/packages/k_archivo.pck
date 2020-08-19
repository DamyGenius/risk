CREATE OR REPLACE PACKAGE k_archivo IS

  /**
  Agrupa operaciones relacionadas con archivos
  
  %author jtsoya539 27/3/2020 16:22:16
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

  FUNCTION f_tipo_mime(i_dominio   IN VARCHAR2,
                       i_extension IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_recuperar_archivo(i_tabla      IN VARCHAR2,
                               i_campo      IN VARCHAR2,
                               i_referencia IN VARCHAR2,
                               i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo;

  PROCEDURE p_guardar_archivo(i_tabla      IN VARCHAR2,
                              i_campo      IN VARCHAR2,
                              i_referencia IN VARCHAR2,
                              i_archivo    IN y_archivo);

  PROCEDURE p_calcular_propiedades(i_contenido IN BLOB,
                                   o_checksum  OUT VARCHAR2,
                                   o_tamano    OUT NUMBER);

  FUNCTION f_version_archivo(i_tabla      IN VARCHAR2,
                             i_campo      IN VARCHAR2,
                             i_referencia IN VARCHAR2) RETURN NUMBER;

END;
/
CREATE OR REPLACE PACKAGE BODY k_archivo IS

  FUNCTION f_tipo_mime(i_dominio   IN VARCHAR2,
                       i_extension IN VARCHAR2) RETURN VARCHAR2 IS
    l_referencia t_significados.referencia%TYPE;
  BEGIN
    BEGIN
      SELECT a.referencia
        INTO l_referencia
        FROM t_significados a
       WHERE a.activo = 'S'
         AND a.dominio = i_dominio
         AND upper(a.codigo) = upper(i_extension);
    EXCEPTION
      WHEN OTHERS THEN
        l_referencia := NULL;
    END;
    RETURN l_referencia;
  END;

  FUNCTION f_recuperar_archivo(i_tabla      IN VARCHAR2,
                               i_campo      IN VARCHAR2,
                               i_referencia IN VARCHAR2,
                               i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo IS
    l_archivo y_archivo;
  BEGIN
    l_archivo := NEW y_archivo();
  
    BEGIN
      SELECT a.contenido,
             a.checksum,
             a.tamano,
             a.nombre,
             a.extension,
             f_tipo_mime(d.extensiones_permitidas, a.extension)
        INTO l_archivo.contenido,
             l_archivo.checksum,
             l_archivo.tamano,
             l_archivo.nombre,
             l_archivo.extension,
             l_archivo.tipo_mime
        FROM t_archivos a, t_archivo_definiciones d
       WHERE d.tabla = a.tabla
         AND d.campo = a.campo
         AND upper(a.tabla) = upper(i_tabla)
         AND upper(a.campo) = upper(i_campo)
         AND a.referencia = i_referencia
         AND nvl(a.version_actual, 0) = nvl(i_version, nvl(a.version_actual, 0));
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20000, 'Archivo inexistente');
      WHEN OTHERS THEN
        raise_application_error(-20000, 'Error al recuperar archivo');
    END;
  
    RETURN l_archivo;
  END;

  PROCEDURE p_guardar_archivo(i_tabla      IN VARCHAR2,
                              i_campo      IN VARCHAR2,
                              i_referencia IN VARCHAR2,
                              i_archivo    IN y_archivo) IS
  BEGIN
    UPDATE t_archivos a
       SET a.contenido      = i_archivo.contenido,
           a.nombre         = i_archivo.nombre,
           a.extension      = i_archivo.extension,
           a.version_actual = nvl(a.version_actual, 0) + 1
     WHERE upper(a.tabla) = upper(i_tabla)
       AND upper(a.campo) = upper(i_campo)
       AND a.referencia = i_referencia;
  
    IF SQL%NOTFOUND THEN
      INSERT INTO t_archivos
        (tabla, campo, referencia, contenido, nombre, extension, version_actual)
      VALUES
        (upper(i_tabla),
         upper(i_campo),
         i_referencia,
         i_archivo.contenido,
         i_archivo.nombre,
         i_archivo.extension,
         1);
    END IF;
  END;

  PROCEDURE p_calcular_propiedades(i_contenido IN BLOB,
                                   o_checksum  OUT VARCHAR2,
                                   o_tamano    OUT NUMBER) IS
  BEGIN
    IF i_contenido IS NOT NULL THEN
      o_checksum := to_char(rawtohex(dbms_crypto.hash(i_contenido,
                                                      dbms_crypto.hash_sh1)));
      o_tamano   := dbms_lob.getlength(i_contenido);
    END IF;
  END;

  FUNCTION f_version_archivo(i_tabla      IN VARCHAR2,
                             i_campo      IN VARCHAR2,
                             i_referencia IN VARCHAR2) RETURN NUMBER IS
    l_version t_archivos.version_actual%TYPE;
  BEGIN
  
      SELECT nvl(a.version_actual, 0)
        INTO l_version
        FROM t_archivos a, t_archivo_definiciones d
       WHERE d.tabla = a.tabla
         AND d.campo = a.campo
         AND upper(a.tabla) = upper(i_tabla)
         AND upper(a.campo) = upper(i_campo)
         AND a.referencia = i_referencia;
  
    RETURN l_version;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

END;
/
