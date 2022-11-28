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
        Respuesta<Pagina<Club>> ListarClubes(string idClub = null, int? idPais = null, string idDivision = null);
        Respuesta<Pagina<Equipo>> ListarEquipos(string idEquipo = null, TipoEquipo? tipo = null, int? idPais = null, string idPaisIsoAlfa2 = null, string idDivision = null);
        Respuesta<Pagina<Partido>> ListarPartidos(int? partido = null, string torneo = null, string estado = null);
        Respuesta<Pagina<Prediccion>> ListarPrediccionesPartidos(string usuario, int? partido = null, string torneo = null, string estadosPartidos = null, string estadosPredicciones = null, PaginaParametros paginaParametros = null, OrdenLista orden = OrdenLista.ASC);
        Respuesta<Pagina<Jornada>> ListarJornadas(string torneo, int? jornada = null, string usuario = null, string estado = null, string incluirPartidos = null);
        Respuesta<TorneoDetalle> ListarFases(string torneo, int? fase = null, int? grupo = null, int? jornada = null, string usuario = null, string incluirPartidos = null);
        Respuesta<Dato> RealizarPrediccion(int partido, string usuario, int? golesClubLocal, int? golesClubVisitante, int idSincronizacion);
        Respuesta<Grupo> RegistrarGrupo(string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub, int idFaseInicio, int idGrupoBase);
        Respuesta<Dato> EditarGrupo(int idGrupo, string descripcion, string tipo, int idJornadaInicio, string todosInvitan, string idClub);
        Respuesta<Grupo> DatosGrupo(int idGrupo);
        Respuesta<Pagina<Grupo>> ListarGrupos(string misGrupos, string tipoGrupo = null, string aceptado = null, string incluirUsuarios = null, string torneosTodos = null, PaginaParametros paginaParametros = null);
        Respuesta<Dato> AbandonarGrupo(int idGrupo);
        Respuesta<Dato> InvitarUsuario(int idGrupo, string usuario);
        Respuesta<Dato> ResponderInvitacion(int idGrupo, RespuestaInvitacion respuestaInvitacion);
        Respuesta<Dato> SolicitarIngresoGrupo(int idGrupo);
        Respuesta<Dato> ResponderIngresoGrupo(int idGrupo,string usuarioSolicitante,  RespuestaInvitacion respuestaSolicitud);
        Respuesta<Dato> SolicitarAmistad(string usuarioSolicitado);
        Respuesta<Dato> ResponderSolicitudAmistad(string usuarioSolicitante, RespuestaInvitacion respuestaSolicitud);
        Respuesta<Pagina<Amigo>> ListarAmigos(string usuario);
        Respuesta<Pagina<SolicitudAmistad>> ListarSolicitudesAmistad(string usuario, TipoSolicitudAmistad? tipo = null);
        Respuesta<Dato> RealizarComentario(TipoComentario tipo, long referencia, string usuario, string contenido, long? referenciaComentario);
        Respuesta<Pagina<ComentarioPartido>> ListarComentariosPartido(int idPartido, long referenciaComentario, PaginaParametros paginaParametros = null);
        Respuesta<Dato> Reaccionar(TipoReaccion tipo, long referencia, Reaccion reaccion, long? referenciaComentario);
        Respuesta<Pagina<ReaccionPartido>> ListarReaccionesPartido(int idPartido, long referenciaComentario, PaginaParametros paginaParametros = null);
        Respuesta<Dato> EnviarMensajeGrupo(int idGrupo, string usuario, string contenido, long? referenciaMensaje);
        Respuesta<Pagina<GrupoMensaje>> ListarMensajesGrupo(int idGrupo, long referenciaMensaje, PaginaParametros paginaParametros = null);
        Respuesta<Dato> EnviarMensajeAmigo(int idAmistad, string usuario, string contenido, long? referenciaMensaje);
        Respuesta<Pagina<AmigoMensaje>> ListarMensajesAmigo(int idAmistad, long referenciaMensaje, PaginaParametros paginaParametros = null);
        Respuesta<Pagina<Division>> ListarDivisiones(string idDivision = null, string siguiendo = null, string suscripto = null, PaginaParametros paginaParametros = null);
        Respuesta<Pagina<Torneo>> ListarTorneos(string idDivision = null, string idTorneo = null, string siguiendo = null, string suscripto = null, PaginaParametros paginaParametros = null);
        Respuesta<Dato> Suscribir(TipoSuscripcion tipo, string referencia);
        Respuesta<Dato> SeguirDivision(string idDivision);
    }
}