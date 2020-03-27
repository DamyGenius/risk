CREATE OR REPLACE PACKAGE k_util IS

  /**
  Agrupa herramientas para facilitar el desarrollo
  
  %author jtsoya539 27/3/2020 17:05:34
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

  /**
  Genera trigger de secuencia para un campo de una tabla
  
  %author jtsoya539 27/3/2020 17:06:21
  %param i_tabla Tabla
  %param i_campo Campo
  %param i_trigger Trigger
  */
  PROCEDURE p_generar_trigger_secuencia(i_tabla   IN VARCHAR2,
                                        i_campo   IN VARCHAR2,
                                        i_trigger IN VARCHAR2 DEFAULT NULL);

  /**
  Retorna el valor que se encuenta en la posicion indicada dentro de una cadena
  Si la posicion se encuentra fuera de rango retorna el valor mas cercano (primer valor o ultimo valor)
  
  %author jtsoya539 27/3/2020 17:07:15
  %param i_cadena Cadena
  %param i_posicion Posicion dentro de la cadena
  %param i_separador Caracter separador. Por defecto '~'
  %return Valor que se encuenta en la posicion indicada
  */
  FUNCTION f_valor_posicion(i_cadena    IN VARCHAR2,
                            i_posicion  IN NUMBER,
                            i_separador IN VARCHAR2 DEFAULT '~')
    RETURN VARCHAR2;

  FUNCTION f_reemplazar_acentos(i_cadena IN VARCHAR2) RETURN VARCHAR2;

  /**
  Retorna el significado de un codigo dentro de un dominio
  
  %author jtsoya539 27/3/2020 17:08:39
  %param i_dominio Dominio
  %param i_codigo Codigo
  %return Significado
  */
  FUNCTION f_significado_codigo(i_dominio IN VARCHAR2,
                                i_codigo  IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_valor_parametro(i_id_parametro IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_json_objeto(i_objeto IN anydata) RETURN CLOB;

  FUNCTION f_base_datos RETURN VARCHAR2;

  FUNCTION f_terminal RETURN VARCHAR2;

  FUNCTION f_host RETURN VARCHAR2;

  FUNCTION f_direccion_ip RETURN VARCHAR2;

  FUNCTION f_esquema_actual RETURN VARCHAR2;

END;
/
CREATE OR REPLACE PACKAGE BODY k_util IS

  PROCEDURE p_generar_trigger_secuencia(i_tabla   IN VARCHAR2,
                                        i_campo   IN VARCHAR2,
                                        i_trigger IN VARCHAR2 DEFAULT NULL) IS
    l_sentencia VARCHAR2(4000);
    l_trigger   VARCHAR2(30);
  BEGIN
    l_trigger := lower(nvl(i_trigger, 'gs_' || substr(i_tabla, 3)));
  
    -- Genera secuencia
    l_sentencia := 'CREATE SEQUENCE s_' || lower(i_campo);
    EXECUTE IMMEDIATE l_sentencia;
  
    -- Genera trigger
    l_sentencia := 'CREATE OR REPLACE TRIGGER ' || l_trigger || '
  BEFORE INSERT ON ' || lower(i_tabla) || '
  FOR EACH ROW
BEGIN
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
  
  IF :new.' || lower(i_campo) || ' IS NULL THEN
    :new.' || lower(i_campo) || ' := s_' ||
                   lower(i_campo) || '.nextval;
  END IF;
END;';
    EXECUTE IMMEDIATE l_sentencia;
  END;

  FUNCTION f_valor_posicion(i_cadena    IN VARCHAR2,
                            i_posicion  IN NUMBER,
                            i_separador IN VARCHAR2 DEFAULT '~')
    RETURN VARCHAR2 IS
    l_valor           VARCHAR2(1000);
    l_posicion        NUMBER;
    l_separador       VARCHAR2(10);
    l_longitud_valor  NUMBER;
    l_posicion_inicio NUMBER;
    l_posicion_fin    NUMBER;
  BEGIN
    l_separador := i_separador;
  
    IF i_posicion > 0 THEN
      l_posicion := i_posicion;
    ELSE
      l_posicion := 1;
    END IF;
  
    -- Posicion del inicio del valor dentro de la cadena
    IF l_posicion > 1 THEN
      l_posicion_inicio := instr(i_cadena, l_separador, 1, l_posicion - 1);
      IF l_posicion_inicio = 0 THEN
        l_posicion_inicio := instr(i_cadena, l_separador, -1, 1);
      END IF;
      l_posicion_inicio := l_posicion_inicio + 1;
    ELSE
      l_posicion_inicio := 1;
    END IF;
  
    -- Posicion del fin del valor dentro de la cadena
    l_posicion_fin := instr(i_cadena, l_separador, 1, l_posicion);
  
    IF l_posicion_fin = 0 THEN
      l_valor := substr(i_cadena, l_posicion_inicio);
    ELSE
      l_longitud_valor := l_posicion_fin - l_posicion_inicio;
      l_valor          := substr(i_cadena,
                                 l_posicion_inicio,
                                 l_longitud_valor);
    END IF;
    RETURN l_valor;
  END;

  FUNCTION f_reemplazar_acentos(i_cadena IN VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN translate(i_cadena,
                     '����������������������������������������������',
                     'aeiouaeiouaeiouaeioucaoAEIOUAEIOUAEIOUAEIOUCAO');
  END;

  FUNCTION f_significado_codigo(i_dominio IN VARCHAR2,
                                i_codigo  IN VARCHAR2) RETURN VARCHAR2 IS
    l_significado t_significados.significado%TYPE;
  BEGIN
    BEGIN
      SELECT a.significado
        INTO l_significado
        FROM t_significados a
       WHERE a.dominio = i_dominio
         AND a.codigo = i_codigo;
    EXCEPTION
      WHEN OTHERS THEN
        l_significado := NULL;
    END;
    RETURN l_significado;
  END;

  FUNCTION f_valor_parametro(i_id_parametro IN VARCHAR2) RETURN VARCHAR2 IS
    l_valor t_parametros.valor%TYPE;
  BEGIN
    BEGIN
      SELECT a.valor
        INTO l_valor
        FROM t_parametros a
       WHERE a.id_parametro = i_id_parametro;
    EXCEPTION
      WHEN OTHERS THEN
        l_valor := NULL;
    END;
    RETURN l_valor;
  END;

  FUNCTION f_json_objeto(i_objeto IN anydata) RETURN CLOB IS
    l_json     CLOB;
    l_typeinfo anytype;
    l_typecode PLS_INTEGER;
  BEGIN
    IF i_objeto IS NOT NULL THEN
      l_typecode := i_objeto.gettype(l_typeinfo);
      IF l_typecode = dbms_types.typecode_object THEN
        EXECUTE IMMEDIATE 'DECLARE
  l_retorno PLS_INTEGER;
  l_anydata anydata := :1;
  l_object  ' || i_objeto.gettypename || ';
  l_clob    CLOB;
BEGIN
  l_retorno := l_anydata.getobject(obj => l_object);
  :2        := l_object.to_json();
END;'
          USING IN i_objeto, OUT l_json;
      END IF;
    END IF;
    RETURN l_json;
  END;

  FUNCTION f_base_datos RETURN VARCHAR2 IS
  BEGIN
    RETURN sys_context('USERENV', 'DB_NAME');
  END;

  FUNCTION f_terminal RETURN VARCHAR2 IS
  BEGIN
    RETURN sys_context('USERENV', 'TERMINAL');
  END;

  FUNCTION f_host RETURN VARCHAR2 IS
  BEGIN
    RETURN sys_context('USERENV', 'HOST');
  END;

  FUNCTION f_direccion_ip RETURN VARCHAR2 IS
  BEGIN
    RETURN sys_context('USERENV', 'IP_ADDRESS');
  END;

  FUNCTION f_esquema_actual RETURN VARCHAR2 IS
  BEGIN
    RETURN sys_context('USERENV', 'CURRENT_SCHEMA');
  END;

END;
/
