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

using Risk.API.Models;

namespace Risk.API.Services
{
    public interface IFanService
    {
        Respuesta<Pagina<Club>> ListarClubes(string idClub = null, string idDivision = null);
        Respuesta<Pagina<Partido>> ListarPartidos(int? partido = null, string torneo = null, string estado = null);
        Respuesta<Pagina<Prediccion>> ListarPrediccionesPartidos(string usuario, int? partido = null, string torneo = null, string estadosPartidos = null, string estadosPredicciones = null, PaginaParametros paginaParametros = null, OrdenLista orden = OrdenLista.ASC);
        Respuesta<Pagina<Jornada<Prediccion>>> ListarJornadas(string torneo, int? jornada = null, string usuario = null, string estado = null, string incluirPartidos = null);
        Respuesta<Dato> RealizarPrediccion(int partido, string usuario, int? golesClubLocal, int? golesClubVisitante, int idSincronizacion);
        Respuesta<Grupo> RegistrarGrupo(string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub);
        Respuesta<Dato> EditarGrupo(int idGrupo, string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub);
        Respuesta<Grupo> DatosGrupo(int idGrupo);
        Respuesta<Pagina<Grupo>> ListarGrupos(string misGrupos, string tipoGrupo = null, string aceptado = null, string incluirUsuarios = null, PaginaParametros paginaParametros = null);
        Respuesta<Dato> AbandonarGrupo(int idGrupo);
        Respuesta<Dato> InvitarUsuario(int idGrupo, string usuario);
        Respuesta<Dato> ResponderInvitacion(int idGrupo, RespuestaInvitacion respuestaInvitacion);
        Respuesta<Dato> SolicitarAmistad(string usuarioSolicitado);
        Respuesta<Dato> ResponderSolicitudAmistad(int idAmistad, RespuestaInvitacion respuestaSolicitud);
        Respuesta<Pagina<Amigo>> ListarAmigos(string usuario, TipoAmigo? tipo = null, string aceptado = null);
    }
}