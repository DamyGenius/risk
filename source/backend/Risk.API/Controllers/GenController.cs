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
    [SwaggerTag("Servicios del dominio GENERAL", "https://jtsoya539.github.io/risk/")]
    [Authorize(Roles = "ADMINISTRADOR,USUARIO")]
    [Route("Api/[controller]")]
    [ApiController]
    public class GenController : RiskControllerBase
    {
        private readonly IGenService _genService;

        public GenController(IGenService genService, IConfiguration configuration) : base(configuration)
        {
            _genService = genService;
        }

        [AllowAnyClient]
        [AllowAnonymous]
        [HttpGet("/[controller]/VersionSistema")]
        [SwaggerOperation(OperationId = "VersionSistema", Summary = "VersionSistema", Description = "Obtiene la versión actual del sistema")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult VersionSistema()
        {
            var respuesta = _genService.VersionSistema();
            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("VersionServicio")]
        [SwaggerOperation(OperationId = "VersionServicio", Summary = "VersionServicio", Description = "Obtiene la versión actual del servicio")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult VersionServicio([FromQuery, SwaggerParameter(Description = "Nombre del servicio", Required = true)] string servicio)
        {
            var respuesta = _genService.VersionServicio(servicio);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ValorParametro")]
        [SwaggerOperation(OperationId = "ValorParametro", Summary = "ValorParametro", Description = "Obtiene el valor de un parámetro")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult ValorParametro([FromQuery, SwaggerParameter(Description = "Identificador del parámetro", Required = true)] string parametro)
        {
            var respuesta = _genService.ValorParametro(parametro);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("SignificadoCodigo")]
        [SwaggerOperation(OperationId = "SignificadoCodigo", Summary = "SignificadoCodigo", Description = "Obtiene el significado de un código dentro de un dominio")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult SignificadoCodigo([FromQuery, SwaggerParameter(Description = "Dominio", Required = true)] string dominio, [FromQuery, SwaggerParameter(Description = "Código", Required = true)] string codigo)
        {
            var respuesta = _genService.SignificadoCodigo(dominio, codigo);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ListarSignificados")]
        [SwaggerOperation(OperationId = "ListarSignificados", Summary = "ListarSignificados", Description = "Obtiene una lista de significados dentro de un dominio")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Significado>>))]
        public IActionResult ListarSignificados([FromQuery, SwaggerParameter(Description = "Dominio", Required = true)] string dominio,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar? (S/N)", Required = false)] string noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _genService.ListarSignificados(dominio, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarPaises")]
        [SwaggerOperation(OperationId = "ListarPaises", Summary = "ListarPaises", Description = "Obtiene una lista de países")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Pais>>))]
        public IActionResult ListarPaises([FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar? (S/N)", Required = false)] string noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _genService.ListarPaises(null, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarDepartamentos")]
        [SwaggerOperation(OperationId = "ListarDepartamentos", Summary = "ListarDepartamentos", Description = "Obtiene una lista de departamentos")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Departamento>>))]
        public IActionResult ListarDepartamentos([FromQuery, SwaggerParameter(Description = "Identificador del país", Required = false)] int? idPais,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar? (S/N)", Required = false)] string noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _genService.ListarDepartamentos(null, idPais, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarCiudades")]
        [SwaggerOperation(OperationId = "ListarCiudades", Summary = "ListarCiudades", Description = "Obtiene una lista de ciudades")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Ciudad>>))]
        public IActionResult ListarCiudades([FromQuery, SwaggerParameter(Description = "Identificador del país", Required = false)] int? idPais,
            [FromQuery, SwaggerParameter(Description = "Identificador del departamento", Required = false)] int? idDepartamento,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar? (S/N)", Required = false)] string noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _genService.ListarCiudades(null, idPais, idDepartamento, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("ListarBarrios")]
        [SwaggerOperation(OperationId = "ListarBarrios", Summary = "ListarBarrios", Description = "Obtiene una lista de barrios")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Pagina<Barrio>>))]
        public IActionResult ListarBarrios([FromQuery, SwaggerParameter(Description = "Identificador del país", Required = false)] int? idPais,
            [FromQuery, SwaggerParameter(Description = "Identificador del departamento", Required = false)] int? idDepartamento,
            [FromQuery, SwaggerParameter(Description = "Identificador de la ciudad", Required = false)] int? idCiudad,
            [FromQuery, SwaggerParameter(Description = "Número de la página", Required = false)] int pagina,
            [FromQuery, SwaggerParameter(Description = "Cantidad de elementos por página", Required = false)] int porPagina,
            [FromQuery, SwaggerParameter(Description = "No paginar? (S/N)", Required = false)] string noPaginar)
        {
            PaginaParametros paginaParametros = new PaginaParametros
            {
                Pagina = pagina,
                PorPagina = porPagina,
                NoPaginar = noPaginar
            };
            var respuesta = _genService.ListarBarrios(null, idPais, idDepartamento, idCiudad, paginaParametros);

            respuesta.Datos = ProcesarPagina(respuesta.Datos);

            return ProcesarRespuesta(respuesta);
        }

        [AllowAnonymous]
        [HttpGet("RecuperarTexto")]
        [SwaggerOperation(OperationId = "RecuperarTexto", Summary = "RecuperarTexto", Description = "Obtiene un texto definido en el sistema")]
        [Produces(MediaTypeNames.Application.Json)]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(Respuesta<Dato>))]
        public IActionResult RecuperarTexto([FromQuery, SwaggerParameter(Description = "Referencia del texto", Required = true)] string referencia)
        {
            var respuesta = _genService.RecuperarTexto(referencia);
            return ProcesarRespuesta(respuesta);
        }

        [HttpGet("ReporteVersionSistema")]
        [SwaggerOperation(OperationId = "ReporteVersionSistema", Summary = "ReporteVersionSistema", Description = "Obtiene un reporte con la versión actual del sistema")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(FileContentResult))]
        public IActionResult ReporteVersionSistema([FromQuery, SwaggerParameter(Description = "Formato del reporte", Required = true)] FormatoReporte formato)
        {
            var respuesta = _genService.ReporteVersionSistema(formato);

            if (!respuesta.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            var archivo = respuesta.Datos;

            if (archivo.Contenido == null)
            {
                return ProcesarRespuesta(respuesta);
            }

            byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(archivo.Contenido));
            return File(contenido, archivo.TipoMime, string.Concat(archivo.Nombre, ".", archivo.Extension));
        }

        [HttpGet("ReporteListarSignificados")]
        [SwaggerOperation(OperationId = "ReporteListarSignificados", Summary = "ReporteListarSignificados", Description = "Obtiene un reporte con los significados dentro de un dominio")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, "Operación exitosa", typeof(FileContentResult))]
        public IActionResult ReporteListarSignificados([FromQuery, SwaggerParameter(Description = "Formato del reporte", Required = true)] FormatoReporte formato,
            [FromQuery, SwaggerParameter(Description = "Dominio", Required = false)] string dominio)
        {
            var respuesta = _genService.ReporteListarSignificados(formato, dominio);

            if (!respuesta.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            var archivo = respuesta.Datos;

            if (archivo.Contenido == null)
            {
                return ProcesarRespuesta(respuesta);
            }

            byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(archivo.Contenido));
            return File(contenido, archivo.TipoMime, string.Concat(archivo.Nombre, ".", archivo.Extension));
        }
    }
}
