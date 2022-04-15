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

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Risk.API.Attributes;
using Risk.API.Entities;
using Risk.API.Helpers;
using Risk.API.Mappers;
using Risk.API.Models;

namespace Risk.API.Services
{
    public class FanService : RiskServiceBase, IFanService
    {
        private const string DOMINIO_OPERACION = "FAN";
        private const string NOMBRE_LISTAR_EQUIPOS = "LISTAR_CLUBES";
        private const string NOMBRE_REGISTRAR_GRUPO = "REGISTRAR_GRUPO";
        private const string NOMBRE_REALIZAR_PREDICCION = "REALIZAR_PREDICCION";
        private const string NOMBRE_LISTAR_PARTIDOS = "LISTAR_PARTIDOS";
        private const string NOMBRE_LISTAR_PREDICCIONES_PARTIDOS = "LISTAR_PREDICCIONES_PARTIDOS";
        private const string NOMBRE_EDITAR_GRUPO = "EDITAR_GRUPO";
        private const string NOMBRE_LISTAR_JORNADAS = "LISTAR_JORNADAS";
        private const string NOMBRE_DATOS_GRUPO = "DATOS_GRUPO";
        private const string NOMBRE_LISTAR_GRUPOS = "LISTAR_GRUPOS";
        private const string NOMBRE_ABANDONAR_GRUPO = "ABANDONAR_GRUPO";
        private const string NOMBRE_INVITAR_USUARIO = "INVITAR_USUARIO";
        private const string NOMBRE_RESPONDER_INVITACION = "RESPONDER_INVITACION";
        private const string NOMBRE_SOLICITAR_AMISTAD = "SOLICITAR_AMISTAD";
        private const string NOMBRE_RESPONDER_SOLICITUD_AMISTAD = "RESPONDER_SOLICITUD_AMISTAD";
        private const string NOMBRE_LISTAR_AMIGOS = "LISTAR_AMIGOS";
        private const string NOMBRE_REALIZAR_COMENTARIO = "REALIZAR_COMENTARIO";
        private const string NOMBRE_LISTAR_COMENTARIOS = "LISTAR_COMENTARIOS";
        private const string NOMBRE_REACCIONAR = "REACCIONAR";
        private const string NOMBRE_LISTAR_REACCIONES = "LISTAR_REACCIONES";
        private const string NOMBRE_ENVIAR_MENSAJE_GRUPO = "ENVIAR_MENSAJE_GRUPO";
        private const string NOMBRE_LISTAR_MENSAJES_GRUPO = "LISTAR_MENSAJES_GRUPO";
        private const string NOMBRE_ENVIAR_MENSAJE_AMIGO = "ENVIAR_MENSAJE_AMIGO";
        private const string NOMBRE_LISTAR_MENSAJES_AMIGO = "LISTAR_MENSAJES_AMIGO";
        private const string NOMBRE_LISTAR_DIVISIONES = "LISTAR_DIVISIONES";
        private const string NOMBRE_LISTAR_TORNEOS = "LISTAR_TORNEOS";
        private const string NOMBRE_SEGUIR = "SEGUIR";

        public FanService(ILogger<FanService> logger, IConfiguration configuration, IHttpContextAccessor httpContextAccessor, IDbConnectionFactory dbConnectionFactory)
            : base(logger, configuration, httpContextAccessor, dbConnectionFactory)
        {
        }

        public Respuesta<Pagina<Club>> ListarClubes(string idClub = null, int? idPais = null, string idDivision = null)
        {
            JObject prms = new JObject();
            prms.Add("id_club", idClub);
            prms.Add("id_division", idDivision);
            prms.Add("tipo",  TipoEquipo.Club.GetStringValue());
            prms.Add("id_pais", idPais);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_EQUIPOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YClub>>>(rsp);

            Pagina<Club> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Club, YClub>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Club, YClub>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Club>, YPagina<YClub>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Equipo>> ListarEquipos(string idEquipo = null, TipoEquipo? tipo = null, int? idPais = null, string idDivision = null)
        {
            JObject prms = new JObject();
            prms.Add("id_club", idEquipo);
            prms.Add("id_division", idDivision);
            prms.Add("tipo",  tipo.GetStringValue());
            prms.Add("id_pais", idPais);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_EQUIPOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YEquipo>>>(rsp);

            Pagina<Equipo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Equipo, YEquipo>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Equipo, YEquipo>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Equipo>, YPagina<YEquipo>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Partido>> ListarPartidos(int? partido = null, string torneo = null, string estado = null)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("torneo", torneo);
            prms.Add("estado", estado);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_PARTIDOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPartido>>>(rsp);

            Pagina<Partido> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Partido, YPartido>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Partido, YPartido>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Partido>, YPagina<YPartido>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Prediccion>> ListarPrediccionesPartidos(string usuario, int? partido = null, string torneo = null, string estadosPartidos = null, string estadosPredicciones = null, PaginaParametros paginaParametros = null, OrdenLista orden = OrdenLista.ASC)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("torneo", torneo);
            prms.Add("estados_partidos", estadosPartidos);
            prms.Add("estados_predicciones", estadosPredicciones);
            prms.Add("usuario", usuario);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }
            prms.Add("orden", orden.ToString());

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_PREDICCIONES_PARTIDOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPrediccion>>>(rsp);

            Pagina<Prediccion> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Prediccion, YPrediccion>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Prediccion, YPrediccion>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Prediccion>, YPagina<YPrediccion>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Jornada>> ListarJornadas(string torneo, int? jornada = null, string usuario = null, string estado = null, string incluirPartidos = null)
        {
            JObject prms = new JObject();
            prms.Add("torneo", torneo);
            prms.Add("jornada", jornada);
            prms.Add("estado", estado);
            prms.Add("usuario", usuario);
            prms.Add("incluir_partidos", incluirPartidos);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_JORNADAS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YJornada>>>(rsp);

            Pagina<Jornada> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Jornada, YJornada>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Jornada, YJornada>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Jornada>, YPagina<YJornada>>(entityRsp, datos);
        }

        public Respuesta<Dato> RealizarPrediccion(int partido, string usuario, int? golesClubLocal, int? golesClubVisitante, int idSincronizacion)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("usuario", usuario);
            prms.Add("goles_club_local", golesClubLocal);
            prms.Add("goles_club_visitante", golesClubVisitante);
            prms.Add("id_sincronizacion", idSincronizacion);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_REALIZAR_PREDICCION,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Grupo> RegistrarGrupo(string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub)
        {
            JObject prms = new JObject();
            prms.Add("descripcion", descripcion);
            prms.Add("tipo", tipo);
            prms.Add("id_jornada_inicio", idJornadaInicio);
            prms.Add("todos_invitan", todosInvitan);
            prms.Add("id_club", idClub);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_REGISTRAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YGrupo>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Grupo, YGrupo>(entityRsp, EntitiesMapper.GetModelFromEntity<Grupo, YGrupo>(entityRsp.Datos));
        }

        public Respuesta<Dato> EditarGrupo(int idGrupo, string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            prms.Add("descripcion", descripcion);
            prms.Add("tipo", tipo);
            prms.Add("id_jornada_inicio", idJornadaInicio);
            prms.Add("todos_invitan", todosInvitan);
            prms.Add("id_club", idClub);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_EDITAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Grupo> DatosGrupo(int idGrupo)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_DATOS_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YGrupo>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Grupo, YGrupo>(entityRsp, EntitiesMapper.GetModelFromEntity<Grupo, YGrupo>(entityRsp.Datos));
        }

        public Respuesta<Pagina<Grupo>> ListarGrupos(string misGrupos, string tipoGrupo = null, string aceptado = null, string incluirUsuarios = null, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("mis_grupos", misGrupos);
            prms.Add("tipo_grupo", tipoGrupo);
            prms.Add("aceptado", aceptado);
            prms.Add("incluir_usuarios", incluirUsuarios);

            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_GRUPOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YGrupo>>>(rsp);

            Pagina<Grupo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Grupo, YGrupo>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Grupo, YGrupo>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Grupo>, YPagina<YGrupo>>(entityRsp, datos);
        }

        public Respuesta<Dato> AbandonarGrupo(int idGrupo)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_ABANDONAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Dato> InvitarUsuario(int idGrupo, string usuario)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            prms.Add("usuario", usuario);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_INVITAR_USUARIO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Dato> ResponderInvitacion(int idGrupo, RespuestaInvitacion respuestaInvitacion)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            prms.Add("respuesta", respuestaInvitacion.ToString());

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_RESPONDER_INVITACION,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Dato> SolicitarAmistad(string usuarioSolicitado)
        {
            JObject prms = new JObject();
            prms.Add("usuario_solicitado", usuarioSolicitado);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_SOLICITAR_AMISTAD,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Dato> ResponderSolicitudAmistad(string usuarioSolicitante, RespuestaInvitacion respuestaSolicitud)
        {
            JObject prms = new JObject();
            prms.Add("usuario_solicitante", usuarioSolicitante);
            prms.Add("respuesta", respuestaSolicitud.ToString());

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_RESPONDER_SOLICITUD_AMISTAD,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Pagina<Amigo>> ListarAmigos(string usuario)
        {
            JObject prms = new JObject();
            prms.Add("usuario", usuario);
            prms.Add("aceptado", "S");

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_AMIGOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YAmigo>>>(rsp);

            Pagina<Amigo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Amigo, YAmigo>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Amigo, YAmigo>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Amigo>, YPagina<YAmigo>>(entityRsp, datos);
        }

        public Respuesta<Pagina<SolicitudAmistad>> ListarSolicitudesAmistad(string usuario, TipoSolicitudAmistad? tipo = null)
        {
            JObject prms = new JObject();
            prms.Add("usuario", usuario);
            prms.Add("tipo", ModelsMapper.GetTipoAmigoFromTipoSolicitudAmistadEnum(tipo).ToString());
            prms.Add("aceptado", "N");

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_AMIGOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YAmigo>>>(rsp);

            Pagina<SolicitudAmistad> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<SolicitudAmistad, YAmigo>(entityRsp.Datos, EntitiesMapper.GetSolicitudAmistadListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<SolicitudAmistad>, YPagina<YAmigo>>(entityRsp, datos);
        }

        public Respuesta<Dato> RealizarComentario(TipoComentario tipo, long referencia, string usuario, string contenido, long? referenciaComentario)
        {
            JObject prms = new JObject();
            prms.Add("tipo", tipo.GetStringValue());
            prms.Add("referencia", referencia);
            //prms.Add("usuario", usuario);
            prms.Add("contenido", contenido);
            prms.Add("ref_comentario", referenciaComentario);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_REALIZAR_COMENTARIO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Pagina<ComentarioPartido>> ListarComentariosPartido(int idPartido, long referenciaComentario, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("tipo", TipoComentario.Partido.GetStringValue());
            prms.Add("referencia", idPartido);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_COMENTARIOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YComentario>>>(rsp);

            Pagina<ComentarioPartido> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<ComentarioPartido, YComentario>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<ComentarioPartido, YComentario>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<ComentarioPartido>, YPagina<YComentario>>(entityRsp, datos);
        }

        public Respuesta<Dato> Reaccionar(TipoReaccion tipo, long referencia, Reaccion reaccion, long? referenciaComentario)
        {
            JObject prms = new JObject();
            prms.Add("tipo", tipo.GetStringValue());
            prms.Add("referencia", referencia);
            prms.Add("reaccion", reaccion.GetStringValue());
            prms.Add("ref_comentario", referenciaComentario);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_REACCIONAR,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Pagina<ReaccionPartido>> ListarReaccionesPartido(int idPartido, long referenciaComentario, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("tipo", TipoReaccion.Partido.GetStringValue());
            prms.Add("referencia", idPartido);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_REACCIONES,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YReaccion>>>(rsp);

            Pagina<ReaccionPartido> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<ReaccionPartido, YReaccion>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<ReaccionPartido, YReaccion>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<ReaccionPartido>, YPagina<YReaccion>>(entityRsp, datos);
        }

        public Respuesta<Dato> EnviarMensajeGrupo(int idGrupo, string usuario, string contenido, long? referenciaMensaje)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            //prms.Add("usuario", usuario);
            prms.Add("contenido", contenido);
            prms.Add("ref_mensaje", referenciaMensaje);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_ENVIAR_MENSAJE_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Pagina<GrupoMensaje>> ListarMensajesGrupo(int idGrupo, long referenciaMensaje, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_MENSAJES_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YGrupoMensaje>>>(rsp);

            Pagina<GrupoMensaje> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<GrupoMensaje, YGrupoMensaje>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<GrupoMensaje, YGrupoMensaje>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<GrupoMensaje>, YPagina<YGrupoMensaje>>(entityRsp, datos);
        }

        public Respuesta<Dato> EnviarMensajeAmigo(int idAmistad, string usuario, string contenido, long? referenciaMensaje)
        {
            JObject prms = new JObject();
            prms.Add("id_amistad", idAmistad);
            //prms.Add("usuario", usuario);
            prms.Add("contenido", contenido);
            prms.Add("ref_mensaje", referenciaMensaje);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_ENVIAR_MENSAJE_AMIGO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }

        public Respuesta<Pagina<AmigoMensaje>> ListarMensajesAmigo(int idAmistad, long referenciaMensaje, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("id_amistad", idAmistad);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_MENSAJES_AMIGO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YAmigoMensaje>>>(rsp);

            Pagina<AmigoMensaje> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<AmigoMensaje, YAmigoMensaje>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<AmigoMensaje, YAmigoMensaje>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<AmigoMensaje>, YPagina<YAmigoMensaje>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Division>> ListarDivisiones(string idDivision = null, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("id_division", idDivision);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_DIVISIONES,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YDivision>>>(rsp);

            Pagina<Division> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Division, YDivision>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Division, YDivision>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Division>, YPagina<YDivision>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Torneo>> ListarTorneos(string idDivision, PaginaParametros paginaParametros = null)
        {
            JObject prms = new JObject();
            prms.Add("id_division", idDivision);
            if (paginaParametros != null)
            {
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_LISTAR_TORNEOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YTorneo>>>(rsp);

            Pagina<Torneo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Torneo, YTorneo>(entityRsp.Datos, EntitiesMapper.GetModelListFromEntity<Torneo, YTorneo>(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Torneo>, YPagina<YTorneo>>(entityRsp, datos);
        }

        public Respuesta<Dato> Seguir(TipoSeguimiento tipo, string referencia)
        {
            JObject prms = new JObject();
            prms.Add("tipo", tipo.GetStringValue());
            prms.Add("referencia", referencia);

            string rsp = base.ProcesarOperacion(TipoOperacion.Servicio.GetStringValue(),
                NOMBRE_SEGUIR,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetModelFromEntity<Dato, YDato>(entityRsp.Datos));
        }
    }
}
