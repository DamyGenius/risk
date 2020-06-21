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

using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Risk.API.Entities;
using Risk.API.Helpers;
using Risk.API.Models;

namespace Risk.API.Services
{
    public class FanService : ServiceBase, IFanService
    {
        private const int ID_LISTAR_CLUBES = 40;

        public FanService(RiskDbContext dbContext, IConfiguration configuration) : base(dbContext, configuration)
        {
        }

        public Respuesta<Pagina<Club>> ListarClubes(string idClub = null, string idDivision = null)
        {
            JObject prms = new JObject();
            prms.Add("id_club", idClub);
            prms.Add("id_division", idDivision);

            string rsp = base.ApiProcesarServicio(ID_LISTAR_CLUBES, prms.ToString(Formatting.None));
            var entityRsp = JsonConvert.DeserializeObject<YRespuesta<YPagina<YClub>>>(rsp);

            Pagina<Club> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity<Club, YClub>(entityRsp.Datos, EntitiesMapper.GetClubListFromEntity(entityRsp.Datos.Elementos));
            }

            return EntitiesMapper.GetRespuestaFromEntity<Pagina<Club>, YPagina<YClub>>(entityRsp, datos);
        }
    }
}
