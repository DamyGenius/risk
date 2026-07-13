CREATE OR REPLACE PACKAGE k_imagenes_fan IS

  /**
  Agrupa operaciones relacionadas con imagenes de Fantasy.
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
  -- Url base de servicios de imagenes de Fantasy
  c_url_base CONSTANT VARCHAR2(300) := k_util.f_valor_parametro('URL_IMAGENES_SERVICIOS');

  -- Funcion para armar la URL publica de imagen de gol
  FUNCTION f_url_imagen_gol(i_id_club     IN VARCHAR2,
                            i_nombre_club IN VARCHAR2,
                            i_jugador     IN VARCHAR2,
                            i_marcador    IN VARCHAR2,
                            i_minuto      IN VARCHAR2,
                            i_variante    IN VARCHAR2 DEFAULT 'dark',
                            i_ancho       IN NUMBER DEFAULT 800)
    RETURN VARCHAR2;

  -- Funcion para armar la URL publica de imagen de resultado final
  FUNCTION f_url_imagen_resultado(i_id_club_local         IN VARCHAR2,
                                  i_nombre_club_local     IN VARCHAR2,
                                  i_id_club_visitante     IN VARCHAR2,
                                  i_nombre_club_visitante IN VARCHAR2,
                                  i_goles_local           IN NUMBER,
                                  i_goles_visitante       IN NUMBER,
                                  i_penales_local         IN NUMBER DEFAULT NULL,
                                  i_penales_visitante     IN NUMBER DEFAULT NULL,
                                  i_variante              IN VARCHAR2 DEFAULT 'dark',
                                  i_ancho                 IN NUMBER DEFAULT 800)
    RETURN VARCHAR2;

END k_imagenes_fan;
/
CREATE OR REPLACE PACKAGE BODY k_imagenes_fan IS

  FUNCTION lf_url_base RETURN VARCHAR2 IS
  BEGIN
    RETURN rtrim(c_url_base, '/');
  END lf_url_base;

  FUNCTION lf_param(i_nombre IN VARCHAR2,
                    i_valor  IN VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN i_nombre || '=' || utl_url.escape(nvl(i_valor, ''),
                                             TRUE,
                                             'UTF-8');
  END lf_param;

  FUNCTION lf_url_responde_ok(i_url IN VARCHAR2) RETURN BOOLEAN IS
    l_req  utl_http.req;
    l_resp utl_http.resp;
    l_raw  RAW(32767);
  BEGIN
    IF i_url IS NULL THEN
      RETURN FALSE;
    END IF;
  
    utl_http.set_response_error_check(ENABLE => FALSE);
    utl_http.set_transfer_timeout(10);
  
    l_req := utl_http.begin_request(url => i_url, method => 'GET');
    utl_http.set_header(l_req, 'User-Agent', 'RISK-DB');
    utl_http.set_header(l_req, 'Accept', 'image/png');
  
    l_resp := utl_http.get_response(r => l_req);
  
    IF l_resp.status_code <> 200 THEN
      utl_http.end_response(r => l_resp);
      RETURN FALSE;
    END IF;
  
    BEGIN
      LOOP
        utl_http.read_raw(l_resp, l_raw, 32767);
      END LOOP;
    EXCEPTION
      WHEN utl_http.end_of_body THEN
        NULL;
    END;
  
    utl_http.end_response(r => l_resp);
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        utl_http.end_response(r => l_resp);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      RETURN FALSE;
  END lf_url_responde_ok;

  FUNCTION f_url_imagen_gol(i_id_club     IN VARCHAR2,
                            i_nombre_club IN VARCHAR2,
                            i_jugador     IN VARCHAR2,
                            i_marcador    IN VARCHAR2,
                            i_minuto      IN VARCHAR2,
                            i_variante    IN VARCHAR2 DEFAULT 'dark',
                            i_ancho       IN NUMBER DEFAULT 800)
    RETURN VARCHAR2 IS
    l_url_base VARCHAR2(300);
  BEGIN
    l_url_base := lf_url_base;
  
    IF l_url_base IS NULL THEN
      RETURN NULL;
    END IF;
  
    DECLARE
      l_url VARCHAR2(4000);
    BEGIN
      l_url := l_url_base || '/rest/goal-image?' ||
               lf_param('teamId', i_id_club) || '&' ||
               lf_param('teamName', i_nombre_club) || '&' ||
               lf_param('player', i_jugador) || '&' ||
               lf_param('variant', nvl(i_variante, 'dark')) || '&' ||
               lf_param('score', i_marcador) || '&' ||
               lf_param('minute', i_minuto) || '&' ||
               lf_param('width', to_char(nvl(i_ancho, 800)));
    
      IF lf_url_responde_ok(l_url) THEN
        RETURN l_url;
      END IF;
    
      RETURN NULL;
    END;
  END f_url_imagen_gol;

  FUNCTION f_url_imagen_resultado(i_id_club_local         IN VARCHAR2,
                                  i_nombre_club_local     IN VARCHAR2,
                                  i_id_club_visitante     IN VARCHAR2,
                                  i_nombre_club_visitante IN VARCHAR2,
                                  i_goles_local           IN NUMBER,
                                  i_goles_visitante       IN NUMBER,
                                  i_penales_local         IN NUMBER DEFAULT NULL,
                                  i_penales_visitante     IN NUMBER DEFAULT NULL,
                                  i_variante              IN VARCHAR2 DEFAULT 'dark',
                                  i_ancho                 IN NUMBER DEFAULT 800)
    RETURN VARCHAR2 IS
    l_url_base VARCHAR2(300);
    l_url      VARCHAR2(4000);
  BEGIN
    l_url_base := lf_url_base;
  
    IF l_url_base IS NULL THEN
      RETURN NULL;
    END IF;
  
    l_url := l_url_base || '/rest/match-result-image?' ||
             lf_param('homeTeamId', i_id_club_local) || '&' ||
             lf_param('homeTeamName', i_nombre_club_local) || '&' ||
             lf_param('awayTeamId', i_id_club_visitante) || '&' ||
             lf_param('awayTeamName', i_nombre_club_visitante) || '&' ||
             lf_param('homeScore', to_char(nvl(i_goles_local, 0))) || '&' ||
             lf_param('awayScore', to_char(nvl(i_goles_visitante, 0)));
  
    IF i_penales_local IS NOT NULL AND i_penales_visitante IS NOT NULL THEN
      l_url := l_url || '&' ||
               lf_param('homePenaltyScore', to_char(i_penales_local)) || '&' ||
               lf_param('awayPenaltyScore', to_char(i_penales_visitante));
    END IF;
  
    l_url := l_url || '&' || lf_param('variant', nvl(i_variante, 'dark')) || '&' ||
             lf_param('width', to_char(nvl(i_ancho, 800)));
  
    IF lf_url_responde_ok(l_url) THEN
      RETURN l_url;
    END IF;
  
    RETURN NULL;
  END f_url_imagen_resultado;

BEGIN
  -- Initialization
  utl_http.set_wallet('');
END k_imagenes_fan;
/
