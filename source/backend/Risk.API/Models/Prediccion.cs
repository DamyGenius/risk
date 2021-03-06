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

namespace Risk.API.Models
{
    public class Prediccion
    {
        public int IdPartido { get; set; }
        public string IdTorneo { get; set; }
        public string IdClubLocal { get; set; }
        public string IdClubVisitante { get; set; }
        public DateTime? Fecha { get; set; }
        public string Hora { get; set; }
        public int? IdJornada { get; set; }
        public int? IdEstadio { get; set; }
        public int? GolesLocal { get; set; }
        public int? GolesVisitante { get; set; }
        public string Estado { get; set; }
        public int? PrediccionGolesLocal { get; set; }
        public int? PrediccionGolesVisitante { get; set; }
        public int? Puntos { get; set; }
        public int? Sincronizacion { get; set; }
    }
}