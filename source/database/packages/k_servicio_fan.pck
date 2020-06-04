CREATE OR REPLACE PACKAGE k_servicio_fan IS

  /**
  Agrupa operaciones relacionadas con los Servicios Web del dominio FAN
  
  %author jtsoya539 27/3/2020 16:42:26
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

  FUNCTION listar_clubes(i_parametros IN y_parametros) RETURN y_respuesta;

END;
/
CREATE OR REPLACE PACKAGE BODY k_servicio_fan IS

  FUNCTION listar_clubes(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_club;
  
    l_id_club     t_clubes.id_club%TYPE;
    l_id_division t_clubes.id_division%TYPE;
  
    CURSOR cr_elementos(i_id_club     IN VARCHAR2,
                        i_id_division IN VARCHAR2) IS
      SELECT c.id_club,
             c.nombre_oficial,
             c.otros_nombres,
             c.fundacion,
             c.pagina_web,
             c.twitter,
             c.facebook,
             c.id_division,
             c.nombre_corto
        FROM t_clubes c
       WHERE c.id_club = nvl(i_id_club, c.id_club)
         AND c.id_division = nvl(i_id_division, c.id_division);
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_club     := anydata.accessvarchar2(k_servicio.f_valor_parametro(i_parametros,
                                                                         'id_club'));
    l_id_division := anydata.accessvarchar2(k_servicio.f_valor_parametro(i_parametros,
                                                                         'id_division'));
  
    FOR ele IN cr_elementos(l_id_club, l_id_division) LOOP
      l_objeto                := NEW y_club();
      l_objeto.id_club        := ele.id_club;
      l_objeto.nombre_oficial := ele.nombre_oficial;
      l_objeto.nombre_corto   := ele.nombre_corto;
      l_objeto.otros_nombres  := ele.otros_nombres;
      l_objeto.fundacion      := ele.fundacion;
      l_objeto.pagina_web     := ele.pagina_web;
      l_objeto.twitter        := ele.twitter;
      l_objeto.facebook       := ele.facebook;
      l_objeto.id_division    := ele.id_division;
    
      l_objetos.extend;
      l_objetos(l_objetos.count) := l_objeto;
    END LOOP;
    l_pagina.numero_actual      := 0;
    l_pagina.numero_siguiente   := 0;
    l_pagina.numero_ultima      := 0;
    l_pagina.numero_primera     := 0;
    l_pagina.numero_anterior    := 0;
    l_pagina.cantidad_elementos := l_objetos.count;
    l_pagina.elementos          := l_objetos;
  
    k_servicio.p_respuesta_ok(l_rsp, l_pagina);
    RETURN l_rsp;
  EXCEPTION
    WHEN k_servicio.ex_error_parametro THEN
      RETURN l_rsp;
    WHEN k_servicio.ex_error_general THEN
      RETURN l_rsp;
    WHEN OTHERS THEN
      k_servicio.p_respuesta_excepcion(l_rsp,
                                       utl_call_stack.error_number(1),
                                       utl_call_stack.error_msg(1),
                                       dbms_utility.format_error_stack);
      RETURN l_rsp;
  END;

END;
/
