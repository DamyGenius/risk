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
using Risk.API.Entities;
using Risk.API.Helpers;
using Risk.API.Mappers;
using Risk.API.Models;

namespace Risk.API.Services
{
    public class FanService : RiskServiceBase, IFanService
    {
        private const string DOMINIO_OPERACION = "FAN";
        private const string NOMBRE_LISTAR_CLUBES = "LISTAR_CLUBES";
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
        private const string NOMBRE_RESPONDER_SOLICITUD_AMISTAD = "SOLICITAR_AMISTAD";
        private const string NOMBRE_LISTAR_AMIGOS = "LISTAR_AMIGOS";

        public FanService(ILogger<FanService> logger, IConfiguration configuration, IHttpContextAccessor httpContextAccessor, IDbConnectionFactory dbConnectionFactory)
            : base(logger, configuration, httpContextAccessor, dbConnectionFactory)
        {
        }

        public Respuesta<Pagina<Club>> ListarClubes(string idClub = null, string idDivision = null)
        {
            JObject prms = new JObject();
            prms.Add("id_club", idClub);
            prms.Add("id_division", idDivision);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_CLUBES,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YClub>>>(rsp);

            Pagina<Club> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Club, YClub>(entityRsp.Datos, EntitiesMapper.GetClubListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Club>, YPagina<YClub>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Partido>> ListarPartidos(int? partido = null, string torneo = null, string estado = null)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("torneo", torneo);
            prms.Add("estado", estado);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_PARTIDOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPartido>>>(rsp);

            Pagina<Partido> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Partido, YPartido>(entityRsp.Datos, EntitiesMapper.GetPartidoListFromEntity(entityRsp.Datos.Elementos));
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
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetYPaginaParametrosFromModel(paginaParametros)));
            }
            prms.Add("orden", orden.ToString());

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_PREDICCIONES_PARTIDOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPrediccion>>>(rsp);

            Pagina<Prediccion> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Prediccion, YPrediccion>(entityRsp.Datos, EntitiesMapper.GetPrediccionListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Prediccion>, YPagina<YPrediccion>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Jornada<Prediccion>>> ListarJornadas(string torneo, int? jornada = null, string usuario = null, string estado = null, string incluirPartidos = null)
        {
            JObject prms = new JObject();
            prms.Add("torneo", torneo);
            prms.Add("jornada", jornada);
            prms.Add("estado", estado);
            prms.Add("usuario", usuario);
            prms.Add("incluir_partidos", incluirPartidos);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_JORNADAS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YJornada<YPrediccion>>>>(rsp);

            Pagina<Jornada<Prediccion>> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Jornada<Prediccion>, YJornada<YPrediccion>>(entityRsp.Datos, EntitiesMapper.GetJornadaListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Jornada<Prediccion>>, YPagina<YJornada<YPrediccion>>>(entityRsp, datos);
        }

        public Respuesta<Dato> RealizarPrediccion(int partido, string usuario, int? golesClubLocal, int? golesClubVisitante, int idSincronizacion)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("usuario", usuario);
            prms.Add("goles_club_local", golesClubLocal);
            prms.Add("goles_club_visitante", golesClubVisitante);
            prms.Add("id_sincronizacion", idSincronizacion);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_REALIZAR_PREDICCION,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Grupo> RegistrarGrupo(string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub)
        {
            JObject prms = new JObject();
            prms.Add("descripcion", descripcion);
            prms.Add("tipo", tipo);
            prms.Add("id_jornada_inicio", idJornadaInicio);
            prms.Add("todos_invitan", todosInvitan);
            prms.Add("id_club", idClub);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_REGISTRAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YGrupo>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Grupo, YGrupo>(entityRsp, EntitiesMapper.GetGrupoFromEntity(entityRsp.Datos));
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

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_EDITAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Grupo> DatosGrupo(int idGrupo)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_DATOS_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YGrupo>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Grupo, YGrupo>(entityRsp, EntitiesMapper.GetGrupoFromEntity(entityRsp.Datos));
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
                prms.Add("pagina_parametros", JToken.FromObject(ModelsMapper.GetYPaginaParametrosFromModel(paginaParametros)));
            }

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_GRUPOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YGrupo>>>(rsp);

            Pagina<Grupo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Grupo, YGrupo>(entityRsp.Datos, EntitiesMapper.GetGrupoListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Grupo>, YPagina<YGrupo>>(entityRsp, datos);
        }

        public Respuesta<Dato> AbandonarGrupo(int idGrupo)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_ABANDONAR_GRUPO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Dato> InvitarUsuario(int idGrupo, string usuario)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            prms.Add("usuario", usuario);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_INVITAR_USUARIO,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Dato> ResponderInvitacion(int idGrupo, RespuestaInvitacion respuestaInvitacion)
        {
            JObject prms = new JObject();
            prms.Add("id_grupo", idGrupo);
            prms.Add("respuesta", respuestaInvitacion.ToString());

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_RESPONDER_INVITACION,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Dato> SolicitarAmistad(string usuarioSolicitado)
        {
            JObject prms = new JObject();
            prms.Add("usuario_solicitado", usuarioSolicitado);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_SOLICITAR_AMISTAD,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Dato> ResponderSolicitudAmistad(int idAmistad, RespuestaInvitacion respuestaSolicitud)
        {
            JObject prms = new JObject();
            prms.Add("id_amistad", idAmistad);
            prms.Add("respuesta", respuestaSolicitud.ToString());

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_RESPONDER_SOLICITUD_AMISTAD,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Pagina<Amigo>> ListarAmigos(string usuario, TipoAmigo? tipo = null, string aceptado = null)
        {
            JObject prms = new JObject();
            prms.Add("usuario", usuario);
            prms.Add("tipo", tipo.ToString());
            prms.Add("aceptado", aceptado);

            string rsp = base.ProcesarOperacion(ModelsMapper.GetValueFromTipoOperacionEnum(TipoOperacion.Servicio),
                NOMBRE_LISTAR_AMIGOS,
                DOMINIO_OPERACION,
                prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YAmigo>>>(rsp);

            Pagina<Amigo> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Amigo, YAmigo>(entityRsp.Datos, EntitiesMapper.GetAmigoListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Amigo>, YPagina<YAmigo>>(entityRsp, datos);
        }
    }
}
