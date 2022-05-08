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

using System.Collections.Generic;
using Newtonsoft.Json;
using Risk.API.Mappers;
using Risk.API.Models;

namespace Risk.API.Entities
{
    public class YFase : IEntity
    {
        [JsonProperty("id_fase")]
        public int? IdFase { get; set; }
        [JsonProperty("descripcion")]
        public string Descripcion { get; set; }
        [JsonProperty("grupos")]
        public List<YTorneoGrupo> Grupos { get; set; }
        [JsonProperty("jornadas")]
        public List<YJornada> Jornadas { get; set; }
        [JsonProperty("partidos")]
        public List<YPrediccion> Partidos { get; set; }

        public IModel ConvertToModel()
        {
            return new Fase
            {
                IdFase = this.IdFase,
                Descripcion = this.Descripcion,
                Grupos = EntitiesMapper.GetModelListFromEntity<TorneoGrupo, YTorneoGrupo>(this.Grupos),
                Jornadas = EntitiesMapper.GetModelListFromEntity<Jornada, YJornada>(this.Jornadas),
                Partidos = EntitiesMapper.GetModelListFromEntity<Prediccion, YPrediccion>(this.Partidos)
            };
        }
    }
}