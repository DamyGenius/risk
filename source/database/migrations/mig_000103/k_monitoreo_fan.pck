CREATE OR REPLACE PACKAGE k_monitoreo_fan IS

  /**
  Agrupa operaciones relacionadas con los Monitoreos de Conflictos del dominio FAN
  
  %author dmezac 24/5/2022 15:04:41
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

  --Cierre de partidos pendientes de contabilización de puntajes
  FUNCTION puntajes_pendientes_partidos(i_parametros IN y_parametros)
    RETURN y_respuesta;

END;
/
CREATE OR REPLACE PACKAGE BODY k_monitoreo_fan IS

  FUNCTION puntajes_pendientes_partidos(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp        y_respuesta;
    l_id_partido t_partidos.id_partido%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar  := 'Obteniendo parámetros';
    l_id_partido := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'id_partido');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_partido IS NOT NULL,
                                    'Debe ingresar id_partido');
  
    l_rsp.lugar := 'Cierre de partidos pendientes de contabilización de puntajes';
    k_puntajes_fan.p_cerrar_partido(i_id_partido => l_id_partido,
                                    i_notificar  => 'N');
  
    k_operacion.p_respuesta_ok(l_rsp);
    RETURN l_rsp;
  EXCEPTION
    WHEN k_operacion.ex_error_parametro THEN
      RETURN l_rsp;
    WHEN k_operacion.ex_error_general THEN
      RETURN l_rsp;
    WHEN OTHERS THEN
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      RETURN l_rsp;
  END;

END;
/
