CREATE OR REPLACE PACKAGE k_imagenes_fan IS

  /**
  Agrupa operaciones relacionadas con el consumo de webservices de Imágenes de Fantasy.
  
  %author dmezac 20/03/2022 19:28:59
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

  -- Url base de webservices de Imágenes de Fantasy
  c_url_base CONSTANT VARCHAR2(300) := k_util.f_valor_parametro('URL_IMAGENES_SERVICIOS');

  -- Posibles respuestas en variable de salida o_ok
  c_success    CONSTANT VARCHAR2(1) := 'S'; --éxito
  c_auth_error CONSTANT VARCHAR2(1) := 'X'; --no autorizado
  c_error      CONSTANT VARCHAR2(1) := 'N'; --error

  --Procedimiento para obtener una imagen
  PROCEDURE p_combinar_imagenes(i_imagen_base      IN CLOB,
                                i_imagen_cobertura IN CLOB,
                                o_ok               OUT VARCHAR2,
                                o_response         OUT CLOB);

END k_imagenes_fan;
/
CREATE OR REPLACE PACKAGE BODY k_imagenes_fan IS

  --Procedimiento para obtener una imagen
  PROCEDURE p_combinar_imagenes(i_imagen_base      IN CLOB,
                                i_imagen_cobertura IN CLOB,
                                o_ok               OUT VARCHAR2,
                                o_response         OUT CLOB) AS
    --
    c_url CONSTANT VARCHAR2(300) := c_url_base || '/rest/overlay';
    v_url VARCHAR2(300);
    --
    ret      CLOB;
    postdata CLOB;
    req      utl_http.req;
    resp     utl_http.resp;
    --
    req_length NUMBER;
    buffer     VARCHAR2(2000);
    offset     PLS_INTEGER := 1;
    amount     PLS_INTEGER := 1024;
    --
    v_response CLOB;
  BEGIN
    -- URL WS
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
  
    v_url := c_url;
  
    -- Enviamos Parametros
    postdata := '';
    postdata := postdata || 'image=' || REPLACE(i_imagen_base, '+', '%2B') || '&' ||
                'overlay=' || REPLACE(i_imagen_cobertura, '+', '%2B');
    --DBMS_OUTPUT.PUT_LINE( postData);
    req_length := dbms_lob.getlength(postdata);
    dbms_output.put_line(req_length);
  
    req := utl_http.begin_request(url => v_url, method => 'POST');
  
    utl_http.set_header(req,
                        'Content-Type',
                        'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postdata));
    utl_http.set_header(req, 'Transfer-Encoding', 'chunked');
    --utl_http.write_text(req, postdata);
    WHILE (offset < req_length) LOOP
      dbms_lob.read(postdata, amount, offset, buffer);
      utl_http.write_text(r => req, data => buffer);
      offset := offset + amount;
    END LOOP;
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
    ret := k_util.read_http_body(resp);
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
    
  END p_combinar_imagenes;

BEGIN
  -- Initialization
  -- Set Oracle Wallet location (no arguments needed)
  utl_http.set_wallet('');
END k_imagenes_fan;
/
