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
using Risk.API.Entities;
using Risk.API.Models;

namespace Risk.API.Mappers
{
    public static class EntitiesMapper
    {
        public static Archivo GetArchivoFromEntity(YArchivo entity)
        {
            Archivo model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Archivo
                {
                    Contenido = entity.Contenido,
                    Url = entity.Url,
                    Checksum = entity.Checksum,
                    Tamano = entity.Tamano,
                    Nombre = entity.Nombre,
                    Extension = entity.Extension,
                    TipoMime = entity.TipoMime
                };
            }
            return model;
        }

        public static List<Archivo> GetArchivoListFromEntity(List<YArchivo> entityList)
        {
            List<Archivo> modelList = new List<Archivo>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetArchivoFromEntity(item));
                }
            }
            return modelList;
        }

        public static Dato GetDatoFromEntity(YDato entity)
        {
            Dato model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Dato
                {
                    Contenido = entity.Contenido
                };
            }
            return model;
        }

        public static List<Dato> GetDatoListFromEntity(List<YDato> entityList)
        {
            List<Dato> modelList = new List<Dato>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetDatoFromEntity(item));
                }
            }
            return modelList;
        }

        public static Respuesta<T> GetRespuestaFromEntity<T, YT>(YRespuesta<YT> entity, T datos)
        {
            return new Respuesta<T>
            {
                Codigo = entity.Codigo,
                Mensaje = entity.Mensaje,
                Datos = datos
            };
        }

        public static Rol GetRolFromEntity(YRol entity)
        {
            Rol model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Rol
                {
                    IdRol = entity.IdRol,
                    Nombre = entity.Nombre,
                    Activo = entity.Activo,
                    Detalle = entity.Detalle
                };
            }
            return model;
        }

        public static List<Rol> GetRolListFromEntity(List<YRol> entityList)
        {
            List<Rol> modelList = new List<Rol>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetRolFromEntity(item));
                }
            }
            return modelList;
        }

        public static Sesion GetSesionFromEntity(YSesion entity)
        {
            Sesion model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Sesion
                {
                    IdSesion = entity.IdSesion,
                    Estado = entity.Estado,
                    AccessToken = entity.AccessToken,
                    RefreshToken = entity.RefreshToken,
                    TiempoExpiracionAccessToken = entity.TiempoExpiracionAccessToken,
                    TiempoExpiracionRefreshToken = entity.TiempoExpiracionRefreshToken
                };
            }
            return model;
        }

        public static Dispositivo GetDispositivoFromEntity(YDispositivo entity)
        {
            Dispositivo model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Dispositivo
                {
                    IdDispositivo = entity.IdDispositivo,
                    TokenDispositivo = entity.TokenDispositivo,
                    NombreSistemaOperativo = entity.NombreSistemaOperativo,
                    VersionSistemaOperativo = entity.VersionSistemaOperativo,
                    Tipo = GetTipoDispositivoEnumFromValue(entity.Tipo),
                    NombreNavegador = entity.NombreNavegador,
                    VersionNavegador = entity.VersionNavegador,
                    TokenNotificacion = entity.TokenNotificacion,
                    TemplateNotificacion = entity.TemplateNotificacion,
                    PlataformaNotificacion = entity.PlataformaNotificacion,
                    Suscripciones = GetDatoListFromEntity(entity.Suscripciones)
                };
            }
            return model;
        }

        public static Usuario GetUsuarioFromEntity(YUsuario entity)
        {
            Usuario model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Usuario
                {
                    IdUsuario = entity.IdUsuario,
                    Alias = entity.Alias,
                    Nombre = entity.Nombre,
                    Apellido = entity.Apellido,
                    TipoPersona = entity.TipoPersona,
                    Estado = entity.Estado,
                    DireccionCorreo = entity.DireccionCorreo,
                    NumeroTelefono = entity.NumeroTelefono,
                    VersionAvatar = entity.VersionAvatar,
                    Puntos = entity.Puntos,
                    Ranking = entity.Ranking,
                    Roles = GetRolListFromEntity(entity.Roles)
                };
            }
            return model;
        }

        public static Significado GetSignificadoFromEntity(YSignificado entity)
        {
            Significado model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Significado
                {
                    Codigo = entity.Codigo,
                    Descripcion = entity.Significado,
                    Referencia = entity.Referencia,
                    Activo = entity.Activo
                };
            }
            return model;
        }

        public static List<Significado> GetSignificadoListFromEntity(List<YSignificado> entityList)
        {
            List<Significado> modelList = new List<Significado>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetSignificadoFromEntity(item));
                }
            }
            return modelList;
        }

        public static Pais GetPaisFromEntity(YPais entity)
        {
            Pais model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Pais
                {
                    IdPais = entity.IdPais,
                    Nombre = entity.Nombre,
                    IsoAlpha2 = entity.IsoAlpha2,
                    IsoAlpha3 = entity.IsoAlpha3,
                    IsoNumeric = entity.IsoNumeric
                };
            }
            return model;
        }

        public static List<Pais> GetPaisListFromEntity(List<YPais> entityList)
        {
            List<Pais> modelList = new List<Pais>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetPaisFromEntity(item));
                }
            }
            return modelList;
        }

        public static Departamento GetDepartamentoFromEntity(YDepartamento entity)
        {
            Departamento model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Departamento
                {
                    IdDepartamento = entity.IdDepartamento,
                    Nombre = entity.Nombre,
                    IdPais = entity.IdPais
                };
            }
            return model;
        }

        public static List<Departamento> GetDepartamentoListFromEntity(List<YDepartamento> entityList)
        {
            List<Departamento> modelList = new List<Departamento>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetDepartamentoFromEntity(item));
                }
            }
            return modelList;
        }

        public static Ciudad GetCiudadFromEntity(YCiudad entity)
        {
            Ciudad model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Ciudad
                {
                    IdCiudad = entity.IdCiudad,
                    Nombre = entity.Nombre,
                    IdPais = entity.IdPais,
                    IdDepartamento = entity.IdDepartamento
                };
            }
            return model;
        }

        public static List<Ciudad> GetCiudadListFromEntity(List<YCiudad> entityList)
        {
            List<Ciudad> modelList = new List<Ciudad>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetCiudadFromEntity(item));
                }
            }
            return modelList;
        }

        public static Barrio GetBarrioFromEntity(YBarrio entity)
        {
            Barrio model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Barrio
                {
                    IdBarrio = entity.IdBarrio,
                    Nombre = entity.Nombre,
                    IdPais = entity.IdPais,
                    IdDepartamento = entity.IdDepartamento,
                    IdCiudad = entity.IdCiudad,
                };
            }
            return model;
        }

        public static List<Barrio> GetBarrioListFromEntity(List<YBarrio> entityList)
        {
            List<Barrio> modelList = new List<Barrio>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetBarrioFromEntity(item));
                }
            }
            return modelList;
        }

        public static Error GetErrorFromEntity(YError entity)
        {
            Error model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Error
                {
                    IdError = entity.IdError,
                    Mensaje = entity.Mensaje
                };
            }
            return model;
        }

        public static List<Error> GetErrorListFromEntity(List<YError> entityList)
        {
            List<Error> modelList = new List<Error>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetErrorFromEntity(item));
                }
            }
            return modelList;
        }

        public static Aplicacion GetAplicacionFromEntity(SqlAplicacion entity)
        {
            Aplicacion model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Aplicacion
                {
                    IdAplicacion = entity.IdAplicacion,
                    Nombre = entity.Nombre,
                    Tipo = entity.Tipo,
                    Activo = GetBoolFromValue(entity.Activo),
                    Detalle = entity.Detalle,
                    VersionActual = entity.VersionActual
                };
            }
            return model;
        }

        public static List<Aplicacion> GetAplicacionListFromEntity(List<SqlAplicacion> entityList)
        {
            List<Aplicacion> modelList = new List<Aplicacion>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetAplicacionFromEntity(item));
                }
            }
            return modelList;
        }

        public static Mensaje GetMensajeFromEntity(YMensaje entity)
        {
            Mensaje model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Mensaje
                {
                    IdMensaje = entity.IdMensaje,
                    NumeroTelefono = entity.NumeroTelefono,
                    Contenido = entity.Contenido
                };
            }
            return model;
        }

        public static List<Mensaje> GetMensajeListFromEntity(List<YMensaje> entityList)
        {
            List<Mensaje> modelList = new List<Mensaje>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetMensajeFromEntity(item));
                }
            }
            return modelList;
        }

        public static Correo GetCorreoFromEntity(YCorreo entity)
        {
            Correo model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Correo
                {
                    IdCorreo = entity.IdCorreo,
                    MensajeTo = entity.MensajeTo,
                    MensajeSubject = entity.MensajeSubject,
                    MensajeBody = entity.MensajeBody,
                    MensajeFrom = entity.MensajeFrom,
                    MensajeReplyTo = entity.MensajeReplyTo,
                    MensajeCc = entity.MensajeCc,
                    MensajeBcc = entity.MensajeBcc,
                    Adjuntos = GetArchivoListFromEntity(entity.Adjuntos)
                };
            }
            return model;
        }

        public static List<Correo> GetCorreoListFromEntity(List<YCorreo> entityList)
        {
            List<Correo> modelList = new List<Correo>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetCorreoFromEntity(item));
                }
            }
            return modelList;
        }

        public static Notificacion GetNotificacionFromEntity(YNotificacion entity)
        {
            Notificacion model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Notificacion
                {
                    IdNotificacion = entity.IdNotificacion,
                    Suscripcion = entity.Suscripcion,
                    Titulo = entity.Titulo,
                    Contenido = entity.Contenido
                };
            }
            return model;
        }

        public static List<Notificacion> GetNotificacionListFromEntity(List<YNotificacion> entityList)
        {
            List<Notificacion> modelList = new List<Notificacion>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetNotificacionFromEntity(item));
                }
            }
            return modelList;
        }

        public static Pagina<T> GetPaginaFromEntity<T, YT>(YPagina<YT> entity, List<T> elementos)
        {
            return new Pagina<T>
            {
                PaginaActual = Convert.ToString(entity.NumeroActual),
                PaginaSiguiente = Convert.ToString(entity.NumeroSiguiente),
                PaginaUltima = Convert.ToString(entity.NumeroUltima),
                PaginaPrimera = Convert.ToString(entity.NumeroPrimera),
                PaginaAnterior = Convert.ToString(entity.NumeroAnterior),
                CantidadElementos = entity.CantidadElementos,
                Elementos = elementos
            };
        }

        public static Club GetClubFromEntity(YClub entity)
        {
            Club model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Club
                {
                    IdClub = entity.IdClub,
                    NombreOficial = entity.NombreOficial,
                    NombreCorto = entity.NombreCorto,
                    OtrosNombres = entity.OtrosNombres,
                    Fundacion = entity.Fundacion,
                    PaginaWeb = entity.PaginaWeb,
                    Twitter = entity.Twitter,
                    Facebook = entity.Facebook,
                    IdDivision = entity.IdDivision,
                    VersionEscudo = entity.VersionEscudo
                };
            }
            return model;
        }

        public static List<Club> GetClubListFromEntity(List<YClub> entityList)
        {
            List<Club> modelList = new List<Club>();
            foreach (var item in entityList)
            {
                modelList.Add(GetClubFromEntity(item));
            }
            return modelList;
        }

        public static Partido GetPartidoFromEntity(YPartido entity)
        {
            Partido model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Partido
                {
                    IdPartido = entity.IdPartido,
                    IdTorneo = entity.IdTorneo,
                    IdClubLocal = entity.IdClubLocal,
                    IdClubVisitante = entity.IdClubVisitante,
                    Fecha = entity.Fecha,
                    Hora = entity.Hora,
                    IdJornada = entity.IdJornada,
                    IdEstadio = entity.IdEstadio,
                    GolesLocal = entity.GolesLocal,
                    GolesVisitante = entity.GolesVisitante,
                    Estado = entity.Estado,
                };
            }
            return model;
        }

        public static List<Partido> GetPartidoListFromEntity(List<YPartido> entityList)
        {
            List<Partido> modelList = new List<Partido>();
            foreach (var item in entityList)
            {
                modelList.Add(GetPartidoFromEntity(item));
            }
            return modelList;
        }

        public static Prediccion GetPrediccionFromEntity(YPrediccion entity)
        {
            Prediccion model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Prediccion
                {
                    IdPartido = entity.IdPartido,
                    IdTorneo = entity.IdTorneo,
                    IdClubLocal = entity.IdClubLocal,
                    IdClubVisitante = entity.IdClubVisitante,
                    Fecha = entity.Fecha,
                    Hora = entity.Hora,
                    IdJornada = entity.IdJornada,
                    IdEstadio = entity.IdEstadio,
                    GolesLocal = entity.GolesLocal,
                    GolesVisitante = entity.GolesVisitante,
                    Estado = entity.Estado,
                    PrediccionGolesLocal = entity.PredicGolesLocal,
                    PrediccionGolesVisitante = entity.PredicGolesVisitante,
                    Puntos = entity.Puntos,
                    Sincronizacion = entity.Sincronizacion,
                };
            }
            return model;
        }

        public static List<Prediccion> GetPrediccionListFromEntity(List<YPrediccion> entityList)
        {
            List<Prediccion> modelList = new List<Prediccion>();
            foreach (var item in entityList)
            {
                modelList.Add(GetPrediccionFromEntity(item));
            }
            return modelList;
        }

        public static Jornada<Prediccion> GetJornadaFromEntity(YJornada<YPrediccion> entity)
        {
            Jornada<Prediccion> model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Jornada<Prediccion>
                {
                    IdTorneo = entity.IdTorneo,
                    IdJornada = entity.IdJornada,
                    Titulo = entity.Titulo,
                    Estado = entity.Estado,
                    Partidos = GetPrediccionListFromEntity(entity.Partidos)
                };
            }
            return model;
        }

        public static List<Jornada<Prediccion>> GetJornadaListFromEntity(List<YJornada<YPrediccion>> entityList)
        {
            List<Jornada<Prediccion>> modelList = new List<Jornada<Prediccion>>();
            foreach (var item in entityList)
            {
                modelList.Add(GetJornadaFromEntity(item));
            }
            return modelList;
        }

        public static GrupoUsuario GetGrupoUsuarioFromEntity(YGrupoUsuario entity)
        {
            GrupoUsuario model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new GrupoUsuario
                {
                    IdUsuario = entity.IdUsuario,
                    AliasUsuario = entity.AliasUsuario,
                    VersionAvatar = entity.VersionAvatar,
                    Puntos = entity.Puntos,
                    Ranking = entity.Ranking,
                    Estado = entity.Estado,
                    TokenActivacion = entity.TokenActivacion,
                    Aceptado = entity.Aceptado
                };
            }
            return model;
        }

        public static List<GrupoUsuario> GetGrupoUsuarioListFromEntity(List<YGrupoUsuario> entityList)
        {
            List<GrupoUsuario> modelList = new List<GrupoUsuario>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetGrupoUsuarioFromEntity(item));
                }
            }
            return modelList;
        }

        public static Grupo GetGrupoFromEntity(YGrupo entity)
        {
            Grupo model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new Grupo
                {
                    IdGrupo = entity.IdGrupo,
                    IdTorneo = entity.IdTorneo,
                    TituloTorneo = entity.TituloTorneo,
                    Descripcion = entity.Descripcion,
                    Tipo = entity.Tipo,
                    DescripcionTipo = entity.DescripcionTipo,
                    IdUsuarioAdministrador = entity.IdUsuarioAdministrador,
                    AliasUsuarioAdministrador = entity.AliasUsuarioAdministrador,
                    FechaCreacion = entity.FechaCreacion,
                    IdJornadaInicio = entity.IdJornadaInicio,
                    Estado = entity.Estado,
                    Situacion = entity.Situacion,
                    IdClub = entity.IdClub,
                    NombreOficialClub = entity.NombreOficialClub,
                    TodosInvitan = entity.TodosInvitan,
                    VersionLogo = entity.VersionLogo,
                    Usuarios = GetGrupoUsuarioListFromEntity(entity.Usuarios)
                };
            }
            return model;
        }

        public static List<Grupo> GetGrupoListFromEntity(List<YGrupo> entityList)
        {
            List<Grupo> modelList = new List<Grupo>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetGrupoFromEntity(item));
                }
            }
            return modelList;
        }

        public static TipoDispositivo GetTipoDispositivoEnumFromValue(string value)
        {
            switch (value.ToUpper())
            {
                case "M":
                    return TipoDispositivo.Mobile;
                case "T":
                    return TipoDispositivo.Tablet;
                case "D":
                    return TipoDispositivo.Desktop;
                case "V":
                    return TipoDispositivo.Tv;
                case "W":
                    return TipoDispositivo.Watch;
                default:
                    return TipoDispositivo.Mobile;
            }
        }

        public static bool GetBoolFromValue(string value)
        {
            switch (value.ToUpper())
            {
                case "S":
                    return true;
                case "N":
                    return false;
                default:
                    return false;
            }
        }

        public static Amigo GetAmigoFromEntity(YAmigo entity)
        {
            Amigo model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                Enum.TryParse(entity.Tipo, out TipoAmigo tipoAmigo);
                model = new Amigo
                {
                    IdUsuario = entity.IdUsuario,
                    AliasUsuario = entity.AliasUsuario,
                    VersionAvatar = entity.VersionAvatar,
                    Puntos = entity.Puntos,
                    Ranking = entity.Ranking,
                    TokenAceptacion = entity.TokenAceptacion,
                    Aceptado = entity.Aceptado,
                    TipoAmigo = tipoAmigo
                };
            }
            return model;
        }

        public static List<Amigo> GetAmigoListFromEntity(List<YAmigo> entityList)
        {
            List<Amigo> modelList = new List<Amigo>();
            foreach (var item in entityList)
            {
                modelList.Add(GetAmigoFromEntity(item));
            }
            return modelList;
        }
    }
}