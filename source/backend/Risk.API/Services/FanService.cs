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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Risk.API.Entities;
using Risk.API.Helpers;
using Risk.API.Models;

namespace Risk.API.Services
{
    public class FanService : RiskServiceBase, IFanService
    {
        private const int ID_LISTAR_CLUBES = 40;
        private const int ID_REGISTRAR_GRUPO = 41;
        private const int ID_REALIZAR_PREDICCION = 43;
        private const int ID_LISTAR_PARTIDOS = 44;
        private const int ID_LISTAR_PREDICCIONES_PARTIDOS = 45;
        private const int ID_EDITAR_GRUPO = 46;
        private const int ID_LISTAR_JORNADAS = 47;

        public FanService(IConfiguration configuration, IHttpContextAccessor httpContextAccessor, IDbConnectionFactory dbConnectionFactory)
            : base(configuration, httpContextAccessor, dbConnectionFactory)
        {
        }

        public Respuesta<Pagina<Club>> ListarClubes(string idClub = null, string idDivision = null)
        {
            JObject prms = new JObject();
            prms.Add("id_club", idClub);
            prms.Add("id_division", idDivision);

            string rsp = base.ProcesarServicio(ID_LISTAR_CLUBES, prms.ToString(Formatting.None));
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

            string rsp = base.ProcesarServicio(ID_LISTAR_PARTIDOS, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPartido>>>(rsp);

            Pagina<Partido> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Partido, YPartido>(entityRsp.Datos, EntitiesMapper.GetPartidoListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Partido>, YPagina<YPartido>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Prediccion>> ListarPrediccionesPartidos(string usuario, int? partido = null, string torneo = null, string estado = null)
        {
            JObject prms = new JObject();
            prms.Add("partido", partido);
            prms.Add("torneo", torneo);
            prms.Add("estado", estado);
            prms.Add("usuario", usuario);

            string rsp = base.ProcesarServicio(ID_LISTAR_PREDICCIONES_PARTIDOS, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YPrediccion>>>(rsp);

            Pagina<Prediccion> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Prediccion, YPrediccion>(entityRsp.Datos, EntitiesMapper.GetPrediccionListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Prediccion>, YPagina<YPrediccion>>(entityRsp, datos);
        }

        public Respuesta<Pagina<Jornada<Prediccion>>> ListarJornadas(string torneo, int? jornada = null, string usuario = null, string estado = null)
        {
            JObject prms = new JObject();
            prms.Add("torneo", torneo);
            prms.Add("jornada", jornada);
            prms.Add("estado", estado);
            prms.Add("usuario", usuario);

            string rsp = base.ProcesarServicio(ID_LISTAR_JORNADAS, prms.ToString(Formatting.None));
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

            string rsp = base.ProcesarServicio(ID_REALIZAR_PREDICCION, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }

        public Respuesta<Dato> RegistrarGrupo(string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub)
        {
            JObject prms = new JObject();
            prms.Add("descripcion", descripcion);
            prms.Add("tipo", tipo);
            prms.Add("id_jornada_inicio", idJornadaInicio);
            prms.Add("todos_invitan", todosInvitan);
            prms.Add("id_club", idClub);

            string rsp = base.ProcesarServicio(ID_REGISTRAR_GRUPO, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
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

            string rsp = base.ProcesarServicio(ID_EDITAR_GRUPO, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YDato>>(rsp);

            return EntitiesMapper.GetRespuestaFromEntity<Dato, YDato>(entityRsp, EntitiesMapper.GetDatoFromEntity(entityRsp.Datos));
        }
    }
}
