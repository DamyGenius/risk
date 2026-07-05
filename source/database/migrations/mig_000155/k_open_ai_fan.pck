CREATE OR REPLACE PACKAGE k_open_ai_fan IS

  /**
  Agrupa operaciones relacionadas con el consumo de la API de OpenAI.
  
  %author dmezac 05/07/2026 21:28:59
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

  -- Posibles respuestas en variable de salida o_ok
  c_success    CONSTANT VARCHAR2(1) := 'S'; -- exito
  c_auth_error CONSTANT VARCHAR2(1) := 'X'; -- no autorizado
  c_error      CONSTANT VARCHAR2(1) := 'N'; -- error

  -- Procedimiento generico para enviar un request a Responses API.
  PROCEDURE p_responses(i_request  IN CLOB,
                        o_ok       OUT VARCHAR2,
                        o_response OUT CLOB);

  -- Funcion que arma el contexto logico para el asistente de previa.
  FUNCTION f_contexto_previa_web(i_id_partido IN t_partidos.id_partido%TYPE)
    RETURN CLOB;

  -- Funcion que arma el request completo para OpenAI.
  FUNCTION f_request_previa_web(i_contexto IN CLOB) RETURN CLOB;

  -- Procedimiento para generar una previa web usando un contexto JSON.
  PROCEDURE p_asistente_previa_web(i_contexto IN CLOB,
                                   o_ok       OUT VARCHAR2,
                                   o_response OUT CLOB);

  -- Procedimiento para generar una previa web a partir de un partido.
  PROCEDURE p_asistente_previa_web(i_id_partido IN t_partidos.id_partido%TYPE,
                                   o_ok         OUT VARCHAR2,
                                   o_response   OUT CLOB);

END k_open_ai_fan;
/
CREATE OR REPLACE PACKAGE BODY k_open_ai_fan IS

  -- Configuracion OpenAI. Por ahora queda en constantes del cuerpo del paquete.
  c_openai_api_key            CONSTANT VARCHAR2(4000) := k_util.f_valor_parametro('CLAVE_API_OPENAI');
  c_openai_model              CONSTANT VARCHAR2(100) := 'gpt-5.5';
  c_openai_web_search_enabled CONSTANT BOOLEAN := TRUE;
  c_openai_timeout_ms         CONSTANT PLS_INTEGER := 60000;
  c_openai_cache_minutes      CONSTANT PLS_INTEGER := 30;

  c_openai_responses_url    CONSTANT VARCHAR2(300) := 'https://api.openai.com/v1/responses';
  c_openai_reasoning_effort CONSTANT VARCHAR2(20) := 'medium'; --'low';
  c_openai_search_context   CONSTANT VARCHAR2(20) := 'medium'; --'low';
  c_openai_web_include      CONSTANT VARCHAR2(100) := 'web_search_call.action.sources';
  c_openai_user_country     CONSTANT VARCHAR2(2) := 'PY';
  c_openai_user_city        CONSTANT VARCHAR2(100) := 'Asuncion';
  c_openai_user_region      CONSTANT VARCHAR2(100) := 'Central';
  c_http_chunk_size         CONSTANT PLS_INTEGER := 32000;

  c_previa_funcion  CONSTANT VARCHAR2(50) := 'ASISTENTE_PREVIA_WEB';
  c_previa_version  CONSTANT VARCHAR2(10) := '1.0';
  c_previa_idioma   CONSTANT VARCHAR2(10) := 'es-PY';
  c_previa_tono     CONSTANT VARCHAR2(100) := 'futbolero, entretenido, latinoamericano, neutral';
  c_previa_longitud CONSTANT VARCHAR2(20) := 'breve';

  c_previa_system_prompt CONSTANT VARCHAR2(4000) := 'Sos el motor de contenido de Reto Sports, una app recreativa de pronosticos deportivos. ' ||
                                                    'Generas previas breves de partidos de futbol usando informacion web actual cuando este disponible. ' ||
                                                    'No sos una app de apuestas. No uses lenguaje de betting, cuotas, stake, apuesta, cash, premio economico ni recomendaciones financieras. ' ||
                                                    'No afirmes datos inciertos como seguros. Si no encontras informacion confiable, devolve confianza baja o estado SIN_INFO_SUFICIENTE. ' ||
                                                    'No uses marcas oficiales protegidas salvo nombres necesarios de clubes, selecciones o torneos provistos por el backend. ' ||
                                                    'Responde exclusivamente en JSON valido segun el schema.';

  c_previa_user_prompt CONSTANT VARCHAR2(4000) := 'Genera una previa web para este partido. Usa informacion actual de la web sobre forma reciente, contexto deportivo, ' ||
                                                  'posibles bajas o noticias relevantes si estan disponibles. No inventes datos. Si una informacion no esta confirmada, ' ||
                                                  'marcala como baja confianza. Contexto JSON: ';

  c_previa_response_schema CONSTANT CLOB := q'~{
    "type": "object",
    "additionalProperties": false,
    "required": [
      "id_partido",
      "estado",
      "titulo",
      "subtitulo",
      "resumen",
      "claves",
      "jugadores_a_mirar",
      "contexto_web",
      "preguntas_para_pronosticar",
      "frase_destacada",
      "call_to_action",
      "fuentes",
      "confianza_global",
      "advertencias"
    ],
    "properties": {
      "id_partido": {
        "type": "integer"
      },
      "estado": {
        "type": "string",
        "enum": [
          "OK",
          "SIN_INFO_SUFICIENTE"
        ]
      },
      "titulo": {
        "type": "string"
      },
      "subtitulo": {
        "type": "string"
      },
      "resumen": {
        "type": "string"
      },
      "claves": {
        "type": "array",
        "maxItems": 3,
        "items": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "tipo",
            "titulo",
            "descripcion",
            "confianza"
          ],
          "properties": {
            "tipo": {
              "type": "string",
              "enum": [
                "FORMA_RECIENTE",
                "CONTEXTO",
                "TACTICO",
                "BAJAS",
                "ANIMICO",
                "OTRO"
              ]
            },
            "titulo": {
              "type": "string"
            },
            "descripcion": {
              "type": "string"
            },
            "confianza": {
              "type": "string",
              "enum": [
                "ALTA",
                "MEDIA",
                "BAJA"
              ]
            }
          }
        }
      },
      "jugadores_a_mirar": {
        "type": "array",
        "maxItems": 4,
        "items": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "equipo",
            "nombre",
            "motivo",
            "confianza"
          ],
          "properties": {
            "equipo": {
              "type": "string"
            },
            "nombre": {
              "type": "string"
            },
            "motivo": {
              "type": "string"
            },
            "confianza": {
              "type": "string",
              "enum": [
                "ALTA",
                "MEDIA",
                "BAJA"
              ]
            }
          }
        }
      },
      "contexto_web": {
        "type": "object",
        "additionalProperties": false,
        "required": [
          "forma_local",
          "forma_visitante",
          "noticias_relevantes"
        ],
        "properties": {
          "forma_local": {
            "type": [
              "string",
              "null"
            ]
          },
          "forma_visitante": {
            "type": [
              "string",
              "null"
            ]
          },
          "noticias_relevantes": {
            "type": "array",
            "maxItems": 4,
            "items": {
              "type": "object",
              "additionalProperties": false,
              "required": [
                "titulo",
                "descripcion",
                "equipo_relacionado",
                "confianza"
              ],
              "properties": {
                "titulo": {
                  "type": "string"
                },
                "descripcion": {
                  "type": "string"
                },
                "equipo_relacionado": {
                  "type": [
                    "string",
                    "null"
                  ]
                },
                "confianza": {
                  "type": "string",
                  "enum": [
                    "ALTA",
                    "MEDIA",
                    "BAJA"
                  ]
                }
              }
            }
          }
        }
      },
      "preguntas_para_pronosticar": {
        "type": "array",
        "maxItems": 3,
        "items": {
          "type": "string"
        }
      },
      "frase_destacada": {
        "type": "string"
      },
      "call_to_action": {
        "type": "string"
      },
      "fuentes": {
        "type": "array",
        "maxItems": 6,
        "items": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "titulo",
            "url",
            "medio",
            "fecha_publicacion"
          ],
          "properties": {
            "titulo": {
              "type": "string"
            },
            "url": {
              "type": "string"
            },
            "medio": {
              "type": [
                "string",
                "null"
              ]
            },
            "fecha_publicacion": {
              "type": [
                "string",
                "null"
              ]
            }
          }
        }
      },
      "confianza_global": {
        "type": "string",
        "enum": [
          "ALTA",
          "MEDIA",
          "BAJA"
        ]
      },
      "advertencias": {
        "type": "array",
        "maxItems": 5,
        "items": {
          "type": "string"
        }
      }
    }
  }~';

  -- Funcion interna para comunicacion HTTP.
  FUNCTION lf_read_http_body(resp IN OUT utl_http.resp) RETURN CLOB AS
    l_http_body CLOB;
    l_data      VARCHAR2(2048);
  BEGIN
    BEGIN
      LOOP
        utl_http.read_text(resp, l_data, 1024);
        l_http_body := l_http_body || l_data;
      END LOOP;
    EXCEPTION
      WHEN utl_http.end_of_body THEN
        NULL;
    END;
    RETURN l_http_body;
  END lf_read_http_body;

  PROCEDURE lp_write_clob(i_req  IN OUT utl_http.req,
                          i_data IN CLOB) IS
    l_length NUMBER;
    l_offset PLS_INTEGER := 1;
    l_amount PLS_INTEGER;
    l_buffer VARCHAR2(32767);
  BEGIN
    IF i_data IS NULL THEN
      RETURN;
    END IF;
  
    l_length := dbms_lob.getlength(i_data);
  
    WHILE l_offset <= l_length LOOP
      l_amount := least(c_http_chunk_size, l_length - l_offset + 1);
      dbms_lob.read(i_data, l_amount, l_offset, l_buffer);
      utl_http.write_text(i_req, l_buffer);
      l_offset := l_offset + l_amount;
    END LOOP;
  END lp_write_clob;

  PROCEDURE lp_post_json(i_url         IN VARCHAR2,
                         i_request     IN CLOB,
                         o_status_code OUT PLS_INTEGER,
                         o_response    OUT CLOB) IS
    l_req  utl_http.req;
    l_resp utl_http.resp;
  BEGIN
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_body_charset('UTF-8');
    utl_http.set_transfer_timeout(ceil(c_openai_timeout_ms / 1000));
  
    l_req := utl_http.begin_request(url => i_url, method => 'POST');
  
    utl_http.set_header(l_req, 'Content-Type', 'application/json');
    utl_http.set_header(l_req, 'Accept', 'application/json');
    utl_http.set_header(l_req,
                        'Authorization',
                        'Bearer ' || c_openai_api_key);
    utl_http.set_header(l_req, 'Transfer-Encoding', 'chunked');
  
    lp_write_clob(i_req => l_req, i_data => i_request);
  
    l_resp        := utl_http.get_response(r => l_req);
    o_status_code := l_resp.status_code;
    o_response    := lf_read_http_body(l_resp);
    utl_http.end_response(r => l_resp);
  EXCEPTION
    WHEN OTHERS THEN
      o_status_code := 0;
      o_response    := dbms_utility.format_error_stack;
  END lp_post_json;

  FUNCTION lf_output_text(i_response IN CLOB) RETURN CLOB IS
    l_response     json_object_t;
    l_output       json_array_t;
    l_output_item  json_object_t;
    l_content      json_array_t;
    l_content_item json_object_t;
    l_text         CLOB;
  BEGIN
    l_response := json_object_t.parse(i_response);
    l_output   := l_response.get_array('output');
  
    IF l_output IS NULL THEN
      RETURN NULL;
    END IF;
  
    FOR i IN 0 .. l_output.get_size - 1 LOOP
      l_output_item := treat(l_output.get(i) AS json_object_t);
    
      IF l_output_item.get_string('type') = 'message' THEN
        l_content := l_output_item.get_array('content');
      
        IF l_content IS NOT NULL THEN
          FOR j IN 0 .. l_content.get_size - 1 LOOP
            l_content_item := treat(l_content.get(j) AS json_object_t);
          
            IF l_content_item.get_string('type') = 'output_text' THEN
              l_text := l_content_item.get_string('text');
              RETURN l_text;
            END IF;
          END LOOP;
        END IF;
      END IF;
    END LOOP;
  
    RETURN NULL;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END lf_output_text;

  PROCEDURE p_responses(i_request  IN CLOB,
                        o_ok       OUT VARCHAR2,
                        o_response OUT CLOB) IS
    l_status_code PLS_INTEGER;
  BEGIN
    IF c_openai_api_key IS NULL OR c_openai_api_key = '${OPENAI_API_KEY}' THEN
      o_ok       := c_auth_error;
      o_response := 'OPENAI_API_KEY no configurada en k_open_ai_fan.';
      RETURN;
    END IF;
  
    lp_post_json(i_url         => c_openai_responses_url,
                 i_request     => i_request,
                 o_status_code => l_status_code,
                 o_response    => o_response);
  
    IF l_status_code >= 200 AND l_status_code < 300 THEN
      o_ok := c_success;
    ELSIF l_status_code = 401 THEN
      o_ok := c_auth_error;
    ELSE
      o_ok       := c_error;
      o_response := 'HTTP ' || l_status_code || ': ' || o_response;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
  END p_responses;

  FUNCTION f_contexto_previa_web(i_id_partido IN t_partidos.id_partido%TYPE)
    RETURN CLOB IS
    l_id_partido     t_partidos.id_partido%TYPE;
    l_torneo         t_torneos.denominacion_oficial%TYPE;
    l_fase           t_torneo_fases.descripcion%TYPE;
    l_club_local     t_clubes.nombre_corto%TYPE;
    l_club_visitante t_clubes.nombre_corto%TYPE;
    l_fecha_hora     VARCHAR2(40);
    l_sede           t_estadios.nombre_oficial%TYPE;
    l_contexto       json_object_t;
    l_partido        json_object_t;
    l_restricciones  json_object_t;
  BEGIN
    SELECT p.id_partido,
           nvl(nvl(t.denominacion_oficial, t.titulo), p.id_torneo),
           nvl(f.descripcion, p.descripcion),
           nvl(l.nombre_corto, p.nombre_club_local),
           nvl(v.nombre_corto, p.nombre_club_visitante),
           CASE
             WHEN p.fecha IS NOT NULL THEN
              to_char(p.fecha, 'YYYY-MM-DD"T"HH24:MI:SSTZH:TZM')
           END,
           e.nombre_oficial
      INTO l_id_partido,
           l_torneo,
           l_fase,
           l_club_local,
           l_club_visitante,
           l_fecha_hora,
           l_sede
      FROM t_partidos     p,
           t_torneos      t,
           t_torneo_fases f,
           t_clubes       l,
           t_clubes       v,
           t_estadios     e
     WHERE p.id_torneo = t.id_torneo(+)
       AND p.id_torneo = f.id_torneo(+)
       AND p.id_fase = f.id_fase(+)
       AND p.id_club_local = l.id_club(+)
       AND p.id_club_visitante = v.id_club(+)
       AND p.id_estadio = e.id_estadio(+)
       AND p.id_partido = i_id_partido;
  
    l_partido := NEW json_object_t();
    l_partido.put('id_partido', l_id_partido);
    l_partido.put('torneo', l_torneo);
    l_partido.put('fase', l_fase);
    l_partido.put('club_local', l_club_local);
    l_partido.put('club_visitante', l_club_visitante);
    l_partido.put('fecha_hora_partido', l_fecha_hora);
    l_partido.put('sede', l_sede);
  
    l_restricciones := NEW json_object_t();
    l_restricciones.put('no_usar_lenguaje_apuestas', TRUE);
    l_restricciones.put('no_mencionar_cuotas', TRUE);
    l_restricciones.put('no_prometer_resultados', TRUE);
    l_restricciones.put('tono', c_previa_tono);
    l_restricciones.put('longitud', c_previa_longitud);
  
    l_contexto := NEW json_object_t();
    l_contexto.put('funcion', c_previa_funcion);
    l_contexto.put('version', c_previa_version);
    l_contexto.put('idioma', c_previa_idioma);
    l_contexto.put('fecha_actual', to_char(current_date, 'YYYY-MM-DD'));
    l_contexto.put('partido', l_partido);
    l_contexto.put('restricciones', l_restricciones);
  
    RETURN l_contexto.to_clob;
  END f_contexto_previa_web;

  FUNCTION f_request_previa_web(i_contexto IN CLOB) RETURN CLOB IS
    l_request   json_object_t;
    l_reasoning json_object_t;
    l_tool      json_object_t;
    l_location  json_object_t;
    l_tools     json_array_t;
    l_include   json_array_t;
    l_input     json_array_t;
    l_message   json_object_t;
    l_text      json_object_t;
    l_format    json_object_t;
    l_contexto  VARCHAR2(32767);
  BEGIN
    l_contexto := dbms_lob.substr(i_contexto, 30000, 1);
  
    l_request := NEW json_object_t();
    l_request.put('model', c_openai_model);
  
    l_reasoning := NEW json_object_t();
    l_reasoning.put('effort', c_openai_reasoning_effort);
    l_request.put('reasoning', l_reasoning);
  
    IF c_openai_web_search_enabled THEN
      l_location := NEW json_object_t();
      l_location.put('type', 'approximate');
      l_location.put('country', c_openai_user_country);
      l_location.put('city', c_openai_user_city);
      l_location.put('region', c_openai_user_region);
    
      l_tool := NEW json_object_t();
      l_tool.put('type', 'web_search');
      l_tool.put('search_context_size', c_openai_search_context);
      l_tool.put('external_web_access', TRUE);
      l_tool.put('user_location', l_location);
    
      l_tools := NEW json_array_t();
      l_tools.append(l_tool);
      l_request.put('tools', l_tools);
      l_request.put('tool_choice', 'required');
    
      l_include := NEW json_array_t();
      l_include.append(c_openai_web_include);
      l_request.put('include', l_include);
    END IF;
  
    l_input := NEW json_array_t();
  
    l_message := NEW json_object_t();
    l_message.put('role', 'system');
    l_message.put('content', c_previa_system_prompt);
    l_input.append(l_message);
  
    l_message := NEW json_object_t();
    l_message.put('role', 'user');
    l_message.put('content', c_previa_user_prompt || l_contexto);
    l_input.append(l_message);
  
    l_request.put('input', l_input);
  
    l_format := NEW json_object_t();
    l_format.put('type', 'json_schema');
    l_format.put('name', 'asistente_previa_web_response');
    l_format.put('strict', TRUE);
    l_format.put('schema', json_object_t.parse(c_previa_response_schema));
  
    l_text := NEW json_object_t();
    l_text.put('format', l_format);
    l_request.put('text', l_text);
  
    RETURN l_request.to_clob;
  END f_request_previa_web;

  PROCEDURE p_asistente_previa_web(i_contexto IN CLOB,
                                   o_ok       OUT VARCHAR2,
                                   o_response OUT CLOB) IS
    l_request      CLOB;
    l_raw_response CLOB;
    l_output_text  CLOB;
  BEGIN
    l_request := f_request_previa_web(i_contexto);
  
    p_responses(i_request  => l_request,
                o_ok       => o_ok,
                o_response => l_raw_response);
  
    IF o_ok = c_success THEN
      l_output_text := lf_output_text(l_raw_response);
    
      IF l_output_text IS NOT NULL THEN
        o_response := l_output_text;
      ELSE
        o_ok       := c_error;
        o_response := 'No se encontro output_text en la respuesta de OpenAI: ' ||
                      l_raw_response;
      END IF;
    ELSE
      o_response := l_raw_response;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
  END p_asistente_previa_web;

  PROCEDURE p_asistente_previa_web(i_id_partido IN t_partidos.id_partido%TYPE,
                                   o_ok         OUT VARCHAR2,
                                   o_response   OUT CLOB) IS
    l_contexto CLOB;
  BEGIN
    l_contexto := f_contexto_previa_web(i_id_partido);
  
    p_asistente_previa_web(i_contexto => l_contexto,
                           o_ok       => o_ok,
                           o_response => o_response);
  EXCEPTION
    WHEN OTHERS THEN
      o_ok       := c_error;
      o_response := dbms_utility.format_error_stack;
  END p_asistente_previa_web;

BEGIN
  -- Initialization
  utl_http.set_wallet('');
END k_open_ai_fan;
/
