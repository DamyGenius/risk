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

using System;
using Newtonsoft.Json;
using Risk.API.Models;

namespace Risk.API.Entities
{
    public class YTorneo : IEntity
    {
        [JsonProperty("id_torneo")]
        public string IdTorneo { get; set; }
        [JsonProperty("id_division")]
        public string IdDivision { get; set; }
        [JsonProperty("temporada")]
        public int? Temporada { get; set; }
        [JsonProperty("titulo")]
        public string Titulo { get; set; }
        [JsonProperty("denominacion_oficial")]
        public string DenominacionOficial { get; set; }
        [JsonProperty("titulo_alternativo")]
        public string TituloAlternativo { get; set; }
        [JsonProperty("desc_division")]
        public string DescDivision { get; set; }
        [JsonProperty("desc_corta_division")]
        public string DescCortaDivision { get; set; }
        [JsonProperty("siguiendo")]
        public string Siguiendo { get; set; }
        [JsonProperty("suscripto")]
        public string Suscripto { get; set; }

        public IModel ConvertToModel()
        {
            return new Torneo
            {
                IdTorneo = this.IdTorneo,
                IdDivision = this.IdDivision,
                Temporada = this.Temporada,
                Titulo = this.Titulo,
                DenominacionOficial = this.DenominacionOficial,
                TituloAlternativo = this.TituloAlternativo,
                DescDivision = this.DescDivision,
                DescCortaDivision = this.DescCortaDivision,
                Siguiendo = this.Siguiendo,
                Suscripto = this.Suscripto
            };
        }
    }
}