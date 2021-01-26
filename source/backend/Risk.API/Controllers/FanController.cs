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
using System.IO;
using System.Net.Mime;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Risk.API.Attributes;
using Risk.API.Helpers;
using Risk.API.Models;
using Risk.API.Services;
using Swashbuckle.AspNetCore.Annotations;

namespace Risk.API.Controllers
{
    [SwaggerTag("Servicios del dominio FANTASY", "https://jtsoya539.github.io/risk/")]
    [Authorize(Roles = "ADMINISTRADOR,USUARIO")]
    [Route("Api/[controller]")]
    [ApiController]
    public class FanController : RiskControllerBase
    {
        private readonly IFanService _fanService;
        private readonly IGenService _genService;

        public FanController(IFanService fanService, IGenService genService, IConfiguration configuration) : base(configuration)
        {
            _fanService = fanService;
            _genService = genService;
        }

        [AllowAnonymous]
        [HttpGet("ListarClubes")]
        [SwaggerOperation(OperationId = "ListarClubes", Summary = "ListarClubes", Description = "Obtiene una lista de clubes")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Club>>))]
        public IActionResult ListarClubes([FromQuery, SwaggerParameter(Description = "Identificador de la división", Required = false)] string idDivision)
        {
            var respuesta = _fanService.ListarClubes(null, idDivision);
            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarClubes/{idClub}")]
        [SwaggerOperation(OperationId = "ListarClub", Summary = "ListarClub", Description = "Obtiene los datos de un club")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Club>>))]
        public IActionResult ListarClub([FromRoute, SwaggerParameter(Description = "Identificador del club", Required = true)] string idClub)
        {
            var respuesta = _fanService.ListarClubes(idClub, null);
            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarPartidos")]
        [SwaggerOperation(OperationId = "ListarPartidos", Summary = "ListarPartidos", Description = "Obtiene una lista de partidos")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Partido>>))]
        public IActionResult ListarPartidos([FromQuery, SwaggerParameter(Description = "Identificador del torneo", Required = true)] string idTorneo,
                                            [FromQuery, SwaggerParameter(Description = "Estado del partido", Required = false)] string estado)
        {
            var respuesta = _fanService.ListarPartidos(null, idTorneo, estado);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ListarPrediccionesPartidos")]
        [SwaggerOperation(OperationId = "ListarPrediccionesPartidos", Summary = "ListarPrediccionesPartidos", Description = "Obtiene una lista de predicciones de partidos")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Prediccion>>))]
        public IActionResult ListarPrediccionesPartidos([FromQuery, SwaggerParameter(Description = "Identificador del torneo", Required = true)] string idTorneo,
            [FromQuery, SwaggerParameter(Description = "Estados de partidos (separados por coma)", Required = false)] string estadosPartidos,
            [FromQuery, SwaggerParameter(Description = "Estados de predicciones (separados por coma)", Required = false)] string estadosPredicciones,
            [FromQuery, SwaggerParameter(Description = "Usuario", Required = true)] string usuario,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar?", Required = false)] bool noPaginar,
            [FromQuery, SwaggerParameter(Description = "Orden (ASC/DESC)", Required = false)] OrdenLista orden)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _fanService.ListarPrediccionesPartidos(usuario, null, idTorneo, estadosPartidos, estadosPredicciones, paginaParametros, orden);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ListarJornadas")]
        [SwaggerOperation(OperationId = "ListarJornadas", Summary = "ListarJornadas", Description = "Obtiene una lista de jornadas")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Jornada<Prediccion>>>))]
        public IActionResult ListarJornadas([FromQuery, SwaggerParameter(Description = "Identificador del torneo", Required = true)] string idTorneo,
                                            [FromQuery, SwaggerParameter(Description = "Identificador de la jornada", Required = false)] int? jornada,
                                            [FromQuery, SwaggerParameter(Description = "Estado de la jornada", Required = false)] string estado,
                                            [FromQuery, SwaggerParameter(Description = "Usuario", Required = false)] string usuario,
                                            [FromQuery, SwaggerParameter(Description = "Incluir partidos (S/N)", Required = false)] string incluirPartidos)
        {
            var respuesta = _fanService.ListarJornadas(idTorneo, jornada, usuario, estado, incluirPartidos);
            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("RealizarPrediccion")]
        [SwaggerOperation(OperationId = "RealizarPrediccion", Summary = "RealizarPrediccion", Description = "Permite realizar una predicción")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult RealizarPrediccion([FromBody] RealizarPrediccionRequestBody requestBody)
        {
            var respuesta = _fanService.RealizarPrediccion(requestBody.Partido, requestBody.Usuario, requestBody.GolesClubLocal, requestBody.GolesClubVisitante, requestBody.IdSincronizacion);
            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("RecuperarEscudoClub")]
        [SwaggerOperation(OperationId = "RecuperarEscudoClub", Summary = "RecuperarEscudoClub", Description = "Permite recuperar el escudo de un club")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(FileContentResult))]
        public IActionResult RecuperarEscudoClub([FromQuery, SwaggerParameter(Description = "Identificador del club", Required = true)] string idClub,
            [FromQuery, SwaggerParameter(Description = "Version", Required = false)] int? version)
        {
            var respuesta = _genService.RecuperarArchivo("T_CLUBES", "ESCUDO", idClub, version);

            if (!respuesta.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            var archivo = respuesta.Datos;
            byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(archivo.Contenido));

            return File(contenido, archivo.TipoMime, string.Concat(archivo.Nombre, ".", archivo.Extension));
        }

        [HttpGet("RecuperarLogoGrupo")]
        [SwaggerOperation(OperationId = "RecuperarLogoGrupo", Summary = "RecuperarLogoGrupo", Description = "Permite recuperar el logo de un grupo")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(FileContentResult))]
        public IActionResult RecuperarLogoGrupo([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo,
            [FromQuery, SwaggerParameter(Description = "Version", Required = false)] int? version)
        {
            var respuesta = _genService.RecuperarArchivo("T_GRUPOS", "LOGO", idGrupo.ToString(), version);

            if (!respuesta.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            var archivo = respuesta.Datos;
            byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(archivo.Contenido));

            return File(contenido, archivo.TipoMime, string.Concat(archivo.Nombre, ".", archivo.Extension));
        }

        [HttpPost("GuardarLogoGrupo")]
        [SwaggerOperation(OperationId = "GuardarLogoGrupo", Summary = "GuardarLogoGrupo", Description = "Permite guardar el logo de un grupo")]
        [Consumes("multipart/form-data")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult GuardarLogoGrupo([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo, [FromForm] GuardarArchivoRequestBody requestBody)
        {
            string contenido = string.Empty;

            if (requestBody.Archivo.Length > 0)
            {
                using (var ms = new MemoryStream())
                {
                    requestBody.Archivo.CopyTo(ms);
                    contenido = Convert.ToBase64String(GZipHelper.Compress(ms.ToArray()));
                }
            }

            Archivo archivo = new Archivo
            {
                Contenido = contenido,
                Nombre = requestBody.Nombre,
                Extension = requestBody.Extension
            };

            var respuesta = _genService.GuardarArchivo("T_GRUPOS", "LOGO", idGrupo.ToString(), archivo);
            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("RegistrarGrupo")]
        [SwaggerOperation(OperationId = "RegistrarGrupo", Summary = "RegistrarGrupo", Description = "Permite registrar un grupo")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Grupo>))]
        public IActionResult RegistrarGrupo([FromBody] RegistrarGrupoRequestBody requestBody)
        {
            var respuesta = _fanService.RegistrarGrupo(requestBody.Descripcion, requestBody.Tipo, requestBody.IdJornadaInicio, requestBody.TodosInvitan, requestBody.IdClub);
            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("EditarGrupo")]
        [SwaggerOperation(OperationId = "EditarGrupo", Summary = "EditarGrupo", Description = "Permite editar un grupo")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult EditarGrupo([FromBody] EditarGrupoRequestBody requestBody)
        {
            var respuesta = _fanService.EditarGrupo(requestBody.IdGrupo, requestBody.Descripcion, requestBody.Tipo, requestBody.IdJornadaInicio, requestBody.TodosInvitan, requestBody.IdClub);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("DatosGrupo")]
        [SwaggerOperation(OperationId = "DatosGrupo", Summary = "DatosGrupo", Description = "Permite obtener los datos de un grupo")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Grupo>))]
        public IActionResult DatosGrupo([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo)
        {
            var respuesta = _fanService.DatosGrupo(idGrupo);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ListarGrupos")]
        [SwaggerOperation(OperationId = "ListarGrupos", Summary = "ListarGrupos", Description = "Obtiene una lista de grupos")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Grupo>>))]
        public IActionResult ListarGrupos([FromQuery, SwaggerParameter(Description = "", Required = true)] string misGrupos,
            [FromQuery, SwaggerParameter(Description = "", Required = false)] string tipoGrupo,
            [FromQuery, SwaggerParameter(Description = "", Required = false)] string aceptado,
            [FromQuery, SwaggerParameter(Description = "", Required = false)] string incluirUsuarios,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar?", Required = false)] bool noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _fanService.ListarGrupos(misGrupos, tipoGrupo, aceptado, incluirUsuarios, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("AbandonarGrupo")]
        [SwaggerOperation(OperationId = "AbandonarGrupo", Summary = "AbandonarGrupo", Description = "Permite abandonar un grupo")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult AbandonarGrupo([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo)
        {
            var respuesta = _fanService.AbandonarGrupo(idGrupo);
            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("InvitarUsuario")]
        [SwaggerOperation(OperationId = "InvitarUsuario", Summary = "InvitarUsuario", Description = "Permite invitar a un usuario a un grupo")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult InvitarUsuario([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo,
            [FromQuery, SwaggerParameter(Description = "Usuario", Required = true)] string usuario)
        {
            var respuesta = _fanService.InvitarUsuario(idGrupo, usuario);
            return ProcesarRespuesta(respuesta);
        }

        [HttpPost("ResponderInvitacion")]
        [SwaggerOperation(OperationId = "ResponderInvitacion", Summary = "ResponderInvitacion", Description = "Permite responder a invitación de un grupo")]
        [Consumes(MediaTypeNames.Application.Json)]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult ResponderInvitacion([FromQuery, SwaggerParameter(Description = "Identificador del grupo", Required = true)] int idGrupo,
            [FromQuery, SwaggerParameter(Description = "Respuesta a Invitación (ACEPTAR/RECHAZAR)", Required = true)] RespuestaInvitacion respuestaInvitacion)
        {
            var respuesta = _fanService.ResponderInvitacion(idGrupo, respuestaInvitacion);
            return ProcesarRespuesta(respuesta);
        }
    }
}
