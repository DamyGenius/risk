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

namespace Risk.API.Entities
{
    public class YPrediccion
    {
        [JsonProperty("id_partido")]
        public int IdPartido { get; set; }
        [JsonProperty("id_torneo")]
        public string IdTorneo { get; set; }
        [JsonProperty("id_club_local")]
        public string IdClubLocal { get; set; }
        [JsonProperty("id_club_visitante")]
        public string IdClubVisitante { get; set; }
        [JsonProperty("fecha")]
        public DateTime? Fecha { get; set; }
        [JsonProperty("hora")]
        public string Hora { get; set; }
        [JsonProperty("id_jornada")]
        public int? IdJornada { get; set; }
        [JsonProperty("id_estadio")]
        public int? IdEstadio { get; set; }
        [JsonProperty("goles_local")]
        public int? GolesLocal { get; set; }
        [JsonProperty("goles_visitante")]
        public int? GolesVisitante { get; set; }
        [JsonProperty("estado")]
        public string Estado { get; set; }
        [JsonProperty("predic_goles_local")]
        public int? PredicGolesLocal { get; set; }
        [JsonProperty("predic_goles_visitante")]
        public int? PredicGolesVisitante { get; set; }
        [JsonProperty("puntos")]
        public int? Puntos { get; set; }
        [JsonProperty("sincronizacion")]
        public int? Sincronizacion { get; set; }
    }
}