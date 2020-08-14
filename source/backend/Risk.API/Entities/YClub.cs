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
    public class YClub
    {
        [JsonProperty("id_club")]
        public string IdClub { get; set; }
        [JsonProperty("nombre_oficial")]
        public string NombreOficial { get; set; }
        [JsonProperty("nombre_corto")]
        public string NombreCorto { get; set; }
        [JsonProperty("otros_nombres")]
        public string OtrosNombres { get; set; }
        [JsonProperty("fundacion")]
        public DateTime? Fundacion { get; set; }
        [JsonProperty("pagina_web")]
        public string PaginaWeb { get; set; }
        [JsonProperty("twitter")]
        public string Twitter { get; set; }
        [JsonProperty("facebook")]
        public string Facebook { get; set; }
        [JsonProperty("id_division")]
        public string IdDivision { get; set; }
        [JsonProperty("version_escudo")]
        public int? VersionEscudo { get; set; }
    }
}