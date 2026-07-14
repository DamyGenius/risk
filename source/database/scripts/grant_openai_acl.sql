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

set define on

accept v_user char default 'risk' prompt 'Ingrese usuario owner del esquema (por defecto ''risk''):'

prompt
prompt Otorgando permisos de UTL_HTTP para &v_user...
prompt -----------------------------------

GRANT EXECUTE ON sys.utl_http TO &v_user;

prompt
prompt Creando ACL para api.openai.com...
prompt -----------------------------------

BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host       => 'api.openai.com',
    lower_port => 443,
    upper_port => 443,
    ace        => xs$ace_type(
                    privilege_list => xs$name_list('connect'),
                    principal_name => upper('&v_user'),
                    principal_type => xs_acl.ptype_db));
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => 'api.openai.com',
    ace  => xs$ace_type(
              privilege_list => xs$name_list('resolve'),
              principal_name => upper('&v_user'),
              principal_type => xs_acl.ptype_db));
END;
/

COMMIT;

prompt
prompt Verificando ACL creada...
prompt -----------------------------------

COLUMN host FORMAT A30
COLUMN principal FORMAT A20
COLUMN privilege FORMAT A12
COLUMN status FORMAT A10

SELECT host,
       lower_port,
       upper_port,
       principal,
       privilege
  FROM dba_host_aces
 WHERE lower(host) = 'api.openai.com'
   AND principal = upper('&v_user')
 ORDER BY host,
          lower_port NULLS FIRST,
          privilege;

set define off
