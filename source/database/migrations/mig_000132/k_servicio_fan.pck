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

  FUNCTION listar_partidos(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION listar_predicciones_partidos(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION listar_jornadas(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION listar_fases(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION realizar_prediccion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION registrar_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION editar_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION datos_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION listar_grupos(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION abandonar_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION invitar_usuario(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION responder_invitacion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION solicitar_ingreso_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION responder_ingreso_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION solicitar_amistad(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION responder_solicitud_amistad(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION listar_amigos(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION realizar_comentario(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION reaccionar(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION enviar_mensaje_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION enviar_mensaje_amigo(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION suscribir(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION seguir_division(i_parametros IN y_parametros) RETURN y_respuesta;

END;
/
CREATE OR REPLACE PACKAGE BODY k_servicio_fan IS

  FUNCTION lf_partidos(i_id_torneo  IN VARCHAR2,
                       i_id_fase    IN NUMBER,
                       i_id_grupo   IN NUMBER,
                       i_id_jornada IN NUMBER,
                       i_id_partido IN VARCHAR2,
                       i_usuario    IN VARCHAR2) RETURN y_partidos IS
    l_partidos y_partidos;
    l_partido  y_partido_prediccion;
  
    CURSOR cr_partidos(i_id_torneo  IN VARCHAR2,
                       i_id_fase    IN NUMBER,
                       i_id_grupo   IN NUMBER,
                       i_id_jornada IN NUMBER,
                       i_id_partido IN VARCHAR2,
                       i_usuario    IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(l.nombre_corto)
                 END,
                 c.nombre_club_local) nombre_club_local,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(v.nombre_corto)
                 END,
                 c.nombre_club_visitante) nombre_club_visitante,
             CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha,
             to_char(CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE),
                     'HH24:MI') hora,
             c.id_fase,
             c.id_grupo,
             c.id_jornada,
             c.descripcion etiqueta,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado,
             c.estado_juego,
             p.goles_club_local predic_goles_local,
             p.goles_club_visitante predic_goles_visitante,
             p.puntos,
             p.id_sincronizacion
        FROM t_partidos c, t_predicciones p, t_clubes l, t_clubes v
       WHERE c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND nvl(c.id_fase, -1) = nvl(nvl(i_id_fase, c.id_fase), -1)
         AND nvl(c.id_grupo, -1) = nvl(i_id_grupo, -1)
         AND nvl(c.id_jornada, -1) =
             nvl(nvl(i_id_jornada, c.id_jornada), -1)
         AND c.id_partido = p.id_partido(+)
         AND p.id_usuario(+) = i_usuario
         AND c.id_club_local = l.id_club(+)
         AND c.id_club_visitante = v.id_club(+)
       ORDER BY c.id_torneo,
                c.id_fase,
                c.id_grupo,
                c.id_jornada,
                c.descripcion,
                c.fecha,
                c.id_partido;
  
  BEGIN
    l_partidos := NEW y_partidos();
  
    FOR p IN cr_partidos(i_id_torneo,
                         i_id_fase,
                         i_id_grupo,
                         i_id_jornada,
                         i_id_partido,
                         i_usuario) LOOP
      l_partido                       := NEW y_partido_prediccion();
      l_partido.id_partido            := p.id_partido;
      l_partido.id_torneo             := p.id_torneo;
      l_partido.id_club_local         := p.id_club_local;
      l_partido.id_club_visitante     := p.id_club_visitante;
      l_partido.nombre_club_local     := p.nombre_club_local;
      l_partido.nombre_club_visitante := p.nombre_club_visitante;
      l_partido.fecha                 := p.fecha;
      l_partido.hora                  := p.hora;
      l_partido.id_fase               := p.id_fase;
      l_partido.id_grupo              := p.id_grupo;
      l_partido.id_jornada            := p.id_jornada;
      l_partido.etiqueta              := p.etiqueta;
      l_partido.id_estadio            := p.id_estadio;
      l_partido.goles_local           := p.goles_club_local;
      l_partido.goles_visitante       := p.goles_club_visitante;
      l_partido.estado                := p.estado;
      l_partido.estado_juego          := p.estado_juego;
    
      l_partido.predic_goles_local     := p.predic_goles_local;
      l_partido.predic_goles_visitante := p.predic_goles_visitante;
      l_partido.puntos                 := p.puntos;
      l_partido.sincronizacion         := p.id_sincronizacion;
    
      l_partidos.extend;
      l_partidos(l_partidos.count) := l_partido;
    END LOOP;
  
    RETURN l_partidos;
  END;

  FUNCTION lf_datos_grupo(i_id_grupo         IN NUMBER,
                          i_incluir_usuarios IN VARCHAR2 DEFAULT NULL)
    RETURN y_grupo IS
    l_grupo    y_grupo;
    l_usuarios y_objetos;
    l_usuario  y_grupo_usuario;
  
    CURSOR cr_incluir_usuarios(i_incluir_usuarios IN VARCHAR2 DEFAULT NULL) IS
      SELECT 'N' incluir
        FROM dual
      UNION ALL
      SELECT 'S' incluir
        FROM dual
       WHERE nvl(i_incluir_usuarios, 'S') = 'S';
  
    CURSOR cr_usuarios(i_id_grupo         IN NUMBER,
                       i_id_torneo        IN VARCHAR2,
                       i_incluir_usuarios IN VARCHAR2 DEFAULT NULL) IS
      SELECT a.id_grupo,
             a.id_usuario,
             at.puntos,
             at.ranking,
             a.estado,
             a.token_activacion,
             a.aceptado
        FROM t_grupo_usuarios a, t_grupo_torneo_usuarios at
       WHERE a.id_grupo = i_id_grupo
         AND nvl(a.estado, 'I') <> 'I'
         AND (nvl(i_incluir_usuarios, 'S') = 'S' OR
             (nvl(i_incluir_usuarios, 'S') = 'N' AND
             a.id_usuario =
             k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario)))
         AND at.id_grupo(+) = a.id_grupo
         AND at.id_usuario(+) = a.id_usuario
         AND at.id_torneo(+) = i_id_torneo
       ORDER BY CASE a.aceptado
                  WHEN 'S' THEN
                   1
                  ELSE
                   2
                END,
                at.ranking ASC NULLS LAST,
                at.puntos DESC NULLS LAST,
                a.id_usuario;
  BEGIN
    -- Inicializa respuesta
    l_grupo    := NEW y_grupo();
    l_usuarios := NEW y_objetos();
  
    -- Busca datos del grupo con un torneo actual
    BEGIN
      SELECT z.*
        INTO l_grupo.id_grupo,
             l_grupo.id_torneo,
             l_grupo.titulo_torneo,
             l_grupo.descripcion,
             l_grupo.tipo,
             l_grupo.descripcion_tipo,
             l_grupo.id_usuario_administrador,
             l_grupo.alias_usuario_administrador,
             l_grupo.fecha_creacion,
             l_grupo.id_jornada_inicio,
             l_grupo.estado,
             l_grupo.situacion,
             l_grupo.id_club,
             l_grupo.nombre_oficial_club,
             l_grupo.todos_invitan,
             l_grupo.version_logo
        FROM (SELECT a.id_grupo,
                     t.id_torneo,
                     t.titulo,
                     a.descripcion,
                     a.tipo,
                     k_util.f_significado_codigo('TIPO_GRUPO', a.tipo),
                     a.id_usuario_administrador,
                     k_usuario.f_alias(a.id_usuario_administrador),
                     CAST(a.fecha_creacion at TIME ZONE
                          k_sistema.f_zona_horaria AS DATE) fecha,
                     b.id_jornada_inicio,
                     a.estado,
                     a.situacion,
                     a.id_club,
                     c.nombre_oficial,
                     a.todos_invitan,
                     k_archivo.f_version_archivo('T_GRUPOS',
                                                 'LOGO',
                                                 a.id_grupo) version_logo
                FROM t_grupos a, t_grupo_torneos b, t_torneos t, t_clubes c
               WHERE a.id_grupo = b.id_grupo(+)
                 AND t.id_torneo(+) = b.id_torneo
                 AND c.id_club(+) = a.id_club
                 AND a.id_grupo = i_id_grupo
                 AND t.actual(+) = 'S'
               ORDER BY 2 NULLS LAST) z
       WHERE rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20000, 'Grupo inexistente');
      WHEN OTHERS THEN
        raise_application_error(-20000, 'Error al buscar datos del grupo');
    END;
  
    -- Busca usuarios del grupo
    FOR ci IN cr_incluir_usuarios(i_incluir_usuarios) LOOP
      FOR c IN cr_usuarios(l_grupo.id_grupo, l_grupo.id_torneo, ci.incluir) LOOP
        l_usuario                  := NEW y_grupo_usuario();
        l_usuario.id_usuario       := c.id_usuario;
        l_usuario.alias_usuario    := k_usuario.f_alias(c.id_usuario);
        l_usuario.version_avatar   := k_usuario.f_version_avatar(l_usuario.alias_usuario);
        l_usuario.verificado       := k_usuario.f_verificado(l_usuario.alias_usuario);
        l_usuario.id_club          := k_usuario.f_club_favorito(l_usuario.alias_usuario);
        l_usuario.puntos           := c.puntos;
        l_usuario.ranking          := c.ranking;
        l_usuario.estado           := c.estado;
        l_usuario.token_activacion := c.token_activacion;
        l_usuario.aceptado         := c.aceptado;
      
        l_usuarios.extend;
        l_usuarios(l_usuarios.count) := l_usuario;
      END LOOP;
    END LOOP;
    l_grupo.usuarios := l_usuarios;
  
    RETURN l_grupo;
  END;

  PROCEDURE lp_realizar_invitacion(i_id_usuario       IN NUMBER,
                                   i_direccion_correo IN VARCHAR2,
                                   i_id_grupo         IN NUMBER DEFAULT NULL) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_body CLOB;
  BEGIN
    --TODO: actualizar en caso de que ya exista una invitación
    --de id_usuario_solicitante para direccion_correo
    --si está X-expirado, C-ancelado
    --insert solo si sql notfoud 
    INSERT INTO t_invitaciones a
      (id_usuario_solicitante,
       direccion_correo,
       tipo,
       id_grupo,
       fecha_creacion,
       fecha_expiracion,
       fecha_aceptacion)
    VALUES
      (i_id_usuario,
       i_direccion_correo,
       CASE WHEN i_id_grupo IS NULL THEN 'A' ELSE 'G' END,
       i_id_grupo,
       current_timestamp,
       current_timestamp + 30,
       NULL);
  
    -- Envía correo de invitación
    l_body := k_mensajeria.f_correo_html(k_usuario.f_alias(i_id_usuario) ||
                                         ' te envió una invitación a unirte a Reto Sports.' ||
                                         utl_tcp.crlf ||
                                         'Descarga la aplicación desde Google Play con el botón o con la siguiente URL:' ||
                                         utl_tcp.crlf ||
                                         'https://play.google.com/store/apps/details?id=py.com.rama.ffp', --TODO: dinamizar
                                         'Tenés una invitación a Reto Sports',
                                         'Tenés una invitación a Reto Sports',
                                         NULL,
                                         'Descargar',
                                         'https://play.google.com/store/apps/details?id=py.com.rama.ffp'); --TODO: dinamizar
  
    IF k_mensajeria.f_enviar_correo('Tenés una invitación a Reto Sports',
                                    l_body,
                                    NULL,
                                    i_direccion_correo,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    k_mensajeria.c_prioridad_media) <>
       k_mensajeria.c_ok THEN
      NULL;
    END IF;
    COMMIT;
  END;

  FUNCTION listar_clubes(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_club;
  
    l_id_club      t_clubes.id_club%TYPE;
    l_tipo         t_clubes.tipo%TYPE;
    l_id_pais      t_clubes.id_pais%TYPE;
    l_id_pais2     t_clubes.id_pais%TYPE;
    l_id_pais_iso2 t_paises.iso_alpha_2%TYPE;
    l_id_division  t_clubes.id_division%TYPE;
  
    CURSOR cr_clubes(i_id_club     IN VARCHAR2,
                     i_tipo        IN VARCHAR2,
                     i_id_pais     IN NUMBER,
                     i_id_division IN VARCHAR2) IS
      SELECT c.id_club,
             c.nombre_oficial,
             c.otros_nombres,
             c.fundacion,
             c.pagina_web,
             c.twitter,
             c.facebook,
             c.tipo,
             c.id_pais,
             i_id_division id_division,
             c.nombre_corto
        FROM t_clubes c
       WHERE c.id_club = nvl(i_id_club, c.id_club)
         AND c.tipo = nvl(i_tipo, c.tipo)
         AND nvl(c.id_pais, -1) = nvl(nvl(i_id_pais, c.id_pais), -1)
         AND (i_id_division IS NULL OR EXISTS
              (SELECT 1
                 FROM t_planteles x, t_torneos y
                WHERE x.id_club = c.id_club
                  AND x.id_torneo = y.id_torneo
                  AND y.actual = 'S'
                  AND y.id_division = i_id_division));
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_club      := k_operacion.f_valor_parametro_string(i_parametros,
                                                           'id_club');
    l_tipo         := k_operacion.f_valor_parametro_string(i_parametros,
                                                           'tipo');
    l_id_pais      := k_operacion.f_valor_parametro_number(i_parametros,
                                                           'id_pais');
    l_id_pais_iso2 := k_operacion.f_valor_parametro_string(i_parametros,
                                                           'id_pais_iso2');
    l_id_division  := k_operacion.f_valor_parametro_string(i_parametros,
                                                           'id_division');
  
    -- Obtiene id. del pais a partir del ISO alpha 2
    IF l_id_pais_iso2 IS NOT NULL THEN
      DECLARE
        l_id_pais t_paises.id_pais%TYPE;
      BEGIN
        SELECT p.id_pais
          INTO l_id_pais2
          FROM t_paises p
         WHERE p.iso_alpha_2 = l_id_pais_iso2;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;
  
    FOR ele IN cr_clubes(l_id_club,
                         l_tipo,
                         nvl(l_id_pais, l_id_pais2),
                         l_id_division) LOOP
      l_objeto                := NEW y_club();
      l_objeto.id_club        := ele.id_club;
      l_objeto.nombre_oficial := k_util.f_formatear_titulo(ele.nombre_oficial);
      l_objeto.nombre_corto   := k_util.f_formatear_titulo(ele.nombre_corto);
      l_objeto.otros_nombres  := k_util.f_formatear_titulo(ele.otros_nombres);
      l_objeto.fundacion      := ele.fundacion;
      l_objeto.pagina_web     := ele.pagina_web;
      l_objeto.twitter        := ele.twitter;
      l_objeto.facebook       := ele.facebook;
      l_objeto.tipo           := ele.tipo;
      l_objeto.id_pais        := ele.id_pais;
      l_objeto.id_division    := ele.id_division;
      l_objeto.version_escudo := k_archivo.f_version_archivo('T_CLUBES',
                                                             'ESCUDO',
                                                             ele.id_club);
    
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
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION listar_partidos(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_partido;
  
    l_id_partido t_partidos.id_partido%TYPE;
    l_id_torneo  t_partidos.id_torneo%TYPE;
    l_estado     t_partidos.estado%TYPE;
    l_id_usuario t_usuarios.id_usuario%TYPE;
  
    CURSOR cr_elementos(i_id_partido IN VARCHAR2,
                        i_id_torneo  IN VARCHAR2,
                        i_estado     IN VARCHAR2,
                        i_usuario    IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(l.nombre_corto)
                 END,
                 c.nombre_club_local) nombre_club_local,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(v.nombre_corto)
                 END,
                 c.nombre_club_visitante) nombre_club_visitante,
             CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha,
             to_char(CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE),
                     'HH24:MI') hora,
             c.id_fase,
             c.id_grupo,
             c.id_jornada,
             CASE
               WHEN t.tipo = 'C' THEN
                (SELECT fa.descripcion
                   FROM t_torneo_fases fa
                  WHERE fa.id_torneo = c.id_torneo
                    AND fa.id_fase = c.id_fase)
               ELSE
                c.descripcion
             END etiqueta,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado,
             c.estado_juego,
             (SELECT nvl(COUNT(m.id_comentario), 0)
                FROM t_comentarios m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido) cantidad_comentarios,
             (SELECT nvl(COUNT(p.id_usuario), 0)
                FROM t_predicciones p
               WHERE p.id_partido = c.id_partido) cantidad_predicciones,
             (SELECT nvl(COUNT(m.id_reaccion), 0)
                FROM t_reacciones m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido) cantidad_reacciones,
             (SELECT m.reaccion
                FROM t_reacciones m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido
                 AND m.ref_comentario IS NULL
                 AND m.id_usuario = i_usuario) mi_reaccion
        FROM t_partidos c, t_torneos t, t_clubes l, t_clubes v
       WHERE c.id_torneo = t.id_torneo
         AND c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND c.estado = nvl(i_estado, c.estado)
         AND c.id_club_local = l.id_club(+)
         AND c.id_club_visitante = v.id_club(+)
       ORDER BY c.fecha, c.id_partido;
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_usuario := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_id_partido := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'partido');
    l_id_torneo  := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                             'torneo'),
                        k_sistema.f_valor_parametro_string(k_sistema.c_torneo));
    l_estado     := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'estado');
  
    FOR ele IN cr_elementos(l_id_partido,
                            l_id_torneo,
                            l_estado,
                            l_id_usuario) LOOP
      l_objeto                       := NEW y_partido();
      l_objeto.id_partido            := ele.id_partido;
      l_objeto.id_torneo             := ele.id_torneo;
      l_objeto.id_club_local         := ele.id_club_local;
      l_objeto.id_club_visitante     := ele.id_club_visitante;
      l_objeto.nombre_club_local     := ele.nombre_club_local;
      l_objeto.nombre_club_visitante := ele.nombre_club_visitante;
      l_objeto.fecha                 := ele.fecha;
      l_objeto.hora                  := ele.hora;
      l_objeto.id_fase               := ele.id_fase;
      l_objeto.id_grupo              := ele.id_grupo;
      l_objeto.id_jornada            := ele.id_jornada;
      l_objeto.etiqueta              := ele.etiqueta;
      l_objeto.id_estadio            := ele.id_estadio;
      l_objeto.goles_local           := ele.goles_club_local;
      l_objeto.goles_visitante       := ele.goles_club_visitante;
      l_objeto.estado                := ele.estado;
      l_objeto.estado_juego          := ele.estado_juego;
      l_objeto.cantidad_comentarios  := ele.cantidad_comentarios;
      l_objeto.cantidad_predicciones := ele.cantidad_predicciones;
      l_objeto.cantidad_reacciones   := ele.cantidad_reacciones;
      l_objeto.mi_reaccion           := ele.mi_reaccion;
    
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
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION listar_predicciones_partidos(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_partido_prediccion;
  
    l_id_partido           t_partidos.id_partido%TYPE;
    l_id_torneo            t_partidos.id_torneo%TYPE;
    l_estados_partidos     VARCHAR2(12);
    l_estados_predicciones VARCHAR2(12);
    l_usuario              t_usuarios.alias%TYPE;
    l_pagina_parametros    y_pagina_parametros;
    l_orden                VARCHAR2(4);
  
    CURSOR cr_elementos(i_id_partido           IN VARCHAR2,
                        i_id_torneo            IN VARCHAR2,
                        i_estados_partidos     IN VARCHAR2,
                        i_estados_predicciones IN VARCHAR2,
                        i_usuario              IN VARCHAR2,
                        i_orden                IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(l.nombre_corto)
                 END,
                 c.nombre_club_local) nombre_club_local,
             nvl(CASE
                   WHEN k_sistema.f_id_aplicacion =
                        k_sistema.c_id_aplicacion_ios THEN
                    k_util.f_formatear_titulo(v.nombre_corto)
                 END,
                 c.nombre_club_visitante) nombre_club_visitante,
             CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE) fecha,
             to_char(CAST(c.fecha at TIME ZONE k_sistema.f_zona_horaria AS DATE),
                     'HH24:MI') hora,
             c.id_fase,
             c.id_grupo,
             c.id_jornada,
             CASE
               WHEN t.tipo = 'C' THEN
                (SELECT fa.descripcion
                   FROM t_torneo_fases fa
                  WHERE fa.id_torneo = c.id_torneo
                    AND fa.id_fase = c.id_fase)
               ELSE
                c.descripcion
             END etiqueta,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado,
             c.estado_juego,
             (SELECT nvl(COUNT(m.id_comentario), 0)
                FROM t_comentarios m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido) cantidad_comentarios,
             (SELECT nvl(COUNT(p.id_usuario), 0)
                FROM t_predicciones p
               WHERE p.id_partido = c.id_partido) cantidad_predicciones,
             (SELECT nvl(COUNT(m.id_reaccion), 0)
                FROM t_reacciones m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido) cantidad_reacciones,
             (SELECT m.reaccion
                FROM t_reacciones m
               WHERE m.tipo = 'T'
                 AND m.referencia = c.id_partido
                 AND m.ref_comentario IS NULL
                 AND m.id_usuario = i_usuario) mi_reaccion,
             p.goles_club_local predic_goles_local,
             p.goles_club_visitante predic_goles_visitante,
             p.puntos,
             p.id_sincronizacion
        FROM t_partidos     c,
             t_predicciones p,
             t_clubes       l,
             t_clubes       v,
             t_torneos      t
       WHERE c.id_torneo = t.id_torneo
         AND c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND p.id_usuario(+) NOT IN
             (to_number(k_util.f_valor_parametro('ID_USUARIO_OFICIAL')))
         AND (c.estado IN
             (SELECT *
                 FROM (k_util.f_separar_cadenas(i_estados_partidos, ','))) OR
             i_estados_partidos IS NULL)
         AND c.id_partido = p.id_partido(+)
         AND (p.estado IN
             (SELECT *
                 FROM (k_util.f_separar_cadenas(i_estados_predicciones, ','))) OR
             i_estados_predicciones IS NULL)
         AND p.id_usuario(+) = i_usuario
         AND c.id_club_local = l.id_club(+)
         AND c.id_club_visitante = v.id_club(+)
       ORDER BY CASE
                  WHEN i_orden = 'ASC' OR i_orden IS NULL THEN
                   c.fecha
                END,
                CASE
                  WHEN i_orden = 'DESC' THEN
                   c.fecha
                END DESC,
                c.id_partido;
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_partido           := k_operacion.f_valor_parametro_number(i_parametros,
                                                                   'partido');
    l_id_torneo            := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                                       'torneo'),
                                  k_sistema.f_valor_parametro_string(k_sistema.c_torneo));
    l_estados_partidos     := k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'estados_partidos');
    l_estados_predicciones := k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'estados_predicciones');
    l_usuario              := k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'usuario');
    l_pagina_parametros    := treat(k_operacion.f_valor_parametro_object(i_parametros,
                                                                         'pagina_parametros') AS
                                    y_pagina_parametros);
    l_orden                := k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'orden');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_usuario IS NOT NULL,
                                    'Debe ingresar usuario');
  
    FOR ele IN cr_elementos(l_id_partido,
                            l_id_torneo,
                            l_estados_partidos,
                            l_estados_predicciones,
                            k_usuario.f_id_usuario(l_usuario),
                            l_orden) LOOP
      l_objeto                       := NEW y_partido_prediccion();
      l_objeto.id_partido            := ele.id_partido;
      l_objeto.id_torneo             := ele.id_torneo;
      l_objeto.id_club_local         := ele.id_club_local;
      l_objeto.id_club_visitante     := ele.id_club_visitante;
      l_objeto.nombre_club_local     := ele.nombre_club_local;
      l_objeto.nombre_club_visitante := ele.nombre_club_visitante;
      l_objeto.fecha                 := ele.fecha;
      l_objeto.hora                  := ele.hora;
      l_objeto.id_fase               := ele.id_fase;
      l_objeto.id_grupo              := ele.id_grupo;
      l_objeto.id_jornada            := ele.id_jornada;
      l_objeto.etiqueta              := ele.etiqueta;
      l_objeto.id_estadio            := ele.id_estadio;
      l_objeto.goles_local           := ele.goles_club_local;
      l_objeto.goles_visitante       := ele.goles_club_visitante;
      l_objeto.estado                := ele.estado;
      l_objeto.estado_juego          := ele.estado_juego;
      l_objeto.cantidad_comentarios  := ele.cantidad_comentarios;
      l_objeto.cantidad_predicciones := ele.cantidad_predicciones;
      l_objeto.cantidad_reacciones   := ele.cantidad_reacciones;
      l_objeto.mi_reaccion           := ele.mi_reaccion;
    
      l_objeto.predic_goles_local     := ele.predic_goles_local;
      l_objeto.predic_goles_visitante := ele.predic_goles_visitante;
      l_objeto.puntos                 := ele.puntos;
      l_objeto.sincronizacion         := ele.id_sincronizacion;
    
      l_objetos.extend;
      l_objetos(l_objetos.count) := l_objeto;
    END LOOP;
  
    l_pagina := k_servicio.f_paginar_elementos(l_objetos,
                                               l_pagina_parametros.pagina,
                                               l_pagina_parametros.por_pagina,
                                               l_pagina_parametros.no_paginar);
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION listar_jornadas(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp      y_respuesta;
    l_pagina   y_pagina;
    l_objetos  y_objetos;
    l_objeto   y_jornada;
    l_partidos y_partidos;
  
    l_id_torneo        t_torneo_jornadas.id_torneo%TYPE;
    l_id_jornada       t_torneo_jornadas.id_jornada%TYPE;
    l_estado           t_partidos.estado%TYPE;
    l_usuario          t_usuarios.alias%TYPE;
    l_incluir_partidos VARCHAR2(1);
  
    CURSOR cr_jornadas(i_id_torneo  IN VARCHAR2,
                       i_id_jornada IN NUMBER,
                       i_estado     IN VARCHAR2) IS
      SELECT j.id_torneo,
             j.id_jornada,
             nvl(j.titulo, 'FECHA ' || j.id_jornada) titulo,
             j.fecha_tope,
             j.hora_tope,
             j.actual,
             j.estado,
             j.situacion
        FROM t_torneo_jornadas j
       WHERE j.id_jornada = nvl(i_id_jornada, j.id_jornada)
         AND j.id_torneo = i_id_torneo
         AND j.estado = nvl(i_estado, j.estado)
       ORDER BY j.id_torneo, j.id_jornada;
  
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_torneo        := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'torneo'),
                              k_sistema.f_valor_parametro_string(k_sistema.c_torneo));
    l_id_jornada       := k_operacion.f_valor_parametro_number(i_parametros,
                                                               'jornada');
    l_estado           := k_operacion.f_valor_parametro_string(i_parametros,
                                                               'estado');
    l_usuario          := k_operacion.f_valor_parametro_string(i_parametros,
                                                               'usuario');
    l_incluir_partidos := k_operacion.f_valor_parametro_string(i_parametros,
                                                               'incluir_partidos');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_torneo IS NOT NULL,
                                    'Debe ingresar torneo');
  
    FOR ele IN cr_jornadas(l_id_torneo, l_id_jornada, l_estado) LOOP
      l_objeto            := NEW y_jornada();
      l_partidos          := NEW y_partidos();
      l_objeto.id_torneo  := ele.id_torneo;
      l_objeto.id_jornada := ele.id_jornada;
      l_objeto.titulo     := ele.titulo;
      l_objeto.estado     := ele.estado;
      IF nvl(l_incluir_partidos, 'S') = 'S' THEN
        l_objeto.partidos := lf_partidos(ele.id_torneo,
                                         NULL, --id_fase
                                         NULL, --id_grupo
                                         ele.id_jornada,
                                         NULL, --id_partido
                                         k_usuario.f_id_usuario(l_usuario));
      
      END IF;
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
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION listar_fases(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp      y_respuesta;
    l_torneo   y_torneo;
    l_objetos  y_objetos;
    l_objeto   y_fase;
    l_grupo    y_torneo_grupo;
    l_grupos   y_torneo_grupos;
    l_jornada  y_jornada;
    l_jornadas y_jornadas;
    l_partidos y_partidos;
  
    l_id_torneo        t_torneo_jornadas.id_torneo%TYPE;
    l_id_fase          t_torneo_fases.id_fase%TYPE;
    l_id_grupo         t_torneo_grupos.id_grupo%TYPE;
    l_id_jornada       t_torneo_jornadas.id_jornada%TYPE;
    l_usuario          t_usuarios.alias%TYPE;
    l_incluir_partidos VARCHAR2(1);
  
    CURSOR cr_fases(i_id_torneo IN VARCHAR2,
                    i_id_fase   IN NUMBER) IS
      SELECT f.id_torneo, f.id_fase, f.descripcion
        FROM t_torneo_fases f
       WHERE f.id_fase = nvl(i_id_fase, f.id_fase)
         AND f.id_torneo = i_id_torneo
       ORDER BY f.id_torneo, f.id_fase;
  
    CURSOR cr_grupos(i_id_torneo IN VARCHAR2,
                     i_id_fase   IN NUMBER,
                     i_id_grupo  IN NUMBER := NULL) IS
      SELECT g.id_torneo, g.id_fase, g.id_grupo, g.descripcion
        FROM t_torneo_grupos g
       WHERE g.id_grupo = nvl(i_id_grupo, g.id_grupo)
         AND g.id_fase = i_id_fase
         AND g.id_torneo = i_id_torneo
       ORDER BY g.id_torneo, g.id_fase, g.id_grupo;
  
    CURSOR cr_jornadas(i_id_torneo  IN VARCHAR2,
                       i_id_fase    IN NUMBER,
                       i_id_jornada IN NUMBER := NULL) IS
      SELECT DISTINCT j.id_torneo,
                      p.id_fase,
                      j.id_jornada,
                      nvl(j.titulo, 'FECHA ' || j.id_jornada) titulo,
                      j.estado
        FROM t_torneo_jornadas j, t_partidos p
       WHERE j.id_torneo = p.id_torneo
         AND j.id_jornada = p.id_jornada
         AND j.id_jornada = nvl(i_id_jornada, j.id_jornada)
         AND p.id_fase = i_id_fase
         AND p.id_grupo IS NULL
         AND j.id_torneo = i_id_torneo
       ORDER BY j.id_torneo, p.id_fase, j.id_jornada;
  
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_torneo  := NEW y_torneo();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_torneo        := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'torneo'),
                              k_sistema.f_valor_parametro_string(k_sistema.c_torneo));
    l_id_fase          := k_operacion.f_valor_parametro_number(i_parametros,
                                                               'fase');
    l_id_grupo         := k_operacion.f_valor_parametro_number(i_parametros,
                                                               'grupo');
    l_id_jornada       := k_operacion.f_valor_parametro_number(i_parametros,
                                                               'jornada');
    l_usuario          := k_operacion.f_valor_parametro_string(i_parametros,
                                                               'usuario');
    l_incluir_partidos := k_operacion.f_valor_parametro_string(i_parametros,
                                                               'incluir_partidos');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_torneo IS NOT NULL,
                                    'Debe ingresar torneo');
  
    FOR ele IN cr_fases(l_id_torneo, l_id_fase) LOOP
      l_objeto := NEW y_fase();
    
      l_grupos   := NEW y_torneo_grupos();
      l_jornadas := NEW y_jornadas();
      l_partidos := NEW y_partidos();
    
      l_objeto.id_fase     := ele.id_fase;
      l_objeto.descripcion := ele.descripcion;
    
      IF nvl(l_incluir_partidos, 'S') = 'S' THEN
        l_partidos := lf_partidos(ele.id_torneo,
                                  ele.id_fase,
                                  NULL, --id_grupo
                                  NULL, --id_jornada
                                  NULL, --id_partido
                                  k_usuario.f_id_usuario(l_usuario));
      END IF;
    
      FOR gr IN cr_grupos(ele.id_torneo, ele.id_fase, l_id_grupo) LOOP
        l_grupo := NEW y_torneo_grupo();
      
        l_grupo.id_grupo    := gr.id_grupo;
        l_grupo.descripcion := gr.descripcion;
      
        IF nvl(l_incluir_partidos, 'S') = 'S' THEN
          l_grupo.partidos := lf_partidos(gr.id_torneo,
                                          gr.id_fase,
                                          gr.id_grupo,
                                          NULL, --id_jornada
                                          NULL, --id_partido
                                          k_usuario.f_id_usuario(l_usuario));
        END IF;
      
        l_grupos.extend;
        l_grupos(l_grupos.count) := l_grupo;
      END LOOP;
    
      FOR jo IN cr_jornadas(ele.id_torneo, ele.id_fase, l_id_jornada) LOOP
        l_jornada := NEW y_jornada();
      
        l_jornada.id_torneo  := jo.id_torneo;
        l_jornada.id_jornada := jo.id_jornada;
        l_jornada.titulo     := jo.titulo;
        l_jornada.estado     := jo.estado;
      
        IF nvl(l_incluir_partidos, 'S') = 'S' THEN
          l_jornada.partidos := lf_partidos(jo.id_torneo,
                                            jo.id_fase,
                                            NULL, --id_grupo
                                            jo.id_jornada,
                                            NULL, --id_partido
                                            k_usuario.f_id_usuario(l_usuario));
        END IF;
      
        l_jornadas.extend;
        l_jornadas(l_jornadas.count) := l_jornada;
      END LOOP;
    
      l_objeto.partidos := l_partidos;
      IF l_grupos.count > 0 THEN
        l_objeto.grupos := l_grupos;
      END IF;
      IF l_jornadas.count > 0 THEN
        l_objeto.jornadas := l_jornadas;
      END IF;
      l_objetos.extend;
      l_objetos(l_objetos.count) := l_objeto;
    END LOOP;
    l_torneo.id_torneo := l_id_torneo;
    l_torneo.fases     := l_objetos;
    BEGIN
      SELECT nvl(tor.tipo, 'L') tipo
        INTO l_torneo.tipo
        FROM t_torneos tor
       WHERE tor.id_torneo = l_id_torneo;
    EXCEPTION
      WHEN OTHERS THEN
        l_torneo.tipo := 'L'; --Liga
    END;
  
    k_operacion.p_respuesta_ok(l_rsp, l_torneo);
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

  FUNCTION realizar_prediccion(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_partido    t_partidos.id_partido%TYPE;
    l_usuario    t_usuarios.alias%TYPE;
    l_id_usuario t_usuarios.id_usuario%TYPE;
  
    l_estado      t_partidos.estado_predicciones%TYPE;
    l_id_torneo   t_torneos.id_torneo%TYPE;
    l_id_division t_divisiones.id_division%TYPE;
    l_id_grupo    t_grupos.id_grupo%TYPE;
  
    l_jornadas_prediccion_previa PLS_INTEGER := 0;
    l_jornadas_prediccion_actual PLS_INTEGER := 0;
  
    l_primera_prediccion VARCHAR2(1) := 'N';
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar  := 'Obteniendo parámetros';
    l_partido    := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'partido');
    l_usuario    := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'usuario');
    l_id_usuario := k_usuario.f_id_usuario(l_usuario);
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_partido IS NOT NULL,
                                    'Debe ingresar partido');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_usuario IS NOT NULL,
                                    'Debe ingresar usuario');
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_number(i_parametros,
                                                                         'id_sincronizacion') IS NOT NULL,
                                    'Debe ingresar id_sincronizacion');
    -- Validar estado de predicciones del partido
    BEGIN
      SELECT MIN(p.estado_predicciones), MIN(p.id_torneo)
        INTO l_estado, l_id_torneo
        FROM t_partidos p
       WHERE p.id_partido = l_partido;
    END;
    k_operacion.p_validar_parametro(l_rsp,
                                    l_estado = 'P',
                                    'Partido no disponible');
    /* TODO: text="Validar que el usuario exista" */
  
    l_rsp.lugar := 'Obteniendo división del torneo';
    BEGIN
      SELECT x.id_division
        INTO l_id_division
        FROM t_torneos x
       WHERE x.id_torneo = l_id_torneo;
    END;
  
    l_rsp.lugar := 'Obteniendo cantidad previa de jornada con prediccion del usuario';
    BEGIN
      SELECT COUNT(DISTINCT p.id_jornada)
        INTO l_jornadas_prediccion_previa
        FROM t_predicciones a, t_partidos p
       WHERE p.id_torneo = l_id_torneo
         AND a.id_partido = p.id_partido
         AND a.id_usuario = l_id_usuario;
    END;
  
    l_rsp.lugar := 'Verificando si es la priemra prediccion del usuario en la división';
    BEGIN
      SELECT decode(nvl(COUNT(1), 0), 0, 'S', 'N') primera_prediccion
        INTO l_primera_prediccion
        FROM t_predicciones a, t_partidos p, t_torneos c
       WHERE a.id_partido = p.id_partido
         AND p.id_torneo = c.id_torneo
         AND c.id_division = l_id_division
         AND a.id_usuario = l_id_usuario;
    END;
  
    l_rsp.lugar := 'Realizando prediccion';
    MERGE INTO t_predicciones d
    USING (SELECT l_partido id_partido,
                  l_id_usuario id_usuario,
                  nvl(k_operacion.f_valor_parametro_number(i_parametros,
                                                           'goles_club_local'),
                      0) goles_club_local,
                  nvl(k_operacion.f_valor_parametro_number(i_parametros,
                                                           'goles_club_visitante'),
                      0) goles_club_visitante,
                  k_operacion.f_valor_parametro_number(i_parametros,
                                                       'id_sincronizacion') id_sincronizacion
             FROM dual n
           /*SELECT n.id_partido,
                (SELECT x.id_usuario
                   FROM t_usuarios x
                  WHERE x.alias = n.usuario) id_usuario,
                n.goles_club_local,
                n.goles_club_visitante,
                n.id_sincronizacion
           FROM json_table(i_parametros, '$' 
                    columns (
                         id_partido NUMBER(10) path '$.partido',
                         usuario VARCHAR2(300) path '$.usuario',
                         goles_club_local NUMBER(3) path '$.goles_club_local',
                         goles_club_visitante NUMBER(3) path '$.goles_club_visitante',
                         id_sincronizacion NUMBER(3) path '$.id_sincronizacion' ) ) n*/
           ) s
    ON (d.id_partido = s.id_partido AND d.id_usuario = s.id_usuario)
    WHEN MATCHED THEN
      UPDATE
         SET d.goles_club_local     = s.goles_club_local,
             d.goles_club_visitante = s.goles_club_visitante,
             d.id_sincronizacion    = s.id_sincronizacion
      --WHERE nvl(s.id_sincronizacion, 0) > nvl(d.id_sincronizacion, 0) --comentado temporalmente
      
    
    WHEN NOT MATCHED THEN
      INSERT
        (d.id_partido,
         d.id_usuario,
         d.goles_club_local,
         d.goles_club_visitante,
         d.id_sincronizacion)
      VALUES
        (s.id_partido,
         s.id_usuario,
         s.goles_club_local,
         s.goles_club_visitante,
         s.id_sincronizacion);
  
    l_rsp.lugar := 'Obteniendo cantidad actual de jornada con prediccion del usuario';
    BEGIN
      SELECT COUNT(DISTINCT p.id_jornada)
        INTO l_jornadas_prediccion_actual
        FROM t_predicciones a, t_partidos p
       WHERE p.id_torneo = l_id_torneo
         AND a.id_partido = p.id_partido
         AND a.id_usuario = l_id_usuario;
    END;
  
    l_rsp.lugar := 'Sugiriendo calificar cada X cantidad de jornadas con prediccion';
    IF nvl(k_dato.f_recuperar_dato_string('T_USUARIOS',
                                          'CALIFICA_AND',
                                          l_usuario),
           'X') NOT IN ('S', 'N') THEN
      IF l_jornadas_prediccion_actual > 0 AND
         MOD(l_jornadas_prediccion_actual, 3) = 0 AND
         MOD(l_jornadas_prediccion_actual, 3) <> 0 THEN
        --TODO: dinamizar cantidad de jornadas: 3
        l_dato.contenido := 'calificar';
      END IF;
    END IF;
  
    l_rsp.lugar := 'Obteniendo grupo general del torneo';
    l_id_grupo  := k_puntajes_fan.f_grupo_general_torneo(l_id_torneo);
  
    l_rsp.lugar := 'Registrando grupo general del torneo, si no existe';
    IF l_id_grupo IS NULL THEN
      INSERT INTO t_grupos
        (id_division,
         descripcion,
         tipo,
         id_usuario_administrador,
         fecha_creacion,
         estado,
         situacion,
         id_club,
         todos_invitan)
      VALUES
        (l_id_division, 'General', 'GLO', NULL, NULL, 'A', 'A', NULL, 'N')
      RETURNING id_grupo INTO l_id_grupo;
    
      INSERT INTO t_grupo_torneos
        (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
      VALUES
        (l_id_grupo, l_id_torneo, NULL, NULL);
    END IF;
  
    l_rsp.lugar := 'Registrando usuario en el grupo general del torneo';
    IF k_usuario.f_usuario_prueba(l_id_usuario) = 'N' THEN
      BEGIN
        INSERT INTO t_grupo_usuarios
          (id_grupo,
           id_usuario,
           puntos,
           ranking,
           estado,
           token_activacion,
           aceptado)
        VALUES
          (l_id_grupo, l_id_usuario, NULL, NULL, 'A', NULL, 'S');
      EXCEPTION
        WHEN dup_val_on_index THEN
          NULL;
      END;
    END IF;
  
    l_rsp.lugar := 'Registrando grupos de la división del torneo, si no existen';
    BEGIN
      INSERT INTO t_grupo_torneos
        (id_grupo, id_torneo, id_jornada_inicio, id_jornada_fin)
        SELECT gr.id_grupo, l_id_torneo, NULL, NULL
          FROM t_grupos gr
         WHERE (gr.tipo = 'PRI' OR gr.id_grupo = l_id_grupo)
           AND gr.estado = 'A'
           AND gr.id_division = l_id_division
           AND NOT EXISTS (SELECT 1
                  FROM t_grupo_torneos y
                 WHERE y.id_grupo = gr.id_grupo
                   AND y.id_torneo = l_id_torneo);
    END;
  
    l_rsp.lugar := 'Registrando usuario en el torneo de los grupos de la división a los que pertenece';
    BEGIN
      INSERT INTO t_grupo_torneo_usuarios
        (id_grupo, id_torneo, id_usuario, puntos, ranking)
        SELECT gr.id_grupo, l_id_torneo, gu.id_usuario, NULL, NULL
          FROM t_grupos gr, t_grupo_usuarios gu
         WHERE gr.id_grupo = gu.id_grupo
           AND gu.id_usuario = l_id_usuario
           AND (gr.tipo = 'PRI' OR gr.id_grupo = l_id_grupo)
           AND gr.estado = 'A'
           AND nvl(gu.estado, 'I') <> 'I'
           AND gr.id_division = l_id_division
           AND NOT EXISTS (SELECT 1
                  FROM t_grupo_torneo_usuarios y
                 WHERE y.id_grupo = gr.id_grupo
                   AND y.id_usuario = gu.id_usuario
                   AND y.id_torneo = l_id_torneo);
    END;
  
    l_rsp.lugar := 'Registrando seguimiento y suscripciones de la división para usuario';
    BEGIN
      IF l_primera_prediccion = 'S' THEN
        BEGIN
          INSERT INTO t_usuario_divisiones
            (id_usuario, id_division)
          VALUES
            (l_id_usuario, l_id_division);
        EXCEPTION
          WHEN dup_val_on_index THEN
            NULL;
        END;
        k_usuario.p_suscribir_notificacion(l_id_usuario,
                                           k_dispositivo.f_suscripcion_division(l_id_division));
        k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario),
                                                 k_dispositivo.f_suscripcion_division(l_id_division));
      END IF;
    END;
  
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
  END;

  FUNCTION registrar_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp                      y_respuesta;
    l_grupo                    y_grupo;
    l_id_usuario_administrador t_usuarios.id_usuario%TYPE;
    l_id_grupo                 t_grupos.id_grupo%TYPE;
    l_id_jornada_inicio        t_grupo_torneos.id_jornada_inicio%TYPE;
    --
    l_id_torneo t_torneos.id_torneo%TYPE := k_sistema.f_valor_parametro_string(k_sistema.c_torneo);
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar         := 'Obteniendo parámetros';
    l_id_jornada_inicio := k_operacion.f_valor_parametro_number(i_parametros,
                                                                'id_jornada_inicio');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tipo') IN
                                    ('GLO', 'PRI', 'PUB'),
                                    'Tipo de grupo incorrecto');
  
    -- Busca usuario
    l_id_usuario_administrador := k_usuario.f_id_usuario(k_sistema.f_valor_parametro_string(k_sistema.c_usuario));
  
    l_rsp.lugar := 'Verificando si el torneo es liga o copa';
    DECLARE
      l_tipo_torneo t_torneos.tipo%TYPE;
    BEGIN
      SELECT nvl(t.tipo, 'L')
        INTO l_tipo_torneo
        FROM t_torneos t
       WHERE t.id_torneo = l_id_torneo;
    
      IF l_id_jornada_inicio = 0 THEN
        l_id_jornada_inicio := NULL;
      END IF;
      IF l_tipo_torneo = 'C' THEN
        --Copa
        k_operacion.p_validar_parametro(l_rsp,
                                        l_id_jornada_inicio IS NULL,
                                        'Copa no debe tener jornada de inicio.');
      END IF;
    END;
  
    l_rsp.lugar := 'Registrando grupo';
    INSERT INTO t_grupos
      (id_division,
       descripcion,
       tipo,
       id_usuario_administrador,
       fecha_creacion,
       estado,
       situacion,
       id_club,
       todos_invitan)
    VALUES
      ((SELECT x.id_division
         FROM t_torneos x
        WHERE x.id_torneo = l_id_torneo),
       k_operacion.f_valor_parametro_string(i_parametros, 'descripcion'),
       k_operacion.f_valor_parametro_string(i_parametros, 'tipo'),
       l_id_usuario_administrador,
       current_timestamp,
       'A',
       'A',
       k_operacion.f_valor_parametro_string(i_parametros, 'id_club'),
       k_operacion.f_valor_parametro_string(i_parametros, 'todos_invitan'))
    RETURNING id_grupo INTO l_id_grupo;
  
    l_rsp.lugar := 'Registrando torneo del grupo';
    INSERT INTO t_grupo_torneos
      (id_grupo, id_torneo, id_jornada_inicio)
    VALUES
      (l_id_grupo, l_id_torneo, l_id_jornada_inicio);
  
    IF l_id_usuario_administrador IS NOT NULL THEN
      l_rsp.lugar := 'Registrando usuario administrador en el grupo';
      INSERT INTO t_grupo_usuarios
        (id_grupo,
         id_usuario,
         puntos,
         ranking,
         estado,
         token_activacion,
         aceptado,
         fecha_aceptacion)
      VALUES
        (l_id_grupo,
         l_id_usuario_administrador,
         NULL,
         NULL,
         'A',
         NULL,
         'S',
         SYSDATE);
    
      l_rsp.lugar := 'Registrando suscripciones para usuario administrador en el grupo';
      k_usuario.p_suscribir_notificacion(l_id_usuario_administrador,
                                         k_dispositivo.f_suscripcion_grupo(l_id_grupo));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario_administrador),
                                               k_dispositivo.f_suscripcion_grupo(l_id_grupo));
    END IF;
  
    l_rsp.lugar := 'Cargando datos del grupo';
    l_grupo     := lf_datos_grupo(l_id_grupo);
  
    k_operacion.p_respuesta_ok(l_rsp, l_grupo);
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

  FUNCTION editar_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp                      y_respuesta;
    l_id_usuario_administrador t_usuarios.id_usuario%TYPE;
    l_tipo                     t_grupos.tipo%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tipo') IN
                                    ('GLO', 'PRI', 'PUB'),
                                    'Tipo de grupo incorrecto');
  
    l_rsp.lugar := 'Buscando datos del grupo';
    BEGIN
      SELECT a.tipo, a.id_usuario_administrador
        INTO l_tipo, l_id_usuario_administrador
        FROM t_grupos a
       WHERE a.id_grupo =
             k_operacion.f_valor_parametro_number(i_parametros, 'id_grupo');
    EXCEPTION
      WHEN no_data_found THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000001');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000002');
        RAISE k_operacion.ex_error_general;
    END;
  
    -- Valida tipo
    IF l_tipo <> 'PRI' THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000010');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    -- Valida usuario administrador
    IF k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario) <>
       l_id_usuario_administrador THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000011');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    -- TODO: validar edicion de jornada inicio y fin:
    -- se puede cambiar p/ cada torneo, antes de que empiece la jornada en cuestion y solo a una no iniciada
  
    l_rsp.lugar := 'Editando grupo';
    UPDATE t_grupos a
       SET a.descripcion = k_operacion.f_valor_parametro_string(i_parametros,
                                                                'descripcion'),
           a.tipo        = k_operacion.f_valor_parametro_string(i_parametros,
                                                                'tipo'),
           /*a.id_jornada_inicio = k_operacion.f_valor_parametro_number(i_parametros,
           'id_jornada_inicio'),*/
           a.id_club       = k_operacion.f_valor_parametro_string(i_parametros,
                                                                  'id_club'),
           a.todos_invitan = k_operacion.f_valor_parametro_string(i_parametros,
                                                                  'todos_invitan')
     WHERE a.id_grupo =
           k_operacion.f_valor_parametro_number(i_parametros, 'id_grupo');
  
    l_rsp.lugar := 'Editando torneo del grupo';
    --TODO: buscar el torneo actual del grupo para actualizar la jornada inicio
  
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

  FUNCTION datos_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp   y_respuesta;
    l_grupo y_grupo;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_number(i_parametros,
                                                                         'id_grupo') IS NOT NULL,
                                    'Debe ingresar id_grupo');
  
    l_rsp.lugar := 'Cargando datos del grupo';
    l_grupo     := lf_datos_grupo(k_operacion.f_valor_parametro_number(i_parametros,
                                                                       'id_grupo'));
  
    k_operacion.p_respuesta_ok(l_rsp, l_grupo);
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

  FUNCTION listar_grupos(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_grupo;
  
    l_id_torneo         t_partidos.id_torneo%TYPE;
    l_pagina_parametros y_pagina_parametros;
  
    CURSOR cr_elementos(i_id_torneo  IN VARCHAR2,
                        i_tipo       IN VARCHAR2,
                        i_mis_grupos IN VARCHAR2,
                        i_aceptado   IN VARCHAR2) IS
      SELECT a.id_grupo
        FROM t_grupos a, t_grupo_torneos b
       WHERE a.id_grupo = b.id_grupo
         AND a.tipo = nvl(i_tipo, a.tipo)
         AND a.estado = 'A'
         AND b.id_torneo = i_id_torneo
         AND a.tipo IN (SELECT a.codigo
                          FROM t_significados a
                         WHERE a.dominio = 'TIPO_GRUPO'
                           AND a.activo = 'S') --Tipo de grupo Activo
         AND ((i_mis_grupos = 'S' AND EXISTS
              (SELECT 1
                  FROM t_grupo_usuarios u
                 WHERE u.id_grupo = a.id_grupo
                   AND u.id_usuario =
                       k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario)
                   AND nvl(u.estado, 'I') <> 'I')) OR
             (i_mis_grupos <> 'S'))
         AND ((i_aceptado IN ('S', 'N') AND EXISTS
              (SELECT 1
                  FROM t_grupo_usuarios u
                 WHERE u.id_grupo = a.id_grupo
                   AND u.id_usuario =
                       k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario)
                   AND nvl(u.aceptado, 'N') = i_aceptado
                   AND nvl(u.estado, 'I') <> 'I')) OR (i_aceptado IS NULL))
       ORDER BY a.descripcion;
  BEGIN
    -- Inicializa respuesta
    l_rsp       := NEW y_respuesta();
    l_elementos := NEW y_objetos();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_object(i_parametros,
                                                                         'pagina_parametros') IS NOT NULL,
                                    'Debe ingresar pagina_parametros');
    l_id_torneo         := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                                    'torneo'),
                               k_sistema.f_valor_parametro_string(k_sistema.c_torneo));
    l_pagina_parametros := treat(k_operacion.f_valor_parametro_object(i_parametros,
                                                                      'pagina_parametros') AS
                                 y_pagina_parametros);
  
    FOR ele IN cr_elementos(l_id_torneo,
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'tipo_grupo'),
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'mis_grupos'),
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'aceptado')) LOOP
      l_elemento := lf_datos_grupo(ele.id_grupo,
                                   k_operacion.f_valor_parametro_string(i_parametros,
                                                                        'incluir_usuarios'));
    
      l_elementos.extend;
      l_elementos(l_elementos.count) := l_elemento;
    END LOOP;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               l_pagina_parametros.pagina,
                                               l_pagina_parametros.por_pagina,
                                               l_pagina_parametros.no_paginar);
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION abandonar_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_usuario  t_usuarios.alias%TYPE;
    l_id_grupo t_grupos.id_grupo%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar := 'Obteniendo variables del sistema';
    l_usuario   := k_sistema.f_valor_parametro_string(k_sistema.c_usuario);
  
    l_rsp.lugar := 'Obteniendo parámetros';
    l_id_grupo  := k_operacion.f_valor_parametro_number(i_parametros,
                                                        'id_grupo');
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_grupo IS NOT NULL,
                                    'Debe ingresar id_grupo');
  
    -- TODO: Otras validaciones internas. Ej: tipo de grupo
    -- TODO: Si se elimina al usuario administrador, actualizar a un nuevo administrador
  
    l_rsp.lugar := 'Eliminando usuario del grupo';
    UPDATE t_grupo_usuarios a
       SET a.estado = 'I' --Inactivo
     WHERE a.id_grupo = l_id_grupo
       AND a.id_usuario = k_usuario.f_id_usuario(l_usuario);
  
    l_rsp.lugar := 'Eliminar suscripciones del grupo para el usuario';
    k_usuario.p_desuscribir_notificacion(k_usuario.f_id_usuario(l_usuario),
                                         k_dispositivo.f_suscripcion_grupo(l_id_grupo));
    k_dispositivo.p_desuscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(k_usuario.f_id_usuario(l_usuario)),
                                               k_dispositivo.f_suscripcion_grupo(l_id_grupo));
  
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
  END;

  FUNCTION invitar_usuario(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp                      y_respuesta;
    l_dato                     y_dato;
    l_id_usuario               t_usuarios.id_usuario%TYPE;
    l_id_grupo                 t_grupos.id_grupo%TYPE;
    l_tipo                     t_grupos.tipo%TYPE;
    l_id_usuario_administrador t_grupos.id_usuario_administrador %TYPE;
    l_todos_invitan            t_grupos.todos_invitan%TYPE;
    l_token_activacion         t_grupo_usuarios.token_activacion%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar := 'Validando parametros';
  
    l_rsp.lugar := 'Buscando datos del grupo';
    l_id_grupo  := k_operacion.f_valor_parametro_number(i_parametros,
                                                        'id_grupo');
    BEGIN
      SELECT a.tipo, a.id_usuario_administrador, a.todos_invitan
        INTO l_tipo, l_id_usuario_administrador, l_todos_invitan
        FROM t_grupos a
       WHERE a.id_grupo = l_id_grupo;
    EXCEPTION
      WHEN no_data_found THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000001');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000002');
        RAISE k_operacion.ex_error_general;
    END;
  
    l_id_usuario := k_usuario.f_buscar_id(k_operacion.f_valor_parametro_string(i_parametros,
                                                                               'usuario'));
    IF l_id_usuario IS NULL THEN
      $if k_modulo.c_instalado_msj $then
      IF k_mensajeria.f_validar_direccion_correo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'usuario')) THEN
        l_rsp.lugar := 'Realizando invitación, si es correo electrónico no catastrado.';
        BEGIN
          lp_realizar_invitacion(i_id_usuario       => k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario),
                                 i_direccion_correo => k_operacion.f_valor_parametro_string(i_parametros,
                                                                                            'usuario'),
                                 i_id_grupo         => l_id_grupo);
        
          k_operacion.p_respuesta_error(l_rsp, 'fan0000003');
          RAISE k_operacion.ex_error_general;
        EXCEPTION
          WHEN dup_val_on_index THEN
            NULL;
        END;
      END IF;
      $end
      k_operacion.p_respuesta_error(l_rsp, 'fan0000008');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    -- Valida tipo
    IF l_tipo <> 'PRI' THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000005');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    -- Valida usuario administrador
    IF nvl(l_todos_invitan, 'N') <> 'S' AND k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario) <>
       l_id_usuario_administrador THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000012');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    l_rsp.lugar := 'Registrando usuario en el grupo';
    BEGIN
      INSERT INTO t_grupo_usuarios
        (id_grupo,
         id_usuario,
         puntos,
         ranking,
         estado,
         token_activacion,
         aceptado,
         fecha_aceptacion)
      VALUES
        (l_id_grupo,
         l_id_usuario,
         NULL,
         NULL,
         'P',
         k_autenticacion.f_randombytes_base64,
         'N',
         NULL)
      RETURNING token_activacion INTO l_token_activacion;
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000013');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000014');
        RAISE k_operacion.ex_error_general;
    END;
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Enviando mensajería';
    IF k_mensajeria.f_enviar_mensaje(l_token_activacion, l_id_usuario) <>
       k_mensajeria.c_ok THEN
      NULL;
      -- k_operacion.p_respuesta_error(l_rsp, 'fan0008', 'Error al enviar invitación');
      -- RAISE k_operacion.ex_error_general;
    END IF;
    $end
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Registrando notificacion';
    DECLARE
      l_json_object json_object_t;
      l_result      PLS_INTEGER;
      l_grupo       y_grupo := lf_datos_grupo(l_id_grupo);
    BEGIN
      l_json_object := NEW json_object_t();
      l_json_object.put('tipo', 'INVITACION_GRUPO'); --TODO: convertir a constante
      l_json_object.put('identificador', l_id_grupo);
    
      l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => 'Invitación a ' ||
                                                                      l_grupo.descripcion,
                                                     i_contenido   => k_sistema.f_valor_parametro_string(k_sistema.c_usuario) ||
                                                                      ' te envió una invitación al grupo ' ||
                                                                      l_grupo.descripcion,
                                                     i_datos_extra => l_json_object.to_clob,
                                                     i_id_usuario  => l_id_usuario,
                                                     i_suscripcion => 'ESPECIAL'); --TODO: convertir a constante
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    $end
  
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
  END;

  FUNCTION responder_invitacion(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    c_aceptar  CONSTANT VARCHAR2(8) := 'ACEPTAR';
    c_rechazar CONSTANT VARCHAR2(8) := 'RECHAZAR';
  
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_usuario    t_usuarios.alias%TYPE;
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_id_grupo   t_grupos.id_grupo%TYPE;
    l_respuesta  VARCHAR2(8);
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar  := 'Obteniendo variables del sistema';
    l_usuario    := k_sistema.f_valor_parametro_string(k_sistema.c_usuario);
    l_id_usuario := k_usuario.f_id_usuario(l_usuario);
  
    l_rsp.lugar := 'Obteniendo parámetros';
    l_id_grupo  := k_operacion.f_valor_parametro_number(i_parametros,
                                                        'id_grupo');
    l_respuesta := k_operacion.f_valor_parametro_string(i_parametros,
                                                        'respuesta');
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_grupo IS NOT NULL,
                                    'Debe ingresar id_grupo');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IS NOT NULL,
                                    'Debe ingresar respuesta');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IN (c_aceptar, c_rechazar),
                                    'Valores posibles de respuesta: ' || '[' ||
                                    c_aceptar || '], [' || c_rechazar || ']');
    --TODO: Agregar otras validaciones si es necesario
  
    l_rsp.lugar := 'Respondiendo invitación del grupo';
    IF l_respuesta = c_aceptar THEN
      UPDATE t_grupo_usuarios a
         SET a.estado = 'A', a.aceptado = 'S', a.fecha_aceptacion = SYSDATE
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_usuario;
    
      l_rsp.lugar := 'Registrando suscripciones para usuario en el grupo';
      k_usuario.p_suscribir_notificacion(l_id_usuario,
                                         k_dispositivo.f_suscripcion_grupo(l_id_grupo));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario),
                                               k_dispositivo.f_suscripcion_grupo(l_id_grupo));
    
      l_dato.contenido := to_char(l_id_usuario);
    ELSIF l_respuesta = c_rechazar THEN
      BEGIN
        DELETE t_grupo_usuarios a
         WHERE a.id_grupo = l_id_grupo
           AND a.id_usuario = l_id_usuario;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE t_grupo_usuarios a
             SET a.estado = 'I' --Inactivo
           WHERE a.id_grupo = l_id_grupo
             AND a.id_usuario = l_id_usuario;
      END;
    END IF;
  
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
  END;

  FUNCTION solicitar_ingreso_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp              y_respuesta;
    l_dato             y_dato;
    l_id_solicitante   t_usuarios.id_usuario%TYPE;
    l_id_grupo         t_grupos.id_grupo%TYPE;
    l_tipo             t_grupos.tipo%TYPE;
    l_token_activacion t_grupo_usuarios.token_activacion%TYPE;
    l_estado_usuario   VARCHAR2(1) := 'N'; -- N - No existe
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar      := 'Obteniendo variables del sistema';
    l_id_solicitante := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
  
    l_rsp.lugar := 'Obteniendo parametros';
    l_id_grupo  := k_operacion.f_valor_parametro_number(i_parametros,
                                                        'id_grupo');
  
    BEGIN
      SELECT a.tipo
        INTO l_tipo
        FROM t_grupos a
       WHERE a.id_grupo = l_id_grupo;
    EXCEPTION
      WHEN no_data_found THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000001');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000002');
        RAISE k_operacion.ex_error_general;
    END;
  
    -- Valida tipo
    IF l_tipo <> 'PRI' THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000005');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    BEGIN
      SELECT nvl(a.estado, 'I')
        INTO l_estado_usuario
        FROM t_grupo_usuarios a
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_solicitante;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000006',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
    l_rsp.lugar := 'Registrando solicitud de ingreso del usuario al grupo';
    IF l_estado_usuario = 'A' THEN
      -- A - Activo
      k_operacion.p_respuesta_error(l_rsp, 'fan0000007');
      RAISE k_operacion.ex_error_general;
    
    ELSIF l_estado_usuario = 'S' THEN
      -- S - Pendiente Solicitado
      k_operacion.p_respuesta_error(l_rsp, 'fan0000007');
      RAISE k_operacion.ex_error_general;
    
    ELSIF l_estado_usuario = 'P' THEN
      -- P - Pendiente Invitado
      UPDATE t_grupo_usuarios a
         SET a.estado = 'A', a.aceptado = 'S', a.fecha_aceptacion = SYSDATE
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_solicitante;
    
    ELSIF l_estado_usuario = 'I' THEN
      -- I - Inactivo
      UPDATE t_grupo_usuarios a
         SET a.estado           = 'S',
             a.token_activacion = k_autenticacion.f_randombytes_base64,
             a.aceptado         = 'N',
             a.fecha_aceptacion = NULL
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_solicitante
      RETURNING token_activacion INTO l_token_activacion;
    
    ELSE
    
      BEGIN
        INSERT INTO t_grupo_usuarios
          (id_grupo,
           id_usuario,
           puntos,
           ranking,
           estado,
           token_activacion,
           aceptado,
           fecha_aceptacion)
        VALUES
          (l_id_grupo,
           l_id_solicitante,
           NULL,
           NULL,
           'S',
           k_autenticacion.f_randombytes_base64,
           'N',
           NULL)
        RETURNING token_activacion INTO l_token_activacion;
      EXCEPTION
        WHEN dup_val_on_index THEN
          k_operacion.p_respuesta_error(l_rsp, 'fan0000013');
          RAISE k_operacion.ex_error_general;
        WHEN OTHERS THEN
          k_operacion.p_respuesta_error(l_rsp, 'fan0000014');
          RAISE k_operacion.ex_error_general;
      END;
    
    END IF;
  
    /*l_rsp.lugar := 'Registrando suscripciones de la amistad para usuario';
    IF l_id_amistad IS NOT NULL THEN
      k_usuario.p_suscribir_notificacion(l_id_solicitante,
                                         k_dispositivo.f_suscripcion_amistad(l_id_amistad));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_solicitante),
                                               k_dispositivo.f_suscripcion_amistad(l_id_amistad));
    END IF;*/
  
    /*$if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Enviando mensajería';
    IF k_mensajeria.f_enviar_mensaje(l_token_aceptacion, l_id_solicitado) <>
       k_mensajeria.c_ok THEN
      NULL;
      -- k_operacion.p_respuesta_error(l_rsp, 'fan0008', 'Error al solicitar amistad');
      -- RAISE k_operacion.ex_error_general;
    END IF;
    $end*/
  
    /*$if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Registrando notificacion';
    DECLARE
      l_json_object json_object_t;
      l_result      PLS_INTEGER;
    BEGIN
      l_json_object := NEW json_object_t();
      l_json_object.put('tipo', 'SOLICITUD_AMISTAD'); --TODO: convertir a constante
      l_json_object.put('identificador',
                        k_sistema.f_valor_parametro_string(k_sistema.c_usuario));
    
      l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => 'Solicitud de amistad',
                                                     i_contenido   => k_sistema.f_valor_parametro_string(k_sistema.c_usuario) ||
                                                                      ' te envió una solicitud de amistad',
                                                     i_datos_extra => l_json_object.to_clob,
                                                     i_id_usuario  => l_id_solicitado,
                                                     i_suscripcion => 'ESPECIAL'); --TODO: convertir a constante
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    $end*/
  
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
  END;

  FUNCTION responder_ingreso_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    c_aceptar  CONSTANT VARCHAR2(8) := 'ACEPTAR';
    c_rechazar CONSTANT VARCHAR2(8) := 'RECHAZAR';
  
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_tipo                     t_grupos.tipo%TYPE;
    l_id_usuario_administrador t_grupos.id_usuario_administrador %TYPE;
    l_todos_invitan            t_grupos.todos_invitan%TYPE;
    l_estado_usuario           VARCHAR2(1) := 'N'; -- N - No existe
  
    l_usuario        t_usuarios.alias%TYPE;
    l_id_usuario     t_usuarios.id_usuario%TYPE;
    l_id_grupo       t_grupos.id_grupo%TYPE;
    l_solicitante    t_usuarios.alias%TYPE;
    l_id_solicitante t_usuarios.id_usuario%TYPE;
    l_respuesta      VARCHAR2(8);
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar  := 'Obteniendo variables del sistema';
    l_usuario    := k_sistema.f_valor_parametro_string(k_sistema.c_usuario);
    l_id_usuario := k_usuario.f_id_usuario(l_usuario);
  
    l_rsp.lugar   := 'Obteniendo parámetros';
    l_id_grupo    := k_operacion.f_valor_parametro_number(i_parametros,
                                                          'id_grupo');
    l_solicitante := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'usuario_solicitante');
    l_respuesta   := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'respuesta');
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_grupo IS NOT NULL,
                                    'Debe ingresar id_grupo');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_solicitante IS NOT NULL,
                                    'Debe ingresar usuario solicitante');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IS NOT NULL,
                                    'Debe ingresar respuesta');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IN (c_aceptar, c_rechazar),
                                    'Valores posibles de respuesta: ' || '[' ||
                                    c_aceptar || '], [' || c_rechazar || ']');
    --TODO: Agregar otras validaciones si es necesario
  
    l_id_solicitante := k_usuario.f_id_usuario(l_solicitante);
  
    BEGIN
      SELECT a.tipo, a.id_usuario_administrador, a.todos_invitan
        INTO l_tipo, l_id_usuario_administrador, l_todos_invitan
        FROM t_grupos a
       WHERE a.id_grupo = l_id_grupo;
    EXCEPTION
      WHEN no_data_found THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000001');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000002');
        RAISE k_operacion.ex_error_general;
    END;
  
    -- Valida tipo
    IF l_tipo <> 'PRI' THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000005');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    -- Valida usuario administrador
    IF nvl(l_todos_invitan, 'N') <> 'S' AND k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario) <>
       l_id_usuario_administrador THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000012');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    BEGIN
      SELECT nvl(a.estado, 'I')
        INTO l_estado_usuario
        FROM t_grupo_usuarios a
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_solicitante;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000006',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
    IF l_estado_usuario IN ('N', 'I') THEN
      -- N - No existe, I - Inactivo
      k_operacion.p_respuesta_error(l_rsp, 'fan0000012');
      RAISE k_operacion.ex_error_general;
    ELSIF l_estado_usuario = 'A' THEN
      -- A - Activo
      k_operacion.p_respuesta_error(l_rsp, 'fan0000012');
      RAISE k_operacion.ex_error_general;
    ELSIF l_estado_usuario = 'P' THEN
      -- P - Pendiente Invitado
      k_operacion.p_respuesta_error(l_rsp, 'fan0000012');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    l_rsp.lugar := 'Respondiendo solicitud de ingreso al grupo';
    IF l_respuesta = c_aceptar THEN
      UPDATE t_grupo_usuarios a
         SET a.estado = 'A', a.aceptado = 'S', a.fecha_aceptacion = SYSDATE
       WHERE a.id_grupo = l_id_grupo
         AND a.id_usuario = l_id_solicitante;
    
      l_rsp.lugar := 'Registrando suscripciones para usuario en el grupo';
      k_usuario.p_suscribir_notificacion(l_id_solicitante,
                                         k_dispositivo.f_suscripcion_grupo(l_id_grupo));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_solicitante),
                                               k_dispositivo.f_suscripcion_grupo(l_id_grupo));
    
      l_dato.contenido := to_char(l_id_usuario);
    ELSIF l_respuesta = c_rechazar THEN
      BEGIN
        DELETE t_grupo_usuarios a
         WHERE a.id_grupo = l_id_grupo
           AND a.id_usuario = l_id_solicitante;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE t_grupo_usuarios a
             SET a.estado = 'I' --Inactivo
           WHERE a.id_grupo = l_id_grupo
             AND a.id_usuario = l_id_solicitante;
      END;
    END IF;
  
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
  END;

  FUNCTION solicitar_amistad(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp              y_respuesta;
    l_dato             y_dato;
    l_id_solicitante   t_usuarios.id_usuario%TYPE;
    l_id_solicitado    t_usuarios.id_usuario%TYPE;
    l_solicitado       t_usuarios.alias%TYPE;
    l_token_aceptacion t_amigos.token_aceptacion%TYPE;
    l_existe_amistad   VARCHAR2(1) := 'N';
    l_id_amistad       t_amigos.id_amistad%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar      := 'Obteniendo variables del sistema';
    l_id_solicitante := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
  
    l_rsp.lugar     := 'Obteniendo parametros';
    l_solicitado    := k_operacion.f_valor_parametro_string(i_parametros,
                                                            'usuario_solicitado');
    l_id_solicitado := k_usuario.f_buscar_id(l_solicitado);
    IF l_id_solicitado IS NULL THEN
      $if k_modulo.c_instalado_msj $then
      IF k_mensajeria.f_validar_direccion_correo(l_solicitado) THEN
        l_rsp.lugar := 'Realizando invitación, si es correo electrónico no catastrado.';
        BEGIN
          lp_realizar_invitacion(i_id_usuario       => l_id_solicitante,
                                 i_direccion_correo => l_solicitado);
        
          k_operacion.p_respuesta_error(l_rsp, 'fan0000003');
          RAISE k_operacion.ex_error_general;
        EXCEPTION
          WHEN dup_val_on_index THEN
            NULL;
        END;
      END IF;
      $end
      k_operacion.p_respuesta_error(l_rsp, 'fan0000008');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    IF k_sistema.f_valor_parametro_string(k_sistema.c_usuario) =
       l_solicitado THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000009');
      RAISE k_operacion.ex_error_general;
    END IF;
  
    BEGIN
      SELECT decode(nvl(COUNT(1), 0), 0, 'N', 'S')
        INTO l_existe_amistad
        FROM t_amigos a
       WHERE a.id_usuario_solicitante = l_id_solicitado
         AND a.id_usuario_solicitado = l_id_solicitante;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000006',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
    IF l_existe_amistad = 'S' THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000007');
      RAISE k_operacion.ex_error_general;
    END IF;
    --TODO: Agregar otras validaciones si es necesario
  
    l_rsp.lugar := 'Registrando solicitud de amistad';
    BEGIN
      INSERT INTO t_amigos a
        (id_usuario_solicitante,
         id_usuario_solicitado,
         token_aceptacion,
         aceptado,
         fecha_creacion)
      VALUES
        (l_id_solicitante,
         l_id_solicitado,
         k_autenticacion.f_randombytes_base64,
         'N',
         current_timestamp)
      RETURNING id_amistad, token_aceptacion INTO l_id_amistad, l_token_aceptacion;
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000007');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000006',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
    l_rsp.lugar := 'Registrando suscripciones de la amistad para usuario';
    IF l_id_amistad IS NOT NULL THEN
      k_usuario.p_suscribir_notificacion(l_id_solicitante,
                                         k_dispositivo.f_suscripcion_amistad(l_id_amistad));
      k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_solicitante),
                                               k_dispositivo.f_suscripcion_amistad(l_id_amistad));
    END IF;
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Enviando mensajería';
    IF k_mensajeria.f_enviar_mensaje(l_token_aceptacion, l_id_solicitado) <>
       k_mensajeria.c_ok THEN
      NULL;
      -- k_operacion.p_respuesta_error(l_rsp, 'fan0008', 'Error al solicitar amistad');
      -- RAISE k_operacion.ex_error_general;
    END IF;
    $end
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Registrando notificacion';
    DECLARE
      l_json_object json_object_t;
      l_result      PLS_INTEGER;
    BEGIN
      l_json_object := NEW json_object_t();
      l_json_object.put('tipo', 'SOLICITUD_AMISTAD'); --TODO: convertir a constante
      l_json_object.put('identificador',
                        k_sistema.f_valor_parametro_string(k_sistema.c_usuario));
    
      l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => 'Solicitud de amistad',
                                                     i_contenido   => k_sistema.f_valor_parametro_string(k_sistema.c_usuario) ||
                                                                      ' te envió una solicitud de amistad',
                                                     i_datos_extra => l_json_object.to_clob,
                                                     i_id_usuario  => l_id_solicitado,
                                                     i_suscripcion => 'ESPECIAL'); --TODO: convertir a constante
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    $end
  
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
  END;

  FUNCTION responder_solicitud_amistad(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    c_aceptar  CONSTANT VARCHAR2(8) := 'ACEPTAR';
    c_rechazar CONSTANT VARCHAR2(8) := 'RECHAZAR';
  
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_id_usuario  t_usuarios.id_usuario%TYPE;
    l_usuario     t_usuarios.alias%TYPE;
    l_solicitante t_usuarios.alias%TYPE;
    l_id_amistad  t_amigos.id_amistad%TYPE;
    l_respuesta   VARCHAR2(8);
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar  := 'Obteniendo variables del sistema';
    l_usuario    := k_sistema.f_valor_parametro_string(k_sistema.c_usuario);
    l_id_usuario := k_usuario.f_id_usuario(l_usuario);
  
    l_rsp.lugar   := 'Obteniendo parámetros';
    l_solicitante := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'usuario_solicitante');
    l_respuesta   := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'respuesta');
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_solicitante IS NOT NULL,
                                    'Debe ingresar usuario solicitante');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IS NOT NULL,
                                    'Debe ingresar respuesta');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_respuesta IN (c_aceptar, c_rechazar),
                                    'Valores posibles de respuesta: ' || '[' ||
                                    c_aceptar || '], [' || c_rechazar || ']');
    --TODO: Agregar otras validaciones si es necesario
  
    l_rsp.lugar := 'Respondiendo solicitud de amistad';
    IF l_respuesta = c_aceptar THEN
      UPDATE t_amigos a
         SET a.aceptado = 'S', a.fecha_aceptacion = current_timestamp
       WHERE a.id_usuario_solicitante =
             k_usuario.f_id_usuario(l_solicitante)
         AND a.id_usuario_solicitado = l_id_usuario
      RETURNING a.id_amistad INTO l_id_amistad;
    
      l_rsp.lugar := 'Registrando suscripciones de la amistad para usuario solicitado';
      IF l_id_amistad IS NOT NULL THEN
        k_usuario.p_suscribir_notificacion(l_id_usuario,
                                           k_dispositivo.f_suscripcion_amistad(l_id_amistad));
        k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario),
                                                 k_dispositivo.f_suscripcion_amistad(l_id_amistad));
      END IF;
    ELSIF l_respuesta = c_rechazar THEN
      DELETE t_amigos a
       WHERE a.id_usuario_solicitante =
             k_usuario.f_id_usuario(l_solicitante)
         AND a.id_usuario_solicitado = l_id_usuario
      RETURNING a.id_amistad INTO l_id_amistad;
    
      IF l_id_amistad IS NOT NULL THEN
        l_rsp.lugar := 'Eliminar suscripciones de la amistad para usuario solicitante';
        k_usuario.p_desuscribir_notificacion(k_usuario.f_id_usuario(l_solicitante),
                                             k_dispositivo.f_suscripcion_amistad(l_id_amistad));
        k_dispositivo.p_desuscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(k_usuario.f_id_usuario(l_solicitante)),
                                                   k_dispositivo.f_suscripcion_amistad(l_id_amistad));
      
      END IF;
    END IF;
  
    IF l_id_amistad IS NULL THEN
      k_operacion.p_respuesta_error(l_rsp, 'fan0000004');
      RAISE k_operacion.ex_error_general;
    END IF;
  
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
  END;

  FUNCTION listar_amigos(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
  
    l_usuario  t_usuarios.alias%TYPE;
    l_tipo     VARCHAR2(12);
    l_aceptado t_amigos.aceptado%TYPE;
  
  BEGIN
    -- Inicializa respuesta
    l_rsp    := NEW y_respuesta();
    l_pagina := NEW y_pagina();
  
    -- Recibe parámetros
    l_usuario  := k_operacion.f_valor_parametro_string(i_parametros,
                                                       'usuario');
    l_tipo     := k_operacion.f_valor_parametro_string(i_parametros, 'tipo');
    l_aceptado := k_operacion.f_valor_parametro_string(i_parametros,
                                                       'aceptado');
  
    --TODO: Agregar otras validaciones si es necesario
  
    l_objetos := k_usuario.f_amigos_usuario(k_usuario.f_id_usuario(l_usuario),
                                            l_tipo,
                                            l_aceptado);
  
    l_pagina.numero_actual      := 0;
    l_pagina.numero_siguiente   := 0;
    l_pagina.numero_ultima      := 0;
    l_pagina.numero_primera     := 0;
    l_pagina.numero_anterior    := 0;
    l_pagina.cantidad_elementos := l_objetos.count;
    l_pagina.elementos          := l_objetos;
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  FUNCTION realizar_comentario(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp            y_respuesta;
    l_dato           y_dato;
    l_id_usuario     t_usuarios.id_usuario%TYPE;
    l_tipo           t_comentarios.tipo%TYPE;
    l_referencia     t_comentarios.referencia%TYPE;
    l_contenido      t_comentarios.contenido%TYPE;
    l_ref_comentario t_comentarios.ref_comentario%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario     := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_tipo           := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'tipo');
    l_referencia     := k_operacion.f_valor_parametro_number(i_parametros,
                                                             'referencia');
    l_contenido      := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'contenido');
    l_ref_comentario := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'ref_comentario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_tipo IS NOT NULL,
                                    'Debe ingresar tipo de comentario');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_referencia IS NOT NULL,
                                    'Debe ingresar referencia del comentario');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_contenido IS NOT NULL,
                                    'Debe ingresar contenido del comentario');
  
    l_rsp.lugar := 'Registrando comentario';
    BEGIN
      INSERT INTO t_comentarios a
        (tipo, referencia, id_usuario, contenido, ref_comentario)
      VALUES
        (l_tipo, l_referencia, l_id_usuario, l_contenido, l_ref_comentario);
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000015');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000016');
        RAISE k_operacion.ex_error_general;
    END;
  
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
  END;

  FUNCTION reaccionar(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp            y_respuesta;
    l_dato           y_dato;
    l_id_usuario     t_usuarios.id_usuario%TYPE;
    l_tipo           t_reacciones.tipo%TYPE;
    l_referencia     t_reacciones.referencia%TYPE;
    l_reaccion       t_reacciones.reaccion%TYPE;
    l_ref_comentario t_reacciones.ref_comentario%TYPE;
    l_reaccionado    VARCHAR(1) := 'N';
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario     := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_tipo           := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'tipo');
    l_referencia     := k_operacion.f_valor_parametro_number(i_parametros,
                                                             'referencia');
    l_reaccion       := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'reaccion');
    l_ref_comentario := k_operacion.f_valor_parametro_string(i_parametros,
                                                             'ref_comentario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_tipo IS NOT NULL,
                                    'Debe ingresar tipo de reaccion');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_referencia IS NOT NULL,
                                    'Debe ingresar referencia de la reaccion');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_reaccion IS NOT NULL,
                                    'Debe ingresar reaccion');
  
    l_rsp.lugar := 'Registrando reaccion';
    BEGIN
      SELECT decode(nvl(COUNT(1), 0), 0, 'N', 'S')
        INTO l_reaccionado
        FROM t_reacciones a
       WHERE a.tipo = l_tipo
         AND a.referencia = l_referencia
         AND a.id_usuario = l_id_usuario
         AND nvl(a.ref_comentario, -1) = nvl(l_ref_comentario, -1)
         AND a.reaccion = l_reaccion;
    
      IF l_reaccionado = 'S' THEN
        --Si ya tiene una reaccion identica, entonces la elimina
        DELETE t_reacciones a
         WHERE a.tipo = l_tipo
           AND a.referencia = l_referencia
           AND a.id_usuario = l_id_usuario
           AND nvl(a.ref_comentario, -1) = nvl(l_ref_comentario, -1)
           AND a.reaccion = l_reaccion;
      ELSE
        --Caso contrario, la actualiza o la inserta
        UPDATE t_reacciones a
           SET a.reaccion = l_reaccion
         WHERE a.tipo = l_tipo
           AND a.referencia = l_referencia
           AND a.id_usuario = l_id_usuario
           AND nvl(a.ref_comentario, -1) = nvl(l_ref_comentario, -1);
      
        IF SQL%NOTFOUND THEN
          INSERT INTO t_reacciones a
            (tipo, referencia, id_usuario, reaccion, ref_comentario)
          VALUES
            (l_tipo,
             l_referencia,
             l_id_usuario,
             l_reaccion,
             l_ref_comentario);
        END IF;
      END IF;
    
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000017');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000018',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
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
  END;

  FUNCTION enviar_mensaje_grupo(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp         y_respuesta;
    l_dato        y_dato;
    l_id_usuario  t_usuarios.id_usuario%TYPE;
    l_id_grupo    t_grupos.id_grupo%TYPE;
    l_contenido   t_grupo_mensajes.contenido%TYPE;
    l_ref_mensaje t_grupo_mensajes.ref_mensaje%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario  := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_id_grupo    := k_operacion.f_valor_parametro_number(i_parametros,
                                                          'id_grupo');
    l_contenido   := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'contenido');
    l_ref_mensaje := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'ref_mensaje');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_grupo IS NOT NULL,
                                    'Debe ingresar identificador del grupo');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_contenido IS NOT NULL,
                                    'Debe ingresar contenido del mensaje');
    /* TODO: text="Validar que el usuario forme parte del grupo y esté Activo" */
  
    l_rsp.lugar := 'Registrando mensaje';
    BEGIN
      INSERT INTO t_grupo_mensajes a
        (id_grupo, id_usuario, contenido, ref_mensaje)
      VALUES
        (l_id_grupo, l_id_usuario, l_contenido, l_ref_mensaje);
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000019');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000020',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Registrando notificacion';
    DECLARE
      l_json_object json_object_t;
      l_result      PLS_INTEGER;
      l_grupo       y_grupo := lf_datos_grupo(l_id_grupo);
    BEGIN
      l_json_object := NEW json_object_t();
      l_json_object.put('tipo', 'GRUPO'); --TODO: convertir a constante
      l_json_object.put('id_grupo', to_char(l_id_grupo));
      l_json_object.put('nombre_grupo', l_grupo.descripcion);
      l_json_object.put('usuario', k_usuario.f_alias(l_id_usuario));
      l_json_object.put('mensaje', l_contenido);
    
      l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => NULL,
                                                     i_contenido   => NULL,
                                                     i_datos_extra => l_json_object.to_clob,
                                                     i_suscripcion => 'MENSAJERIA' || '&&' || --TODO: convertir a constante
                                                                      k_dispositivo.c_suscripcion_grupo || '_' ||
                                                                      l_id_grupo || '&&' || '!' ||
                                                                      k_dispositivo.c_suscripcion_usuario || '_' ||
                                                                      l_id_usuario);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    $end
  
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
  END;

  FUNCTION enviar_mensaje_amigo(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp         y_respuesta;
    l_dato        y_dato;
    l_id_usuario  t_usuarios.id_usuario%TYPE;
    l_id_amistad  t_amigos.id_amistad%TYPE;
    l_contenido   t_amigo_mensajes.contenido%TYPE;
    l_ref_mensaje t_amigo_mensajes.ref_mensaje%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario  := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_id_amistad  := k_operacion.f_valor_parametro_number(i_parametros,
                                                          'id_amistad');
    l_contenido   := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'contenido');
    l_ref_mensaje := k_operacion.f_valor_parametro_string(i_parametros,
                                                          'ref_mensaje');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_amistad IS NOT NULL,
                                    'Debe ingresar identificador de la amistad');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_contenido IS NOT NULL,
                                    'Debe ingresar contenido del mensaje');
    /* TODO: text="Validar que el usuario sea amigo y esté Activo" */
  
    l_rsp.lugar := 'Registrando mensaje';
    BEGIN
      INSERT INTO t_amigo_mensajes a
        (id_amistad, id_usuario, contenido, ref_mensaje)
      VALUES
        (l_id_amistad, l_id_usuario, l_contenido, l_ref_mensaje);
    EXCEPTION
      WHEN dup_val_on_index THEN
        k_operacion.p_respuesta_error(l_rsp, 'fan0000019');
        RAISE k_operacion.ex_error_general;
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000020',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Registrando notificacion';
    DECLARE
      l_json_object json_object_t;
      l_result      PLS_INTEGER;
    BEGIN
      l_json_object := NEW json_object_t();
      l_json_object.put('tipo', 'MENSAJE_AMISTAD'); --TODO: convertir a constante
      l_json_object.put('id_amistad', to_char(l_id_amistad));
      l_json_object.put('usuario', k_usuario.f_alias(l_id_usuario));
      l_json_object.put('mensaje', l_contenido);
    
      l_result := k_mensajeria.f_enviar_notificacion(i_titulo      => NULL,
                                                     i_contenido   => NULL,
                                                     i_datos_extra => l_json_object.to_clob,
                                                     i_suscripcion => 'MENSAJERIA_AMIGO' || '&&' || --TODO: convertir a constante
                                                                      k_dispositivo.c_suscripcion_amistad || '_' ||
                                                                      l_id_amistad || '&&' || '!' ||
                                                                      k_dispositivo.c_suscripcion_usuario || '_' ||
                                                                      l_id_usuario);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    $end
  
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
  END;

  FUNCTION suscribir(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp        y_respuesta;
    l_dato       y_dato;
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_tipo       t_reacciones.tipo%TYPE;
    l_referencia VARCHAR(20);
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_tipo       := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'tipo');
    l_referencia := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'referencia');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_tipo IS NOT NULL,
                                    'Debe ingresar tipo de suscripción');
    k_operacion.p_validar_parametro(l_rsp,
                                    l_referencia IS NOT NULL,
                                    'Debe ingresar referencia de la suscripción');
  
    l_rsp.lugar := 'Registrando suscripción';
    BEGIN
      IF l_tipo = 'D' THEN
        --División
        DECLARE
          l_suscripcion t_usuario_suscripciones.suscripcion%TYPE;
        BEGIN
          l_suscripcion := k_dispositivo.f_suscripcion_division(l_referencia);
          IF k_usuario.f_suscripto_notificacion(l_id_usuario, l_suscripcion) = 'S' THEN
            --Si ya está suscripto, desuscribe
            k_usuario.p_desuscribir_notificacion(l_id_usuario,
                                                 l_suscripcion);
            k_dispositivo.p_desuscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario),
                                                       l_suscripcion);
          ELSE
            --Caso contrario, suscribe
            k_usuario.p_suscribir_notificacion(l_id_usuario, l_suscripcion);
            k_dispositivo.p_suscribir_notificacion_s(k_dispositivo.f_suscripcion_usuario(l_id_usuario),
                                                     l_suscripcion);
          END IF;
        END;
      END IF;
    
    EXCEPTION
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000022',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
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
  END;

  FUNCTION seguir_division(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp        y_respuesta;
    l_dato       y_dato;
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_division   t_divisiones.id_division%TYPE;
    l_siguiendo  VARCHAR(1) := 'N';
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    -- Recibe parámetros
    l_id_usuario := k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario);
    l_division   := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'id_division');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_division IS NOT NULL,
                                    'Debe ingresar la division');
  
    l_rsp.lugar := 'Registrando seguimiento';
    BEGIN
      SELECT decode(nvl(COUNT(1), 0), 0, 'N', 'S')
        INTO l_siguiendo
        FROM t_usuario_divisiones a
       WHERE a.id_usuario = l_id_usuario
         AND a.id_division = l_division;
    
      IF l_siguiendo = 'S' THEN
        --Si ya está siguiendo, entonces deja de seguir
        DELETE t_usuario_divisiones a
         WHERE a.id_usuario = l_id_usuario
           AND a.id_division = l_division;
      ELSE
        --Caso contrario, empieza a seguir
        INSERT INTO t_usuario_divisiones a
          (id_usuario, id_division)
        VALUES
          (l_id_usuario, l_division);
      END IF;
    
    EXCEPTION
      WHEN OTHERS THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      'fan0000021',
                                      NULL,
                                      dbms_utility.format_error_stack);
        RAISE k_operacion.ex_error_general;
    END;
  
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
  END;

END;
/
