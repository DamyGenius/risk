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

spool install.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #          Proyecto RISK          #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Migracion iniciada
prompt ===================================
prompt

prompt
prompt Ejecutando migracion...
prompt -----------------------------------
prompt
@@t_monitoreos.tab
@@t_monitoreo_ejecuciones.tab
@@s_id_monitoreo_ejecucion.seq
@@gs_monitoreo_ejecuciones.trg
@@v_monitoreo_datos.sql
@@k_html.pck
@@k_mensajeria.pck
@@k_operacion.pck
@@k_importacion_fan.pck
@@k_puntajes_fan.pck
@@k_monitoreo.pck
@@k_monitoreo_fan.pck
@@k_trabajo.pck
@@ins_t_significados.sql
@@upd_t_trabajos.sql
@@ins_t_archivos.sql
@@ins_t_parametros.sql
@@puntajes_pendientes_partidos.sql
@@monitoreo_conflictos.sql
@@create_monitoreo_conflictos.sql

prompt
prompt Registrando migracion...
prompt -----------------------------------
prompt
@@ins_t_migraciones.sql
commit;
/

prompt
prompt ===================================
prompt Migracion finalizada
prompt ===================================
prompt

spool off
