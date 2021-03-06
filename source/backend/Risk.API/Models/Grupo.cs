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

namespace Risk.API.Models
{
    public class Grupo
    {
        public int IdGrupo { get; set; }
        public string IdTorneo { get; set; }
        public string TituloTorneo { get; set; }
        public string Descripcion { get; set; }
        public string Tipo { get; set; }
        public string DescripcionTipo { get; set; }
        public int? IdUsuarioAdministrador { get; set; }
        public string AliasUsuarioAdministrador { get; set; }
        public DateTime? FechaCreacion { get; set; }
        public int? IdJornadaInicio { get; set; }
        public string Estado { get; set; }
        public string Situacion { get; set; }
        public string IdClub { get; set; }
        public string NombreOficialClub { get; set; }
        public string TodosInvitan { get; set; }
        public int? VersionLogo { get; set; }
        public List<GrupoUsuario> Usuarios { get; set; }
    }
}