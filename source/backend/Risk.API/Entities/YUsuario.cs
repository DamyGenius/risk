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
using Risk.API.Attributes;
using Risk.API.Mappers;
using Risk.API.Models;

namespace Risk.API.Entities
{
    public class YUsuario : IEntity
    {
        [JsonProperty("id_usuario")]
        public int IdUsuario { get; set; }
        [JsonProperty("alias")]
        public string Alias { get; set; }
        [JsonProperty("nombre")]
        public string Nombre { get; set; }
        [JsonProperty("apellido")]
        public string Apellido { get; set; }
        [JsonProperty("tipo_persona")]
        public string TipoPersona { get; set; }
        [JsonProperty("estado")]
        public string Estado { get; set; }
        [JsonProperty("estado_clave")]
        public string EstadoClave { get; set; }
        [JsonProperty("direccion_correo")]
        public string DireccionCorreo { get; set; }
        [JsonProperty("numero_telefono")]
        public string NumeroTelefono { get; set; }
        [JsonProperty("version_avatar")]
        public int? VersionAvatar { get; set; }
        [JsonProperty("verificado")]
        public string Verificado { get; set; }
        [JsonProperty("acepta_tyc")]
        public string AceptaTyC { get; set; }
        [JsonProperty("id_club")]
        public string IdClub { get; set; }
        [JsonProperty("descripcion_club")]
        public string DescripcionClub { get; set; }
        [JsonProperty("origen")]
        public string Origen { get; set; }
        [JsonProperty("id_torneo")]
        public string IdTorneo { get; set; }
        [JsonProperty("descripcion_torneo")]
        public string DescripcionTorneo { get; set; }
        [JsonProperty("id_division")]
        public string IdDivision { get; set; }
        [JsonProperty("descripcion_division")]
        public string DescripcionDivision { get; set; }
        [JsonProperty("puntos")]
        public int? Puntos { get; set; }
        [JsonProperty("ranking")]
        public int? Ranking { get; set; }
        [JsonProperty("tipo_amigo")]
        public string TipoAmigo { get; set; }
        [JsonProperty("id_amistad")]
        public long? IdAmistad { get; set; }
        [JsonProperty("bloqueado")]
        public string Bloqueado { get; set; }
        [JsonProperty("bloqueante")]
        public string Bloqueante { get; set; }
        [JsonProperty("roles")]
        public List<YRol> Roles { get; set; }

        public IModel ConvertToModel()
        {
            return new Usuario
            {
                IdUsuario = this.IdUsuario,
                Alias = this.Alias,
                Nombre = this.Nombre,
                Apellido = this.Apellido,
                TipoPersona = this.TipoPersona,
                Estado = this.Estado,
                EstadoClave = this.EstadoClave,
                DireccionCorreo = this.DireccionCorreo,
                NumeroTelefono = this.NumeroTelefono,
                VersionAvatar = this.VersionAvatar,
                Verificado = (this.Verificado == "S" ? true : false),
                AceptaTyC = (this.AceptaTyC == "S" ? true : false),
                IdClub = this.IdClub,
                DescripcionClub = this.DescripcionClub,
                Origen = this.Origen.GetEnumValue<OrigenSesion>(),
                IdTorneo = this.IdTorneo,
                DescripcionTorneo = this.DescripcionTorneo,
                IdDivision = this.IdDivision,
                DescripcionDivision = this.DescripcionDivision,
                Puntos = this.Puntos,
                Ranking = this.Ranking,
                TipoAmigo = this.TipoAmigo.GetEnumValue<TipoAmigo>(),
                IdAmistad = this.IdAmistad,
                Bloqueado = (this.Bloqueado == "S" ? true : false),
                Bloqueante = (this.Bloqueante == "S" ? true : false),
                Roles = EntitiesMapper.GetModelListFromEntity<Rol, YRol>(this.Roles)
            };
        }
    }
}