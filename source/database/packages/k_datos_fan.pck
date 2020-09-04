CREATE OR REPLACE PACKAGE k_datos_fan IS

  /**
  Agrupa operaciones relacionadas con el consumo de webservices de Datos de Fantasy.
  
  %author dmezac 29/08/2020 21:28:59
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

  -- Url base de webservices de Datos de Fantasy
  c_url_base CONSTANT VARCHAR2(300) := 'https://www.rama.com.py/proyecto-ne-wsdatos';

  -- Posibles respuestas en variable de salida o_ok
  c_success    CONSTANT VARCHAR2(1) := 'S'; --éxito
  c_auth_error CONSTANT VARCHAR2(1) := 'X'; --no autorizado
  c_error      CONSTANT VARCHAR2(1) := 'N'; --error

  --Procedimiento para obtener datos de las posiciones
  PROCEDURE p_posiciones(o_ok       OUT VARCHAR2,
                         o_response OUT CLOB);

  --Procedimiento para obtener datos del fixture
  PROCEDURE p_fixture(o_ok       OUT VARCHAR2,
                      o_response OUT CLOB);

  --Procedimiento para obtener datos de los planteles
  PROCEDURE p_planteles(o_ok       OUT VARCHAR2,
                        o_response OUT CLOB);

  --Procedimiento para obtener datos de un partido
  PROCEDURE p_partido(i_partido  IN VARCHAR2,
                      o_ok       OUT VARCHAR2,
                      o_response OUT CLOB);

END k_datos_fan;
/
CREATE OR REPLACE PACKAGE BODY k_datos_fan IS

  --Función interna para comunicación con WS
  FUNCTION lf_read_http_body(resp IN OUT utl_http.resp) RETURN CLOB AS
    --
    ret   CLOB;
    v_msg VARCHAR2(2048);
  BEGIN
    BEGIN
      LOOP
        utl_http.read_text(resp, v_msg, 512);
        ret := ret || v_msg;
      END LOOP;
    EXCEPTION
      WHEN utl_http.end_of_body THEN
        NULL;
    END;
    RETURN ret;
  END lf_read_http_body;

  --Procedimiento para obtener datos de las posiciones
  PROCEDURE p_posiciones(o_ok       OUT VARCHAR2,
                         o_response OUT CLOB) AS
    --
    c_url CONSTANT VARCHAR2(300) := c_url_base || '/rest/posiciones';
    v_url VARCHAR2(300);
    --
    ret      CLOB;
    postdata CLOB;
    req      utl_http.req;
    resp     utl_http.resp;
    --
    v_response CLOB;
  BEGIN
    -- URL WS
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
  
    v_url := c_url;
  
    -- Enviamos Parametros
    postdata := '';
    --DBMS_OUTPUT.PUT_LINE( postData);
  
    req := utl_http.begin_request(url => v_url, method => 'GET');
  
    utl_http.set_header(req,
                        'Content-Type',
                        'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);
  
    IF resp.status_code < 300 THEN
      -- Respuesta exitosa
      o_ok := c_success;
    ELSIF resp.status_code = 401 THEN
      -- No autorizado
      o_ok := c_auth_error;
    ELSE
      -- Otro error
      o_ok := c_error;
    END IF;
  
    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);
  
    -- Parse de la respuesta
    v_response := REPLACE(ret, chr(10), ' ');
  
    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;
  
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
    
  END p_posiciones;

  --Procedimiento para obtener datos del fixture
  PROCEDURE p_fixture(o_ok       OUT VARCHAR2,
                      o_response OUT CLOB) AS
    --
    c_url CONSTANT VARCHAR2(300) := c_url_base || '/rest/fixture';
    v_url VARCHAR2(300);
    --
    ret      CLOB;
    postdata CLOB;
    req      utl_http.req;
    resp     utl_http.resp;
    --
    v_response CLOB;
    -- ejemplo de una respuesta exitosa:
    -- [{"id":-1,"numeroFecha":3,"local":{"id":115},"visitante":{"id":2119},"dia":"4-9-2020","hora":"13:17","golesLocal":2,"golesVisitante":1,"estado":"F"}];
  BEGIN
    -- URL WS
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
  
    v_url := c_url;
  
    -- Enviamos Parametros
    postdata := '';
    --DBMS_OUTPUT.PUT_LINE( postData);
  
    req := utl_http.begin_request(url => v_url, method => 'GET');
  
    utl_http.set_header(req,
                        'Content-Type',
                        'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);
  
    IF resp.status_code < 300 THEN
      -- Respuesta exitosa
      o_ok := c_success;
    ELSIF resp.status_code = 401 THEN
      -- No autorizado
      o_ok := c_auth_error;
    ELSE
      -- Otro error
      o_ok := c_error;
    END IF;
  
    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);
  
    -- Parse de la respuesta
    v_response := REPLACE(ret, chr(10), ' ');
  
    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;
  
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
    
  END p_fixture;

  --Procedimiento para obtener datos de los planteles
  PROCEDURE p_planteles(o_ok       OUT VARCHAR2,
                        o_response OUT CLOB) AS
    --
    c_url CONSTANT VARCHAR2(300) := c_url_base || '/rest/planteles';
    v_url VARCHAR2(300);
    --
    ret      CLOB;
    postdata CLOB;
    req      utl_http.req;
    resp     utl_http.resp;
    --
    v_response CLOB;
  BEGIN
    -- URL WS
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
  
    v_url := c_url;
  
    -- Enviamos Parametros
    postdata := '';
    --DBMS_OUTPUT.PUT_LINE( postData);
  
    req := utl_http.begin_request(url => v_url, method => 'GET');
  
    utl_http.set_header(req,
                        'Content-Type',
                        'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);
  
    IF resp.status_code < 300 THEN
      -- Respuesta exitosa
      o_ok := c_success;
    ELSIF resp.status_code = 401 THEN
      -- No autorizado
      o_ok := c_auth_error;
    ELSE
      -- Otro error
      o_ok := c_error;
    END IF;
  
    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);
  
    -- Parse de la respuesta
    v_response := REPLACE(ret, chr(10), ' ');
  
    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;
  
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
    
  END p_planteles;

  --Procedimiento para obtener datos de un partido
  PROCEDURE p_partido(i_partido  IN VARCHAR2,
                      o_ok       OUT VARCHAR2,
                      o_response OUT CLOB) AS
    --
    c_url CONSTANT VARCHAR2(300) := c_url_base || '/rest/partido';
    v_url VARCHAR2(300);
    --
    ret      CLOB;
    postdata CLOB;
    req      utl_http.req;
    resp     utl_http.resp;
    --
    v_response CLOB;
  BEGIN
    -- URL WS
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
  
    v_url := c_url;
  
    -- Enviamos Parametros
    postdata := '';
    postdata := postdata || 'idPartido=' || i_partido;
    --DBMS_OUTPUT.PUT_LINE( postData);
  
    req := utl_http.begin_request(url => v_url, method => 'POST');
  
    utl_http.set_header(req,
                        'Content-Type',
                        'application/x-www-form-urlencoded');
    utl_http.set_header(req, 'Content-Length', length(postdata));
    utl_http.write_text(req, postdata);
    resp := utl_http.get_response(r => req);
  
    IF resp.status_code < 300 THEN
      -- Respuesta exitosa
      o_ok := c_success;
    ELSIF resp.status_code = 401 THEN
      -- No autorizado
      o_ok := c_auth_error;
    ELSE
      -- Otro error
      o_ok := c_error;
    END IF;
  
    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);
  
    -- Parse de la respuesta
    v_response := REPLACE(ret, chr(10), ' ');
  
    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;
  
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
    
  END p_partido;

BEGIN
  -- Initialization
  -- Set Oracle Wallet location (no arguments needed)
  utl_http.set_wallet('');
END k_datos_fan;
/
