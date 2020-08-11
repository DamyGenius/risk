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
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Risk.API.Entities
{
    public class YGrupo
    {
        [JsonProperty("id_grupo")]
        public int IdGrupo { get; set; }
        [JsonProperty("id_torneo")]
        public string IdTorneo { get; set; }
        [JsonProperty("titulo_torneo")]
        public string TituloTorneo { get; set; }
        [JsonProperty("descripcion")]
        public string Descripcion { get; set; }
        [JsonProperty("tipo")]
        public string Tipo { get; set; }
        [JsonProperty("descripcion_tipo")]
        public string DescripcionTipo { get; set; }
        [JsonProperty("id_usuario_administrador")]
        public int? IdUsuarioAdministrador { get; set; }
        [JsonProperty("alias_usuario_administrador")]
        public string AliasUsuarioAdministrador { get; set; }
        [JsonProperty("fecha_creacion")]
        public DateTime? FechaCreacion { get; set; }
        [JsonProperty("id_jornada_inicio")]
        public int? IdJornadaInicio { get; set; }
        [JsonProperty("estado")]
        public string Estado { get; set; }
        [JsonProperty("situacion")]
        public string Situacion { get; set; }
        [JsonProperty("id_club")]
        public string IdClub { get; set; }
        [JsonProperty("nombre_oficial_club")]
        public string NombreOficialClub { get; set; }
        [JsonProperty("todos_invitan")]
        public string TodosInvitan { get; set; }
        [JsonProperty("usuarios")]
        public List<YGrupoUsuario> Usuarios { get; set; }
    }
}