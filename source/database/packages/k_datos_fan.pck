create or replace package k_datos_fan is

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
  c_url_base constant varchar2(300) := 'https://www.rama.com.py/proyecto-ne-wsdatos';

  -- Posibles respuestas en variable de salida o_ok
  c_success    constant varchar2(1) := 'S'; --éxito
  c_auth_error constant varchar2(1) := 'X'; --no autorizado
  c_error      constant varchar2(1) := 'N'; --error

  --Procedimiento para obtener datos de las posiciones
  procedure p_posiciones
        (o_ok       out varchar2,
         o_response out CLOB);

  --Procedimiento para obtener datos del fixture
  procedure p_fixture
        (o_ok       out varchar2,
         o_response out CLOB);

  --Procedimiento para obtener datos de los planteles
  procedure p_planteles
        (o_ok       out varchar2,
         o_response out CLOB);

  --Procedimiento para obtener datos de un partido
  procedure p_partido
        (i_partido  in varchar2,
         o_ok       out varchar2,
         o_response out CLOB);

end k_datos_fan;
/
create or replace package body k_datos_fan is

  --Función interna para comunicación con WS
  function lf_read_http_body(resp in out utl_http.resp)
    return clob AS
    --
    ret   clob;
    v_msg varchar2(2048);
  begin
    begin
      loop
        utl_http.read_text(resp, v_msg, 512);
        ret := ret || v_msg;
      end loop;
    exception
      when utl_http.end_of_body then
        null;
    end;
    return ret;
  end lf_read_http_body;

  --Procedimiento para obtener datos de las posiciones
  procedure p_posiciones
        (o_ok       out varchar2,
         o_response out CLOB)
  as
    --
    c_url     constant varchar2(300) := c_url_base || '/rest/posiciones';
    v_url     varchar2(300);
    --
    ret       clob;
    postData  clob;
    req       utl_http.req;
    resp      utl_http.resp;
    --
    v_response clob;
  begin
    -- URL WS
    utl_http.set_response_error_check(enable => FALSE);
    utl_http.set_body_charset('UTF-8');

    v_url   := c_url;

    -- Enviamos Parametros
    postData := '';
    --DBMS_OUTPUT.PUT_LINE( postData);

    req := utl_http.begin_request(url    => v_url,
                                  method => 'GET');

    utl_http.set_header(req, 'Content-Type', 'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);

    if resp.status_code < 300 then -- Respuesta exitosa
      o_ok := c_success;
    elsif resp.status_code = 401 then -- No autorizado
      o_ok := c_auth_error;
    else -- Otro error
      o_ok := c_error;
    end if;

    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);

    -- Parse de la respuesta
    v_response := replace(ret, chr(10), ' ');

    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;

  exception
    when others then
      o_ok := c_error;
      o_response := DBMS_UTILITY.format_error_stack;

  end p_posiciones;

  --Procedimiento para obtener datos del fixture
  procedure p_fixture
        (o_ok       out varchar2,
         o_response out CLOB)
  as
    --
    c_url     constant varchar2(300) := c_url_base || '/rest/fixture';
    v_url     varchar2(300);
    --
    ret       clob;        
    postData  clob;
    req       utl_http.req;
    resp      utl_http.resp;
    --
    v_response clob;
  begin
    -- URL WS
    utl_http.set_response_error_check(enable => FALSE);
    utl_http.set_body_charset('UTF-8');

    v_url   := c_url;

    -- Enviamos Parametros
    postData := '';
    --DBMS_OUTPUT.PUT_LINE( postData);

    req := utl_http.begin_request(url    => v_url,
                                  method => 'GET');

    utl_http.set_header(req, 'Content-Type', 'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);

    if resp.status_code < 300 then -- Respuesta exitosa
      o_ok := c_success;
    elsif resp.status_code = 401 then -- No autorizado
      o_ok := c_auth_error;
    else -- Otro error
      o_ok := c_error;
    end if;

    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);

    -- Parse de la respuesta
    v_response := replace(ret, chr(10), ' ');

    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;

  exception
    when others then
      o_ok := c_error;
      o_response := DBMS_UTILITY.format_error_stack;

  end p_fixture;

  --Procedimiento para obtener datos de los planteles
  procedure p_planteles
        (o_ok       out varchar2,
         o_response out CLOB)
  as
    --
    c_url     constant varchar2(300) := c_url_base || '/rest/planteles';
    v_url     varchar2(300);
    --
    ret       clob;
    postData  clob;
    req       utl_http.req;
    resp      utl_http.resp;
    --
    v_response clob;
  begin
    -- URL WS
    utl_http.set_response_error_check(enable => FALSE);
    utl_http.set_body_charset('UTF-8');

    v_url   := c_url;

    -- Enviamos Parametros
    postData := '';
    --DBMS_OUTPUT.PUT_LINE( postData);

    req := utl_http.begin_request(url    => v_url,
                                  method => 'GET');

    utl_http.set_header(req, 'Content-Type', 'application/x-www-form-urlencoded');
    --utl_http.set_header(req, 'Content-Length', length(postData));
    --utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);

    if resp.status_code < 300 then -- Respuesta exitosa
      o_ok := c_success;
    elsif resp.status_code = 401 then -- No autorizado
      o_ok := c_auth_error;
    else -- Otro error
      o_ok := c_error;
    end if;

    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);

    -- Parse de la respuesta
    v_response := replace(ret, chr(10), ' ');

    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;

  exception
    when others then
      o_ok := c_error;
      o_response := DBMS_UTILITY.format_error_stack;

  end p_planteles;

  --Procedimiento para obtener datos de un partido
  procedure p_partido
        (i_partido  in varchar2,
         o_ok       out varchar2,
         o_response out CLOB)
  as
    --
    c_url     constant varchar2(300) := c_url_base || '/rest/partido';
    v_url     varchar2(300);
    --
    ret       clob;
    postData  clob;
    req       utl_http.req;
    resp      utl_http.resp;
    --
    v_response clob;
  begin
    -- URL WS
    utl_http.set_response_error_check(enable => FALSE);
    utl_http.set_body_charset('UTF-8');

    v_url   := c_url;

    -- Enviamos Parametros
    postData := '';
    postData := postData || 'idPartido=' || i_partido ;
    --DBMS_OUTPUT.PUT_LINE( postData);

    req := utl_http.begin_request(url    => v_url,
                                  method => 'POST');

    utl_http.set_header(req, 'Content-Type', 'application/x-www-form-urlencoded');
    utl_http.set_header(req, 'Content-Length', length(postData));
    utl_http.write_text(req, postData);
    resp := utl_http.get_response(r => req);

    if resp.status_code < 300 then -- Respuesta exitosa
      o_ok := c_success;
    elsif resp.status_code = 401 then -- No autorizado
      o_ok := c_auth_error;
    else -- Otro error
      o_ok := c_error;
    end if;

    -- Respuesta del WS
    ret := lf_read_http_body(resp);
    utl_http.end_response(r => resp);

    -- Parse de la respuesta
    v_response := replace(ret, chr(10), ' ');

    --Result
    --DBMS_OUTPUT.PUT_LINE( v_response);
    o_response := v_response;

  exception
    when others then
      o_ok := c_error;
      o_response := DBMS_UTILITY.format_error_stack;

  end p_partido;

begin
  -- Initialization
  -- Set Oracle Wallet location (no arguments needed)
  UTL_HTTP.SET_WALLET('');
end k_datos_fan;
/
