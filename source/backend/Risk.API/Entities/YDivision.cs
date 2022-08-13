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

using Newtonsoft.Json;
using Risk.API.Attributes;
using Risk.API.Models;

namespace Risk.API.Entities
{
    public class YDivision : IEntity
    {
        [JsonProperty("id_division")]
        public string IdDivision { get; set; }
        [JsonProperty("descripcion")]
        public string Descripcion { get; set; }
        [JsonProperty("id_pais")]
        public int? IdPais { get; set; }
        [JsonProperty("detalle")]
        public string Detalle { get; set; }
        [JsonProperty("descripcion_corta")]
        public string DescripcionCorta { get; set; }
        [JsonProperty("version_logo")]
        public int? VersionLogo { get; set; }
        [JsonProperty("siguiendo")]
        public string Siguiendo { get; set; }
        [JsonProperty("suscripto")]
        public string Suscripto { get; set; }
        [JsonProperty("id_torneo")]
        public string IdTorneo { get; set; }
        [JsonProperty("temporada")]
        public int? Temporada { get; set; }
        [JsonProperty("titulo")]
        public string Titulo { get; set; }
        [JsonProperty("denominacion_oficial")]
        public string DenominacionOficial { get; set; }
        [JsonProperty("titulo_alternativo")]
        public string TituloAlternativo { get; set; }
        [JsonProperty("tipo")]
        public string Tipo { get; set; }
        [JsonProperty("ranking")]
        public int? Ranking { get; set; }

        public IModel ConvertToModel()
        {
            return new Division
            {
                IdDivision = this.IdDivision,
                Descripcion = this.Descripcion,
                IdPais = this.IdPais,
                Detalle = this.Detalle,
                DescripcionCorta = this.DescripcionCorta,
                VersionLogo = this.VersionLogo,
                Siguiendo = this.Siguiendo,
                Suscripto = this.Suscripto,
                TorneoActual =new TorneoResumen
                {
                    IdTorneo = this.IdTorneo,
                    Temporada = this.Temporada,
                    Titulo = this.Titulo,
                    DenominacionOficial = this.DenominacionOficial,
                    TituloAlternativo = this.TituloAlternativo,
                    Tipo = this.Tipo.GetEnumValue<TipoTorneo>(),
                    Ranking = this.Ranking
                }
            };
        }
    }
}