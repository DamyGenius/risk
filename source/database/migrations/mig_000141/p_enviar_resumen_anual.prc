CREATE OR REPLACE PROCEDURE p_enviar_resumen_anual(i_alias IN VARCHAR2,
                                                   i_anio  IN VARCHAR2,
                                                   i_force IN BOOLEAN := FALSE) IS
  l_usuario y_usuario;
  l_nombre  VARCHAR2(100);
  l_result  INTEGER;
  l_asunto  VARCHAR2(100);
  l_cuerpo  CLOB;
  l_enviado VARCHAR2(1) := 'N';

  c_cols_competencias CONSTANT PLS_INTEGER := 3;
  l_rows_competencias PLS_INTEGER;
  l_tab_competencias  CLOB;
  l_tab_torneos       CLOB;

  c_min_pronosticos CONSTANT PLS_INTEGER := 1;
  l_competencias  PLS_INTEGER;
  l_torneos       PLS_INTEGER;
  l_pronosticos   PLS_INTEGER;
  l_aciertos_6pts PLS_INTEGER;
  l_aciertos_3pts PLS_INTEGER;
  l_aciertos_2pts PLS_INTEGER;

  l_ganador_torneo PLS_INTEGER;
  l_ganador_fecha  PLS_INTEGER;
  l_ganador_fase   PLS_INTEGER;

  CURSOR c_competencias IS
    SELECT DISTINCT d.id_division, d.descripcion, d.descripcion_corta
      FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
     WHERE t.id_division = d.id_division
       AND t.id_torneo = p.id_torneo
       AND p.id_partido = r.id_partido
       AND nvl(t.prueba, 'N') = 'N'
       AND t.temporada = i_anio
       AND r.id_usuario = l_usuario.id_usuario;

  CURSOR c_torneos IS
    SELECT d.id_division,
           d.descripcion,
           t.id_torneo,
           t.titulo,
           n.puntos,
           n.ranking,
           (SELECT COUNT(nn.id_usuario)
              FROM t_grupo_torneo_usuarios nn
             WHERE nn.id_grupo = n.id_grupo
               AND nn.id_torneo = n.id_torneo) participantes,
           
           CASE
             WHEN n.ranking = 1 THEN
              'S'
             ELSE
              'N'
           END ganador_torneo
      FROM t_torneos               t,
           t_divisiones            d,
           t_grupo_torneo_usuarios n,
           t_grupos                g,
           t_grupo_torneos         gr
     WHERE t.id_torneo = n.id_torneo
       AND t.id_division = d.id_division
       AND n.id_grupo = g.id_grupo
       AND g.id_grupo = gr.id_grupo
       AND g.tipo = 'GLO'
       AND t.temporada = i_anio
       AND n.id_usuario = l_usuario.id_usuario
          --
       AND gr.id_jornada_inicio IS NULL
       AND gr.id_jornada_fin IS NULL
       AND gr.id_fase_inicio IS NULL
       AND gr.id_fase_fin IS NULL;

  PROCEDURE lp_limpiar_competencias IS
    l_td_limpio CONSTANT VARCHAR2(200) := '<td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&nbsp;</td>';
  BEGIN
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_NOM_COMPETENCIA3',
                                  l_td_limpio);
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_NOM_COMPETENCIA2',
                                  l_td_limpio);
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_NOM_COMPETENCIA1',
                                  l_td_limpio);
  
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_IMG_COMPETENCIA3',
                                  l_td_limpio);
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_IMG_COMPETENCIA2',
                                  l_td_limpio);
    l_tab_competencias := REPLACE(l_tab_competencias,
                                  '&TD_IMG_COMPETENCIA1',
                                  l_td_limpio);
  END;

BEGIN
  -- Seteamos el torneo global
  DECLARE
    l_torneo_defecto t_torneos.id_torneo%TYPE;
  BEGIN
    SELECT a.id_torneo
      INTO l_torneo_defecto
      FROM t_torneos a
     WHERE actual = 'S'
       AND a.id_division = k_util.f_valor_parametro('ID_DIVISION');
  
    k_sistema.p_definir_parametro_string(k_sistema.c_torneo,
                                         nvl(nvl(k_usuario.f_torneo_usuario(i_alias),
                                                 k_util.f_valor_parametro('ID_TORNEO_ESTRELLA')),
                                             l_torneo_defecto));
  END;

  -- Obtenemos datos del usuario
  l_usuario := k_usuario.f_datos_usuario(k_usuario.f_id_usuario(i_alias));
  l_nombre  := k_util.f_formatear_titulo(nvl(l_usuario.nombre,
                                             l_usuario.alias));
  dbms_output.put_line('usuario: ' || l_usuario.json);

  -- Validamos si ya fue enviado para el usuario
  BEGIN
    SELECT decode(nvl(COUNT(*), 0), 0, 'N', 'S')
      INTO l_enviado
      FROM t_correos a
     WHERE a.mensaje_subject LIKE '%tu resumen del ' || i_anio || '%'
       AND a.id_usuario = l_usuario.id_usuario;
  
    IF l_enviado = 'S' AND NOT (i_force) THEN
      RETURN;
    END IF;
  END;

  --Tus pronosticos del año
  --Tus aciertos
  BEGIN
    SELECT nvl(COUNT(DISTINCT d.id_division), 0) competencias,
           nvl(COUNT(DISTINCT t.id_torneo), 0) torneos,
           nvl(COUNT(r.id_partido), 0) pronosticos,
           nvl(SUM(CASE r.puntos
                     WHEN 6 THEN
                      1
                     ELSE
                      0
                   END),
               0) resultado_exacto,
           nvl(SUM(CASE r.puntos
                     WHEN 3 THEN
                      1
                     ELSE
                      0
                   END),
               0) ganador_correcto_diferencia_correcta,
           nvl(SUM(CASE r.puntos
                     WHEN 2 THEN
                      1
                     ELSE
                      0
                   END),
               0) ganador_correcto_empate
      INTO l_competencias,
           l_torneos,
           l_pronosticos,
           l_aciertos_6pts,
           l_aciertos_3pts,
           l_aciertos_2pts
      FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
     WHERE t.id_division = d.id_division
       AND t.id_torneo = p.id_torneo
       AND p.id_partido = r.id_partido
       AND nvl(t.prueba, 'N') = 'N'
       AND t.temporada = i_anio
       AND r.id_usuario = l_usuario.id_usuario;
  
    IF l_pronosticos < c_min_pronosticos THEN
      RETURN;
    END IF;
  END;

  -- Cantidad total de competencias
  BEGIN
    SELECT ceil(COUNT(DISTINCT d.id_division) / c_cols_competencias) filas
      INTO l_rows_competencias
      FROM t_torneos t, t_divisiones d, t_partidos p, t_predicciones r
     WHERE t.id_division = d.id_division
       AND t.id_torneo = p.id_torneo
       AND p.id_partido = r.id_partido
       AND nvl(t.prueba, 'N') = 'N'
       AND t.temporada = i_anio
       AND r.id_usuario = l_usuario.id_usuario;
  END;

  IF l_rows_competencias > 0 THEN
    DECLARE
      l_col_competencias_tmp PLS_INTEGER := 0;
    
      c_nom_competencia_template CONSTANT CLOB := '<td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&NOM_COMPETENCIA</td>';
      c_img_competencia_template CONSTANT CLOB := '<td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center"><img src="http://retosports.com.py/img/cat/&IMG_COMPETENCIA" alt="&IMG_COMPETENCIA" style="width:60%"></td>';
      c_tr_competencias_template CONSTANT CLOB := '  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    &TD_NOM_COMPETENCIA2
    &TD_NOM_COMPETENCIA3
    &TD_NOM_COMPETENCIA1
  </tr>
  <tr style="color: #48752c;">
    &TD_IMG_COMPETENCIA2
    &TD_IMG_COMPETENCIA3
    &TD_IMG_COMPETENCIA1
  </tr>';
    BEGIN
      FOR co IN c_competencias LOOP
        IF l_col_competencias_tmp = 0 THEN
          l_col_competencias_tmp := c_cols_competencias;
        
          lp_limpiar_competencias;
        
          l_tab_competencias := l_tab_competencias || chr(10) ||
                                c_tr_competencias_template;
        END IF;
      
        l_tab_competencias := REPLACE(l_tab_competencias,
                                      '&TD_NOM_COMPETENCIA' ||
                                      l_col_competencias_tmp,
                                      REPLACE(c_nom_competencia_template,
                                              '&NOM_COMPETENCIA',
                                              k_util.f_formatear_titulo(co.descripcion)));
      
        l_tab_competencias := REPLACE(l_tab_competencias,
                                      '&TD_IMG_COMPETENCIA' ||
                                      l_col_competencias_tmp,
                                      REPLACE(c_img_competencia_template,
                                              '&IMG_COMPETENCIA',
                                              co.id_division || '.png'));
      
        l_col_competencias_tmp := l_col_competencias_tmp - 1;
      
      END LOOP;
      lp_limpiar_competencias;
      --dbms_output.put_line(l_tab_competencias);
    END;
  END IF;

  --Tus mejores resultados
  BEGIN
    SELECT nvl(SUM(CASE
                     WHEN gr.id_jornada_inicio IS NULL AND gr.id_jornada_fin IS NULL AND
                          gr.id_fase_inicio IS NULL AND gr.id_fase_fin IS NULL THEN
                      1
                     ELSE
                      0
                   END),
               0) resultado_ganador_torneo,
           nvl(SUM(CASE
                     WHEN gr.id_jornada_inicio IS NOT NULL AND
                          gr.id_jornada_fin IS NOT NULL THEN
                      1
                     ELSE
                      0
                   END),
               0) resultado_ganador_fecha,
           nvl(SUM(CASE
                     WHEN gr.id_jornada_inicio IS NULL AND gr.id_jornada_fin IS NULL AND
                          gr.id_fase_inicio IS NOT NULL AND
                          gr.id_fase_fin IS NOT NULL THEN
                      1
                     ELSE
                      0
                   END),
               0) resultado_ganador_fase
      INTO l_ganador_torneo, l_ganador_fecha, l_ganador_fase
      FROM t_torneos               t,
           t_grupo_torneo_usuarios n,
           t_grupos                g,
           t_grupo_torneos         gr
     WHERE t.id_torneo = n.id_torneo
       AND n.id_grupo = g.id_grupo
       AND g.id_grupo = gr.id_grupo
       AND g.tipo = 'GLO'
       AND t.temporada = i_anio
       AND n.ranking = 1 --1er lugar en el ranking
       AND n.id_usuario = l_usuario.id_usuario;
  END;

  -- Todos tus resultados
  DECLARE
    c_tr_torneos_template CONSTANT CLOB := '  <tr style="color: #48752c;">
    <td colspan="2" style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&NOM_COMPETENCIA</td>
  </tr>
  <tr style="color: #48752c;">
    <td colspan="2" style="font-family: sans-serif; font-size: 14px; font-weight: bold; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&NOM_TORNEO &GANADOR</td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px; padding-bottom: 2px;" valign="center" align="center">&PUNTOS</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px; padding-bottom: 2px;" valign="center" align="center">&RANKING</td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Puntos</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ranking</td>
  </tr>
  <tr>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&nbsp;</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">&nbsp;</td>
  </tr>';
  BEGIN
    FOR ct IN c_torneos LOOP
      l_tab_torneos := l_tab_torneos || chr(10) || c_tr_torneos_template;
    
      l_tab_torneos := REPLACE(l_tab_torneos,
                               '&NOM_COMPETENCIA',
                               k_util.f_formatear_titulo(ct.descripcion));
      l_tab_torneos := REPLACE(l_tab_torneos,
                               '&NOM_TORNEO',
                               k_util.f_formatear_titulo(ct.titulo));
      l_tab_torneos := REPLACE(l_tab_torneos, '&PUNTOS', ct.puntos);
      l_tab_torneos := REPLACE(l_tab_torneos, '&RANKING', ct.ranking);
    
      IF ct.ranking = 1 THEN
        l_tab_torneos := REPLACE(l_tab_torneos,
                                 '&GANADOR',
                                 '<span style="font-size: 24px;">' ||
                                 chr(4036994439) || '</span>');
      ELSE
        l_tab_torneos := REPLACE(l_tab_torneos, '&GANADOR', '');
      END IF;
    END LOOP;
  END;

  IF l_usuario.direccion_correo IS NOT NULL THEN
    --Armamos el asunto y el cuerpo del mensaje
    l_asunto := chr(14850749) || chr(4036988806) || ' ' || l_nombre ||
                ', tu resumen del ' || i_anio || ' en Reto Sports';
    l_cuerpo := '<!doctype html>
<html>

<head>
  <meta name="viewport" content="width=device-width">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Resumen anual del ' || i_anio ||
                '</title>
  <style>
@media only screen and (max-width: 620px) {
  table[class=body] h1 {
    font-size: 28px !important;
    margin-bottom: 10px !important;
  }

  table[class=body] p,
table[class=body] ul,
table[class=body] ol,
table[class=body] td,
table[class=body] span,
table[class=body] a {
    font-size: 16px !important;
  }

  table[class=body] .wrapper,
table[class=body] .article {
    padding: 10px !important;
  }

  table[class=body] .content {
    padding: 0 !important;
  }

  table[class=body] .container {
    padding: 0 !important;
    width: 100% !important;
  }

  table[class=body] .main {
    border-left-width: 0 !important;
    border-radius: 0 !important;
    border-right-width: 0 !important;
  }

  table[class=body] .btn table {
    width: 100% !important;
  }

  table[class=body] .btn a {
    width: 100% !important;
  }

  table[class=body] .img-responsive {
    height: auto !important;
    max-width: 100% !important;
    width: auto !important;
  }
}
@media all {
  .ExternalClass {
    width: 100%;
  }

  .ExternalClass,
.ExternalClass p,
.ExternalClass span,
.ExternalClass font,
.ExternalClass td,
.ExternalClass div {
    line-height: 100%;
  }

  .apple-link a {
    color: inherit !important;
    font-family: inherit !important;
    font-size: inherit !important;
    font-weight: inherit !important;
    line-height: inherit !important;
    text-decoration: none !important;
  }

  #MessageViewBody a {
    color: inherit;
    text-decoration: none;
    font-size: inherit;
    font-family: inherit;
    font-weight: inherit;
    line-height: inherit;
  }

  .btn-primary table td:hover {
    background-color: #34495e !important;
  }

  .btn-primary a:hover {
    background-color: #34495e !important;
    border-color: #34495e !important;
  }
}
</style>
</head>

<body class="" style="background-color: #f6f6f6; font-family: sans-serif; -webkit-font-smoothing: antialiased; font-size: 14px; line-height: 1.4; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;">
  <span class="preheader" style="color: transparent; display: none; height: 0; max-height: 0; max-width: 0; opacity: 0; overflow: hidden; mso-hide: all; visibility: hidden; width: 0;">' ||
                l_nombre || ', te presentamos tu resumen anual del ' ||
                i_anio ||
                ' en Reto Sports</span>
  <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #f6f6f6; width: 100%;" width="100%" bgcolor="#f6f6f6">
    <tr>
      <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left">&nbsp;</td>
      <td class="container" style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; display: block; max-width: 580px; padding: 10px; width: 580px; margin: 0 auto;" width="580" valign="top" align="left">
        <div class="content" style="box-sizing: border-box; display: block; margin: 0 auto; max-width: 580px; padding: 10px;">

          <!-- START CENTERED WHITE CONTAINER -->
          <table role="presentation" class="main" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;" width="100%">

            <!-- START MAIN CONTENT AREA -->
            <tr>
              <td class="wrapper" style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; box-sizing: border-box; padding: 20px;" valign="top" align="left">
                <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
                  <tr>
                    <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left">
                      <h2 style="color: #48752c; font-family: sans-serif; font-weight: 400; line-height: 1.4; margin: 0; margin-bottom: 30px; text-align: center;">' ||
                l_nombre || ', te presentamos tu resumen anual del ' ||
                i_anio ||
                ' en Reto Sports</h2>

<table style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="3" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">Tus pronósticos del ' ||
                i_anio ||
                '</th>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_competencias ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_torneos ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_pronosticos ||
                '</td>
  </tr>
  <tr style="color: #48752c;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Competencias</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Torneos</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Pronósticos</td>
  </tr>
</table>

<br>
<br>
<table style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="3" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">Tus aciertos</th>
  </tr>
  <tr style="color: #48752c;">
    <td colspan="3" style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center"><img src="http://retosports.com.py/img/exito.png" alt="exito.png" style="width:20%"></td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_aciertos_6pts || ' / ' || l_pronosticos ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_aciertos_3pts || ' / ' || l_pronosticos ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                l_aciertos_2pts || ' / ' || l_pronosticos ||
                '</td>
  </tr>
  <tr style="color: #48752c;">
    <td style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                round((l_aciertos_6pts / l_pronosticos) * 100, 1) ||
                '%</td>
    <td style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                round((l_aciertos_3pts / l_pronosticos) * 100, 1) ||
                '%</td>
    <td style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">' ||
                round((l_aciertos_2pts / l_pronosticos) * 100, 1) ||
                '%</td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Resultado exacto</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ganador correcto y diferencia de goles correcta</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ganador correcto o resultado de empate</td>
  </tr>
</table>

<br>
<br>
<table style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="3" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">Tus competencias</th>
  </tr>' || chr(10) || l_tab_competencias || chr(10) || '

</table>

<br>
<br>
<table border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="3" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">Lo más destacado</th>
  </tr>
  <tr style="color: #48752c;">
    <td colspan="3" style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center"><img src="http://retosports.com.py/img/trofeo.png" alt="trofeo.png" style="width:20%"></td>
  </tr>
  <tr style="color: #48752c;">
    <td colspan="3" style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">Tus mejores resultados</td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px; padding-bottom: 2px;" valign="center" align="center">' ||
                l_ganador_torneo ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px; padding-bottom: 2px;" valign="center" align="center">' ||
                l_ganador_fecha ||
                '</td>
    <td style="font-family: sans-serif; font-size: 28px; font-weight: bold; vertical-align: center; text-align: center; padding: 8px; padding-bottom: 2px;" valign="center" align="center">' ||
                l_ganador_fase ||
                '</td>
  </tr>
  <tr bgcolor="#58a65c" style="background-color: #58a65c; color: #ffffff;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">' ||
                CASE l_ganador_torneo
                  WHEN 1 THEN
                   'vez'
                  ELSE
                   'veces'
                END ||
                '</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">' ||
                CASE l_ganador_fecha
                  WHEN 1 THEN
                   'vez'
                  ELSE
                   'veces'
                END ||
                '</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">' ||
                CASE l_ganador_fase
                  WHEN 1 THEN
                   'vez'
                  ELSE
                   'veces'
                END || '</td>
  </tr>
  <tr style="color: #48752c;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ganador del torneo</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ganador de la fecha</td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center">Ganador de la fase</td>
  </tr>
</table>

<br>
<br>
<table border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="2" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center"> Todos tus resultados</th>
  </tr>
  <tr style="color: #48752c;">
    <td colspan="2" style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 2px;" valign="center" align="center"><img src="http://retosports.com.py/img/estadisticas.png" alt="estad.png" style="width:20%"></td>
  </tr>' || chr(10) || l_tab_torneos || chr(10) || '

</table>

<br>
<br>                      
<table border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed; border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
  <tr style="color: #48752c;">
    <th colspan="3" style="font-family: sans-serif; font-size: 18px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center">¿Te gusta Reto Sports?</th>
  </tr>
  <tr style="color: #48752c;">
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: right; padding: 8px;" valign="center" align="right"><a href="' ||
                k_usuario.f_generar_url_calificacion(i_alias        => l_usuario.alias,
                                                     i_anio         => i_anio,
                                                     i_calificacion => '3') ||
                '" target="_blank" style="text-decoration: none;"><img src="http://retosports.com.py/img/calif3.png" alt="Mucho" style="width:20%"></a></td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: center; padding: 8px;" valign="center" align="center"><a href="' ||
                k_usuario.f_generar_url_calificacion(i_alias        => l_usuario.alias,
                                                     i_anio         => i_anio,
                                                     i_calificacion => '2') ||
                '" target="_blank" style="text-decoration: none;"><img src="http://retosports.com.py/img/calif2.png" alt="Neutro" style="width:20%"></a></td>
    <td style="font-family: sans-serif; font-size: 14px; vertical-align: center; text-align: left; padding: 8px;" valign="center" align="left"><a href="' ||
                k_usuario.f_generar_url_calificacion(i_alias        => l_usuario.alias,
                                                     i_anio         => i_anio,
                                                     i_calificacion => '1') ||
                '" target="_blank" style="text-decoration: none;"><img src="http://retosports.com.py/img/calif1.png" alt="Nada" style="width:20%"></a></td>
  </tr>
</table>

                      <br>
                      <br>

                      <!-- START TABLE FOOTER -->
                      <div class="footer" style="clear: both; margin-top: 10px; text-align: center; width: 100%;">
                        <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
                          <tr>
                            <td class="content-block" style="font-family: sans-serif; vertical-align: top; padding: 8px; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; text-align: center; text-decoration: none;" valign="top" align="center"><a href="http://www.retosports.com.py" target="_blank">Reto Sports © ' ||
                i_anio || '</a></td>
                          </tr>
                        </table>
                      </div>
                      <!-- END TABLE FOOTER -->

                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <!-- END MAIN CONTENT AREA -->

          </table>
          <!-- END CENTERED WHITE CONTAINER -->

        </div>
      </td>
      <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left">&nbsp;</td>
    </tr>
  </table>

</body>

</html>';
  
    -- Enviamos el correo
    l_result := k_mensajeria.f_enviar_correo(i_subject         => l_asunto,
                                             i_body            => l_cuerpo,
                                             i_id_usuario      => l_usuario.id_usuario,
                                             i_to              => NULL,
                                             i_reply_to        => NULL,
                                             i_cc              => NULL,
                                             i_bcc             => NULL,
                                             i_prioridad_envio => k_mensajeria.c_prioridad_urgente);
    dbms_output.put_line(l_result);
  END IF;

  -- Limpiamos las variables globales
  k_sistema.p_definir_parametro_string(k_sistema.c_torneo, '');

END p_enviar_resumen_anual;
/
