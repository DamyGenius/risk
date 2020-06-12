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
        private readonly IConfiguration _configuration;

        public FanController(IFanService fanService, IGenService genService, IConfiguration configuration)
        {
            _fanService = fanService;
            _genService = genService;
            _configuration = configuration;
        }

        [AllowAnonymous]
        [HttpGet("ListarClubes")]
        [SwaggerOperation(OperationId = "ListarClubes", Summary = "ListarClubes", Description = "Obtiene una lista de clubes")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Club>>))]
        [SwaggerResponse(StatusCodes.Status400BadRequest, "Operación con error", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status500InternalServerError, "Error inesperado", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status501NotImplemented, "Servicio no implementado o inactivo", typeof(Respuesta<Dato>))]
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
        [SwaggerResponse(StatusCodes.Status400BadRequest, "Operación con error", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status500InternalServerError, "Error inesperado", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status501NotImplemented, "Servicio no implementado o inactivo", typeof(Respuesta<Dato>))]
        public IActionResult ListarClub([FromRoute, SwaggerParameter(Description = "Identificador del club", Required = true)] string idClub)
        {
            var respuesta = _fanService.ListarClubes(idClub, null);
            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("RecuperarEscudoClub")]
        [SwaggerOperation(OperationId = "RecuperarEscudoClub", Summary = "RecuperarEscudoClub", Description = "Permite recuperar el escudo de un club")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(FileContentResult))]
        [SwaggerResponse(StatusCodes.Status400BadRequest, "Operación con error", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status500InternalServerError, "Error inesperado", typeof(Respuesta<Dato>))]
        [SwaggerResponse(StatusCodes.Status501NotImplemented, "Servicio no implementado o inactivo", typeof(Respuesta<Dato>))]
        public IActionResult RecuperarEscudoClub([FromQuery, SwaggerParameter(Description = "Identificador del club", Required = true)] string idClub)
        {
            var respuesta = _genService.RecuperarArchivo("T_CLUBES", "ESCUDO", idClub);

            if (!respuesta.Codigo.Equals(RiskDbConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            var archivo = respuesta.Datos;
            byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(archivo.Contenido));

            return File(contenido, archivo.TipoMime, string.Concat(archivo.Nombre, ".", archivo.Extension));
        }
    }
}
