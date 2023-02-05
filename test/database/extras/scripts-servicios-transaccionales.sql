declare
  c_declaracion constant varchar2(2000) := '/*
--------------------------------- MIT License ---------------------------------
Copyright (c) '||to_char(sysdate,'YYYY')||' '||'dmezac'||'

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
*/'||chr(10)||chr(10);
  --
  l_id_operacion t_operaciones.id_operacion%type := 83;
  l_tipo_rest varchar2(5) := '&TIPO_REST'; --GET/POST
  l_permite_anonimo varchar2(5) := '&permite_anonimo'; --S/N
  --
  l_nombre_servicio_api t_operaciones.nombre%type;
  l_tiene_cuerpo boolean := l_tipo_rest = 'POST';
  
  cursor c_servicios(i_id_operacion number) is
    select a.*
     from t_operaciones a, t_servicios b
    where a.id_operacion = i_id_operacion
    and a.id_operacion=b.id_servicio
    and a.tipo='S'
    and b.tipo='T';--Transaccion

  cursor c_servicio_parametros(i_id_operacion number, i_tipo_parametro varchar2) is
    select a.*
     from t_operacion_parametros a
    where a.id_operacion = i_id_operacion
      and a.tipo_parametro = nvl(i_tipo_parametro,a.tipo_parametro)
      order by a.orden;

  cursor c_servicio_enums(i_id_operacion number, i_tipo_parametro varchar2) is
    select distinct a.valores_posibles enum, a.detalle
     from t_operacion_parametros a
    where a.id_operacion = i_id_operacion
      and a.tipo_parametro = nvl(i_tipo_parametro,a.tipo_parametro)
      and a.valores_posibles is not null
      order by a.valores_posibles;

  cursor c_enum_detalles(i_enum varchar2) is
    select a.*
     from t_significados a
    where a.dominio = i_enum
      and a.activo='S'
      order by a.codigo;

begin
  for se in c_servicios(l_id_operacion) loop
    l_nombre_servicio_api := k_util.to_camelcase(se.nombre, true);
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');

    -- Enums Api
    for sn in c_servicio_enums(l_id_operacion, null) loop
      declare
        l_nombre_enum t_operacion_parametros.nombre%type := k_util.to_camelcase(sn.enum, true);
        l_enum_detalles varchar2(4000);
      begin
        for sv in c_enum_detalles(sn.enum) loop
          declare
          begin
            l_enum_detalles := l_enum_detalles || case when l_enum_detalles is not null then ',' end ||
                               chr(10) || '        [StringValue("'||sv.codigo||'")]
        '||k_util.to_camelcase(sv.significado, true)||'';
          end;
        end loop;

        DBMS_OUTPUT.PUT_LINE('--'||l_nombre_enum||'.cs');
        DBMS_OUTPUT.PUT_LINE(c_declaracion||'using Risk.API.Attributes;
using Swashbuckle.AspNetCore.Annotations;

namespace Risk.API.Models
{
    [SwaggerSchema("'||sn.detalle||'")]
    public enum '||l_nombre_enum||'
    {'||l_enum_detalles||'
    }
}');
      end;
    end loop;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');

    --Controller Api
    declare
      l_query_params varchar2(4000);
      l_params_service varchar2(4000);
    begin
      for sp in c_servicio_parametros(l_id_operacion, 'QUERY') loop
        declare
          l_nombre_parametro_api t_operacion_parametros.nombre%type := k_util.to_camelcase(sp.nombre);
          l_tipo_dato_param_api varchar2(20) := case when sp.valores_posibles is not null then
                                                  k_util.to_camelcase(sp.valores_posibles, true)
                                                  else k_util.f_referencia_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato) end;
        begin
          l_query_params := l_query_params || case when l_query_params is not null then ','||chr(10)||'              ' end ||
                            '[FromQuery, SwaggerParameter(Description = "'||sp.detalle||'", Required = '||case sp.obligatorio when 'S' then 'true' else 'false' end||')] '||l_tipo_dato_param_api||' '||l_nombre_parametro_api||'';
        end;
      end loop;

      for sp in c_servicio_parametros(l_id_operacion, null) loop
        declare
          l_nombre_parametro_api t_operacion_parametros.nombre%type := k_util.to_camelcase(sp.nombre);
          l_tipo_dato_param_api varchar2(20):=k_util.f_referencia_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato);
        begin
          l_params_service := l_params_service || case when l_params_service is not null then ', ' end ||
                              ''||case sp.tipo_parametro when 'QUERY' then l_nombre_parametro_api
                                                         else 'requestBody.' || k_util.to_camelcase(sp.nombre,true) end ||'';
        end;
      end loop;

      DBMS_OUTPUT.PUT_LINE('--'||initcap(se.dominio)||'Controller.cs');
      DBMS_OUTPUT.PUT_LINE(case when l_permite_anonimo = 'S' then '          [AllowAnonymous]'||chr(10) end||
                           '          [Http'||initcap(l_tipo_rest)||'("'||l_nombre_servicio_api||'")]
          [SwaggerOperation(OperationId = "'||l_nombre_servicio_api||'", Summary = "'||l_nombre_servicio_api||'", Description = "'||se.detalle||'")]
          [Produces(MediaTypeNames.Application.Json)]
          [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
          public IActionResult '||l_nombre_servicio_api||'('||l_query_params||case when l_tiene_cuerpo then ',
              [FromBody] '||l_nombre_servicio_api||'RequestBody requestBody))' end||'
          {
              var respuesta = _'||lower(se.dominio)||'Service'||'.'||l_nombre_servicio_api||'('||l_params_service||');
              return ProcesarRespuesta(respuesta);
          }');
    end;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');
    
    --Request Body
    if l_tiene_cuerpo then
      declare
        l_body_params varchar2(4000);
      begin
        for sp in c_servicio_parametros(l_id_operacion, 'BODY') loop
          declare
            l_nombre_parametro_api t_operacion_parametros.nombre%type := k_util.to_camelcase(sp.nombre, true);
            l_tipo_dato_param_api varchar2(20) := case when sp.valores_posibles is not null then
                                                  k_util.to_camelcase(sp.valores_posibles, true)
                                                  else k_util.f_referencia_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato) end;
          begin
            l_body_params := l_body_params || chr(10) || '        public '||l_tipo_dato_param_api||' '||l_nombre_parametro_api||' { get; set; }';
          end;
        end loop;

        DBMS_OUTPUT.PUT_LINE('--'||l_nombre_servicio_api||'RequestBody.cs');
        DBMS_OUTPUT.PUT_LINE(c_declaracion||'namespace Risk.API.Models
{
    public class '||l_nombre_servicio_api||'RequestBody
    {'||l_body_params||'
    }
}');
      end;
    end if;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');
    
    --IService Api
    declare
      l_params varchar2(4000);
    begin
      for sp in c_servicio_parametros(l_id_operacion, null) loop
        declare
          l_nombre_parametro_api t_operacion_parametros.nombre%type := k_util.to_camelcase(sp.nombre);
          l_tipo_dato_param_api varchar2(20) := case when sp.valores_posibles is not null then
                                                  k_util.to_camelcase(sp.valores_posibles, true)
                                                  else k_util.f_referencia_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato) end;
        begin
          l_params := l_params || case when l_params is not null then ','||' ' end ||
                            ''||l_tipo_dato_param_api||' '||l_nombre_parametro_api||'';
        end;
      end loop;

      DBMS_OUTPUT.PUT_LINE('--'||'I'||initcap(se.dominio)||'Service.cs');
      DBMS_OUTPUT.PUT_LINE('        Respuesta<Dato> '||l_nombre_servicio_api||'('||l_params||');');
    end;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');

    --Service Api
    declare
      l_params varchar2(4000);
      l_params_bd varchar2(4000);
    begin
      for sp in c_servicio_parametros(l_id_operacion, null) loop
        declare
          l_nombre_parametro_api t_operacion_parametros.nombre%type := k_util.to_camelcase(sp.nombre);
          l_tipo_dato_param_api varchar2(20) := case when sp.valores_posibles is not null then
                                                  k_util.to_camelcase(sp.valores_posibles, true)
                                                  else k_util.f_referencia_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato) end;
        begin
          l_params := l_params || case when l_params is not null then ','||' ' end ||
                            ''||l_tipo_dato_param_api||' '||l_nombre_parametro_api||'';
          l_params_bd := l_params_bd || chr(10) || '            prms.Add("'||lower(sp.nombre)||'", '||k_util.to_camelcase(sp.nombre)||
                         case when sp.valores_posibles is not null then '.GetStringValue()' end ||
                         ');';
        end;
      end loop;

      DBMS_OUTPUT.PUT_LINE('--'||initcap(se.dominio)||'Service.cs');
      DBMS_OUTPUT.PUT_LINE('        private const string NOMBRE_'||se.nombre||' = "'||se.nombre||'";');
      DBMS_OUTPUT.PUT_LINE('');
      DBMS_OUTPUT.PUT_LINE('        public Respuesta<Dato> '||l_nombre_servicio_api||'('||l_params||')
        {
            JObject prms = new JObject();'||l_params_bd||'

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_'||se.nombre||',
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }');
    end;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');

    --Cabecera
    declare
      l_variables varchar2(4000);
      l_ini_variables varchar2(4000);
      l_val_variables varchar2(4000);
    begin
      for sp in c_servicio_parametros(l_id_operacion, null) loop
        declare
          l_nombre_parametro t_operacion_parametros.nombre%type := lower(sp.nombre);
          l_tipo_dato_param varchar2(20) := lower(k_util.f_significado_codigo('TIPO_DATO_PARAMETRO',sp.tipo_dato));
        begin
          l_variables := l_variables || chr(10)||'    l_'||lower(sp.nombre)||' VARCHAR2(1000);--TODO: Cambiar el type';
          l_ini_variables := l_ini_variables || chr(10)||'    l_'||l_nombre_parametro||' := k_operacion.f_valor_parametro_'||l_tipo_dato_param||'(i_parametros,
                                                             '''||l_nombre_parametro||''');';
          if sp.obligatorio = 'S' then
            l_val_variables := l_val_variables || chr(10)||'    k_operacion.p_validar_parametro(l_rsp,
                                    l_'||l_nombre_parametro||' IS NOT NULL,
                                    ''Debe ingresar '||l_nombre_parametro||''');';
          end if;
        end;
      end loop;

      DBMS_OUTPUT.PUT_LINE('--k_servicio_'||lower(se.dominio)||'.pck');
      DBMS_OUTPUT.PUT_LINE('  FUNCTION '||lower(se.nombre)||'(i_parametros IN y_parametros) RETURN y_respuesta;');
      DBMS_OUTPUT.PUT_LINE('');
      DBMS_OUTPUT.PUT_LINE('  FUNCTION '||lower(se.nombre)||'(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp            y_respuesta;
    l_dato           y_dato;
    l_id_usuario     t_usuarios.id_usuario%TYPE;
    --'||l_variables||'
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario     := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);' || l_ini_variables || '
  
    l_rsp.lugar := ''Validando parámetros'';' || l_val_variables || '
  
    l_rsp.lugar := ''TODO: Registrando la operacion'';
    --TODO
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
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
  END;');
    end;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('*********************************************************************************************');
    DBMS_OUTPUT.PUT_LINE('');

  end loop;
  
end;
