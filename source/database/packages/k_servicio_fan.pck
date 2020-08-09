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

  FUNCTION realizar_prediccion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION registrar_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION editar_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION datos_grupo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION listar_grupos(i_parametros IN y_parametros) RETURN y_respuesta;

END;
/
CREATE OR REPLACE PACKAGE BODY k_servicio_fan IS

  FUNCTION lf_datos_grupo(i_id_grupo IN NUMBER) RETURN y_grupo IS
    l_grupo    y_grupo;
    l_usuarios y_objetos;
    l_usuario  y_grupo_usuario;
  
    CURSOR cr_usuarios(i_id_grupo IN NUMBER) IS
      SELECT a.id_grupo,
             a.id_usuario,
             a.puntos,
             a.ranking,
             a.estado,
             a.token_activacion,
             a.aceptado
        FROM t_grupo_usuarios a
       WHERE a.id_grupo = i_id_grupo;
  BEGIN
    -- Inicializa respuesta
    l_grupo    := NEW y_grupo();
    l_usuarios := NEW y_objetos();
  
    -- Busca datos del grupo
    BEGIN
      SELECT a.id_grupo,
             a.id_torneo,
             a.descripcion,
             a.tipo,
             a.id_usuario_administrador,
             a.fecha_creacion,
             a.id_jornada_inicio,
             a.estado,
             a.situacion,
             a.id_club,
             a.todos_invitan
        INTO l_grupo.id_grupo,
             l_grupo.id_torneo,
             l_grupo.descripcion,
             l_grupo.tipo,
             l_grupo.id_usuario_administrador,
             l_grupo.fecha_creacion,
             l_grupo.id_jornada_inicio,
             l_grupo.estado,
             l_grupo.situacion,
             l_grupo.id_club,
             l_grupo.todos_invitan
        FROM t_grupos a
       WHERE a.id_grupo = i_id_grupo;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20000, 'Grupo inexistente');
      WHEN OTHERS THEN
        raise_application_error(-20000, 'Error al buscar datos del grupo');
    END;
  
    -- Busca usuarios del grupo
    FOR c IN cr_usuarios(l_grupo.id_grupo) LOOP
      l_usuario                  := NEW y_grupo_usuario();
      l_usuario.id_usuario       := c.id_usuario;
      l_usuario.puntos           := c.puntos;
      l_usuario.ranking          := c.ranking;
      l_usuario.estado           := c.estado;
      l_usuario.token_activacion := c.token_activacion;
      l_usuario.aceptado         := c.aceptado;
    
      l_usuarios.extend;
      l_usuarios(l_usuarios.count) := l_usuario;
    END LOOP;
    l_grupo.usuarios := l_usuarios;
  
    RETURN l_grupo;
  END;

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

  FUNCTION listar_partidos(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_partido;
  
    l_id_partido t_partidos.id_partido%TYPE;
    l_id_torneo  t_partidos.id_torneo%TYPE;
    l_estado     t_partidos.estado%TYPE;
  
    CURSOR cr_elementos(i_id_partido IN VARCHAR2,
                        i_id_torneo  IN VARCHAR2,
                        i_estado     IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             c.fecha,
             c.hora,
             c.id_jornada,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado
        FROM t_partidos c
       WHERE c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND c.estado = nvl(i_estado, c.estado);
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_partido := k_servicio.f_valor_parametro_number(i_parametros,
                                                        'partido');
    l_id_torneo  := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'torneo');
    l_estado     := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'estado');
  
    FOR ele IN cr_elementos(l_id_partido, l_id_torneo, l_estado) LOOP
      l_objeto                   := NEW y_partido();
      l_objeto.id_partido        := ele.id_partido;
      l_objeto.id_torneo         := ele.id_torneo;
      l_objeto.id_club_local     := ele.id_club_local;
      l_objeto.id_club_visitante := ele.id_club_visitante;
      l_objeto.fecha             := ele.fecha;
      l_objeto.hora              := ele.hora;
      l_objeto.id_jornada        := ele.id_jornada;
      l_objeto.id_estadio        := ele.id_estadio;
      l_objeto.goles_local       := ele.goles_club_local;
      l_objeto.goles_visitante   := ele.goles_club_visitante;
      l_objeto.estado            := ele.estado;
    
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

  FUNCTION listar_predicciones_partidos(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp     y_respuesta;
    l_pagina  y_pagina;
    l_objetos y_objetos;
    l_objeto  y_partido_prediccion;
  
    l_id_partido t_partidos.id_partido%TYPE;
    l_id_torneo  t_partidos.id_torneo%TYPE;
    l_estado     t_partidos.estado%TYPE;
    l_usuario    t_usuarios.alias%TYPE;
  
    CURSOR cr_elementos(i_id_partido IN VARCHAR2,
                        i_id_torneo  IN VARCHAR2,
                        i_estado     IN VARCHAR2,
                        i_usuario    IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             c.fecha,
             c.hora,
             c.id_jornada,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado,
             p.goles_club_local predic_goles_local,
             p.goles_club_visitante predic_goles_visitante,
             p.puntos,
             p.id_sincronizacion
        FROM t_partidos c, t_predicciones p
       WHERE c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND c.estado = nvl(i_estado, c.estado)
         AND c.id_partido = p.id_partido(+)
         AND p.id_usuario(+) = i_usuario;
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_partido := k_servicio.f_valor_parametro_number(i_parametros,
                                                        'partido');
    l_id_torneo  := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'torneo');
    l_estado     := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'estado');
    l_usuario    := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'usuario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_servicio.p_validar_parametro(l_rsp,
                                   l_usuario IS NOT NULL,
                                   'Debe ingresar usuario');
  
    FOR ele IN cr_elementos(l_id_partido,
                            l_id_torneo,
                            l_estado,
                            k_autenticacion.f_id_usuario(l_usuario)) LOOP
      l_objeto                   := NEW y_partido_prediccion();
      l_objeto.id_partido        := ele.id_partido;
      l_objeto.id_torneo         := ele.id_torneo;
      l_objeto.id_club_local     := ele.id_club_local;
      l_objeto.id_club_visitante := ele.id_club_visitante;
      l_objeto.fecha             := ele.fecha;
      l_objeto.hora              := ele.hora;
      l_objeto.id_jornada        := ele.id_jornada;
      l_objeto.id_estadio        := ele.id_estadio;
      l_objeto.goles_local       := ele.goles_club_local;
      l_objeto.goles_visitante   := ele.goles_club_visitante;
      l_objeto.estado            := ele.estado;
    
      l_objeto.predic_goles_local     := ele.predic_goles_local;
      l_objeto.predic_goles_visitante := ele.predic_goles_visitante;
      l_objeto.puntos                 := ele.puntos;
      l_objeto.sincronizacion         := ele.id_sincronizacion;
    
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

  FUNCTION listar_jornadas(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp      y_respuesta;
    l_pagina   y_pagina;
    l_objetos  y_objetos;
    l_objeto   y_jornada;
    l_partidos y_partidos;
    l_partido  y_partido_prediccion;
  
    l_id_torneo  t_torneo_jornadas.id_torneo%TYPE;
    l_id_jornada t_torneo_jornadas.id_jornada%TYPE;
    l_estado     t_partidos.estado%TYPE;
    l_usuario    t_usuarios.alias%TYPE;
  
    CURSOR cr_jornadas(i_id_torneo  IN VARCHAR2,
                       i_id_jornada IN NUMBER,
                       i_estado     IN VARCHAR2) IS
      SELECT j.id_torneo,
             j.id_jornada,
             j.titulo,
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
  
    CURSOR cr_partidos(i_id_torneo  IN VARCHAR2,
                       i_id_jornada IN NUMBER,
                       i_id_partido IN VARCHAR2,
                       i_estado     IN VARCHAR2,
                       i_usuario    IN VARCHAR2) IS
      SELECT c.id_partido,
             c.id_torneo,
             c.id_club_local,
             c.id_club_visitante,
             c.fecha,
             c.hora,
             c.id_jornada,
             c.id_estadio,
             c.goles_club_local,
             c.goles_club_visitante,
             k_util.f_significado_codigo('ESTADO_PARTIDO', c.estado) estado,
             p.goles_club_local predic_goles_local,
             p.goles_club_visitante predic_goles_visitante,
             p.puntos,
             p.id_sincronizacion
        FROM t_partidos c, t_predicciones p
       WHERE c.id_partido = nvl(i_id_partido, c.id_partido)
         AND c.id_torneo = nvl(i_id_torneo, c.id_torneo)
         AND c.id_jornada = nvl(i_id_jornada, c.id_jornada)
         AND c.estado = nvl(i_estado, c.estado)
         AND c.id_partido = p.id_partido(+)
         AND p.id_usuario(+) = i_usuario;
  BEGIN
    -- Inicializa respuesta
    l_rsp     := NEW y_respuesta();
    l_pagina  := NEW y_pagina();
    l_objetos := NEW y_objetos();
  
    -- Recibe parámetros
    l_id_torneo  := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'torneo');
    l_id_jornada := k_servicio.f_valor_parametro_number(i_parametros,
                                                        'jornada');
    l_estado     := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'estado');
    l_usuario    := k_servicio.f_valor_parametro_string(i_parametros,
                                                        'usuario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_servicio.p_validar_parametro(l_rsp,
                                   l_id_torneo IS NOT NULL,
                                   'Debe ingresar torneo');
  
    FOR ele IN cr_jornadas(l_id_torneo,
                           l_id_jornada,
                           l_estado /*,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       k_autenticacion.f_id_usuario(l_usuario)*/) LOOP
      l_objeto            := NEW y_jornada();
      l_partidos          := NEW y_partidos();
      l_objeto.id_torneo  := ele.id_torneo;
      l_objeto.id_jornada := ele.id_jornada;
      l_objeto.titulo     := ele.titulo;
      l_objeto.estado     := ele.estado;
    
      FOR p IN cr_partidos(ele.id_torneo,
                           ele.id_jornada,
                           NULL,
                           NULL,
                           k_autenticacion.f_id_usuario(l_usuario)) LOOP
        l_partido                   := NEW y_partido_prediccion();
        l_partido.id_partido        := p.id_partido;
        l_partido.id_torneo         := p.id_torneo;
        l_partido.id_club_local     := p.id_club_local;
        l_partido.id_club_visitante := p.id_club_visitante;
        l_partido.fecha             := p.fecha;
        l_partido.hora              := p.hora;
        l_partido.id_jornada        := p.id_jornada;
        l_partido.id_estadio        := p.id_estadio;
        l_partido.goles_local       := p.goles_club_local;
        l_partido.goles_visitante   := p.goles_club_visitante;
        l_partido.estado            := p.estado;
      
        l_partido.predic_goles_local     := p.predic_goles_local;
        l_partido.predic_goles_visitante := p.predic_goles_visitante;
        l_partido.puntos                 := p.puntos;
        l_partido.sincronizacion         := p.id_sincronizacion;
      
        l_partidos.extend;
        l_partidos(l_partidos.count) := l_partido;
      END LOOP;
    
      l_objeto.partidos := l_partidos;
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

  FUNCTION realizar_prediccion(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp  y_respuesta;
    l_dato y_dato;
  
    l_partido t_partidos.id_partido%TYPE;
    l_usuario t_usuarios.alias%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp  := NEW y_respuesta();
    l_dato := NEW y_dato();
  
    l_rsp.lugar := 'Obteniendo parámetros';
    l_partido   := k_servicio.f_valor_parametro_number(i_parametros,
                                                       'partido');
    l_usuario   := k_servicio.f_valor_parametro_string(i_parametros,
                                                       'usuario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_servicio.p_validar_parametro(l_rsp,
                                   l_partido IS NOT NULL,
                                   'Debe ingresar partido');
    k_servicio.p_validar_parametro(l_rsp,
                                   l_usuario IS NOT NULL,
                                   'Debe ingresar usuario');
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_number(i_parametros,
                                                                       'goles_club_local') IS NOT NULL,
                                   'Debe ingresar goles_club_local');
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_number(i_parametros,
                                                                       'goles_club_visitante') IS NOT NULL,
                                   'Debe ingresar goles_club_visitante');
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_number(i_parametros,
                                                                       'id_sincronizacion') IS NOT NULL,
                                   'Debe ingresar id_sincronizacion');
    /* TODO: text="Validar que el estado del partido y que el usuario exista" */
  
    l_rsp.lugar := 'Realizando prediccion';
    MERGE INTO t_predicciones d
    USING (SELECT l_partido id_partido,
                  k_autenticacion.f_id_usuario(l_usuario) id_usuario,
                  k_servicio.f_valor_parametro_number(i_parametros,
                                                      'goles_club_local') goles_club_local,
                  k_servicio.f_valor_parametro_number(i_parametros,
                                                      'goles_club_visitante') goles_club_visitante,
                  k_servicio.f_valor_parametro_number(i_parametros,
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
  
    k_servicio.p_respuesta_ok(l_rsp, l_dato);
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

  FUNCTION registrar_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp                      y_respuesta;
    l_grupo                    y_grupo;
    l_id_usuario_administrador t_usuarios.id_usuario%TYPE;
    l_id_grupo                 t_grupos.id_grupo%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_string(i_parametros,
                                                                       'tipo') IN
                                   ('GLO', 'PRI', 'PUB'),
                                   'Tipo de grupo incorrecto');
  
    -- Busca usuario
    l_id_usuario_administrador := k_autenticacion.f_id_usuario(k_sistema.f_valor_parametro_string(k_sistema.c_usuario));
  
    l_rsp.lugar := 'Registrando grupo';
    INSERT INTO t_grupos
      (id_torneo,
       descripcion,
       tipo,
       id_usuario_administrador,
       fecha_creacion,
       id_jornada_inicio,
       estado,
       situacion,
       id_club,
       todos_invitan)
    VALUES
      ('PRI-APE20',
       k_servicio.f_valor_parametro_string(i_parametros, 'descripcion'),
       k_servicio.f_valor_parametro_string(i_parametros, 'tipo'),
       l_id_usuario_administrador,
       SYSDATE,
       k_servicio.f_valor_parametro_number(i_parametros,
                                           'id_jornada_inicio'),
       'A',
       'A',
       k_servicio.f_valor_parametro_string(i_parametros, 'id_club'),
       k_servicio.f_valor_parametro_string(i_parametros, 'todos_invitan'))
    RETURNING id_grupo INTO l_id_grupo;
  
    IF l_id_usuario_administrador IS NOT NULL THEN
      l_rsp.lugar := 'Registrando usuario administrador en el grupo';
      INSERT INTO t_grupo_usuarios
        (id_grupo,
         id_usuario,
         puntos,
         ranking,
         estado,
         token_activacion,
         aceptado)
      VALUES
        (l_id_grupo,
         l_id_usuario_administrador,
         NULL,
         NULL,
         'A',
         NULL,
         NULL);
    END IF;
  
    l_rsp.lugar := 'Cargando datos del grupo';
    l_grupo     := lf_datos_grupo(l_id_grupo);
  
    k_servicio.p_respuesta_ok(l_rsp, l_grupo);
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

  FUNCTION editar_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp                      y_respuesta;
    l_id_usuario_administrador t_usuarios.id_usuario%TYPE;
    l_tipo                     t_grupos.tipo%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_string(i_parametros,
                                                                       'tipo') IN
                                   ('GLO', 'PRI', 'PUB'),
                                   'Tipo de grupo incorrecto');
  
    l_rsp.lugar := 'Buscando datos del grupo';
    BEGIN
      SELECT a.tipo, a.id_usuario_administrador
        INTO l_tipo, l_id_usuario_administrador
        FROM t_grupos a
       WHERE a.id_grupo =
             k_servicio.f_valor_parametro_number(i_parametros, 'id_grupo');
    EXCEPTION
      WHEN no_data_found THEN
        k_servicio.p_respuesta_error(l_rsp, 'fan0001', 'Grupo inexistente');
        RAISE k_servicio.ex_error_general;
      WHEN OTHERS THEN
        k_servicio.p_respuesta_error(l_rsp,
                                     'fan0002',
                                     'Error al buscar grupo');
        RAISE k_servicio.ex_error_general;
    END;
  
    -- Valida tipo
    IF l_tipo <> 'PRI' THEN
      k_servicio.p_respuesta_error(l_rsp,
                                   'fan0003',
                                   'Sólo los grupos privados se pueden editar');
      RAISE k_servicio.ex_error_general;
    END IF;
  
    -- Valida usuario administrador
    IF k_autenticacion.f_id_usuario(k_sistema.f_valor_parametro_string(k_sistema.c_usuario)) <>
       l_id_usuario_administrador THEN
      k_servicio.p_respuesta_error(l_rsp,
                                   'fan0004',
                                   'Sólo el administrador puede editar los datos del grupo');
      RAISE k_servicio.ex_error_general;
    END IF;
  
    l_rsp.lugar := 'Editando grupo';
    UPDATE t_grupos a
       SET a.descripcion       = k_servicio.f_valor_parametro_string(i_parametros,
                                                                     'descripcion'),
           a.tipo              = k_servicio.f_valor_parametro_string(i_parametros,
                                                                     'tipo'),
           a.id_jornada_inicio = k_servicio.f_valor_parametro_number(i_parametros,
                                                                     'id_jornada_inicio'),
           a.id_club           = k_servicio.f_valor_parametro_string(i_parametros,
                                                                     'id_club'),
           a.todos_invitan     = k_servicio.f_valor_parametro_string(i_parametros,
                                                                     'todos_invitan')
     WHERE a.id_grupo =
           k_servicio.f_valor_parametro_number(i_parametros, 'id_grupo');
  
    k_servicio.p_respuesta_ok(l_rsp);
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

  FUNCTION datos_grupo(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp   y_respuesta;
    l_grupo y_grupo;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_number(i_parametros,
                                                                       'id_grupo') IS NOT NULL,
                                   'Debe ingresar id_grupo');
  
    l_rsp.lugar := 'Cargando datos del grupo';
    l_grupo     := lf_datos_grupo(k_servicio.f_valor_parametro_number(i_parametros,
                                                                      'id_grupo'));
  
    k_servicio.p_respuesta_ok(l_rsp, l_grupo);
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

  FUNCTION listar_grupos(i_parametros IN y_parametros) RETURN y_respuesta IS
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_grupo;
  
    l_pagina_parametros y_pagina_parametros;
  
    CURSOR cr_elementos(i_tipo       IN VARCHAR2,
                        i_mis_grupos IN VARCHAR2) IS
      SELECT a.id_grupo
        FROM t_grupos a
       WHERE a.tipo = nvl(i_tipo, a.tipo)
         AND ((i_mis_grupos = 'S' AND EXISTS
              (SELECT 1
                  FROM t_grupo_usuarios u
                 WHERE u.id_grupo = a.id_grupo
                   AND u.id_usuario =
                       k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario))) OR
             (i_mis_grupos <> 'S'));
  BEGIN
    -- Inicializa respuesta
    l_rsp       := NEW y_respuesta();
    l_elementos := NEW y_objetos();
  
    l_rsp.lugar := 'Validando parametros';
    k_servicio.p_validar_parametro(l_rsp,
                                   k_servicio.f_valor_parametro_object(i_parametros,
                                                                       'pagina_parametros') IS NOT NULL,
                                   'Debe ingresar pagina_parametros');
    l_pagina_parametros := treat(k_servicio.f_valor_parametro_object(i_parametros,
                                                                     'pagina_parametros') AS
                                 y_pagina_parametros);
  
    FOR ele IN cr_elementos(k_servicio.f_valor_parametro_string(i_parametros,
                                                                'tipo_grupo'),
                            k_servicio.f_valor_parametro_string(i_parametros,
                                                                'mis_grupos')) LOOP
      l_elemento := lf_datos_grupo(ele.id_grupo);
    
      l_elementos.extend;
      l_elementos(l_elementos.count) := l_elemento;
    END LOOP;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               l_pagina_parametros.pagina,
                                               l_pagina_parametros.por_pagina,
                                               l_pagina_parametros.no_paginar);
  
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
