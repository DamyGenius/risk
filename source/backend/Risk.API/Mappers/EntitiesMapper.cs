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
using Risk.API.Attributes;
using Risk.API.Entities;
using Risk.API.Models;

namespace Risk.API.Mappers
{
    public static class EntitiesMapper
    {
        public static TModel GetModelFromEntity<TModel, TEntity>(IEntity entity)
            where TModel : IModel
            where TEntity : IEntity
        {
            IModel model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = entity.ConvertToModel();
            }
            return (TModel)model;
        }

        public static List<TModel> GetModelListFromEntity<TModel, TEntity>(List<TEntity> entityList)
            where TModel : IModel
            where TEntity : IEntity
        {
            List<TModel> modelList = new List<TModel>();
            if (entityList != null)
            {
                foreach (var item in entityList)
                {
                    modelList.Add(GetModelFromEntity<TModel, TEntity>(item));
                }
            }
            return modelList;
        }

        public static Respuesta<TModel> GetRespuestaFromEntity<TModel, TEntity>(YRespuesta<TEntity> entity, TModel datos)
        {
            return new Respuesta<TModel>
            {
                Codigo = entity.Codigo,
                Mensaje = entity.Mensaje,
                Datos = datos
            };
        }

        public static Pagina<TModel> GetPaginaFromEntity<TModel, TEntity>(YPagina<TEntity> entity, List<TModel> elementos)
        {
            return new Pagina<TModel>
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
                    CantidadComentarios = entity.CantidadComentarios,
                    CantidadReacciones = entity.CantidadReacciones,
                    MiReaccion = entity.MiReaccion.GetEnumValue<Reaccion>()
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
                    CantidadComentarios = entity.CantidadComentarios,
                    CantidadReacciones = entity.CantidadReacciones,
                    MiReaccion = entity.MiReaccion.GetEnumValue<Reaccion>(),
                    PrediccionGolesLocal = entity.PredicGolesLocal,
                    PrediccionGolesVisitante = entity.PredicGolesVisitante,
                    Puntos = entity.Puntos,
                    Sincronizacion = entity.Sincronizacion
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
                model = new Amigo
                {
                    IdUsuario = entity.IdUsuario,
                    AliasUsuario = entity.AliasUsuario,
                    VersionAvatar = entity.VersionAvatar,
                    Puntos = entity.Puntos,
                    Ranking = entity.Ranking,
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

        public static SolicitudAmistad GetSolicitudAmistadFromEntity(YAmigo entity)
        {
            SolicitudAmistad model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                Enum.TryParse(entity.Tipo, out TipoAmigo tipoAmigo);
                var tipoSolicitud = tipoAmigo == TipoAmigo.SOLICITANTE ? TipoSolicitudAmistad.Enviada : TipoSolicitudAmistad.Recibida;
                model = new SolicitudAmistad
                {
                    IdUsuario = entity.IdUsuario,
                    AliasUsuario = entity.AliasUsuario,
                    VersionAvatar = entity.VersionAvatar,
                    Puntos = entity.Puntos,
                    Ranking = entity.Ranking,
                    TokenAceptacion = entity.TokenAceptacion,
                    TipoSolicitud = tipoSolicitud
                };
            }
            return model;
        }

        public static List<SolicitudAmistad> GetSolicitudAmistadListFromEntity(List<YAmigo> entityList)
        {
            List<SolicitudAmistad> modelList = new List<SolicitudAmistad>();
            foreach (var item in entityList)
            {
                modelList.Add(GetSolicitudAmistadFromEntity(item));
            }
            return modelList;
        }

        public static ComentarioPartido GetComentarioPartidoFromEntity(YComentario entity)
        {
            ComentarioPartido model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                if (!entity.Tipo.Equals(TipoComentario.Partido.GetStringValue()))
                {
                    model = null;
                }
                else
                {
                    model = new ComentarioPartido
                    {
                        IdComentario = entity.IdComentario,
                        IdPartido = entity.Referencia,
                        IdUsuario = entity.IdUsuario,
                        AliasUsuario = entity.AliasUsuario,
                        VersionAvatar = entity.VersionAvatar,
                        Contenido = entity.Contenido,
                        ReferenciaComentario = entity.ReferenciaComentario
                    };
                }
            }
            return model;
        }

        public static List<ComentarioPartido> GetComentarioPartidoListFromEntity(List<YComentario> entityList)
        {
            List<ComentarioPartido> modelList = new List<ComentarioPartido>();
            foreach (var item in entityList)
            {
                modelList.Add(GetComentarioPartidoFromEntity(item));
            }
            return modelList;
        }

        public static ReaccionPartido GetReaccionPartidoFromEntity(YReaccion entity)
        {
            ReaccionPartido model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                if (!entity.Tipo.Equals(TipoReaccion.Partido.GetStringValue()))
                {
                    model = null;
                }
                else
                {
                    model = new ReaccionPartido
                    {
                        IdReaccion = entity.IdReaccion,
                        IdPartido = entity.Referencia,
                        IdUsuario = entity.IdUsuario,
                        AliasUsuario = entity.AliasUsuario,
                        VersionAvatar = entity.VersionAvatar,
                        Reaccion = entity.Reaccion.GetEnumValue<Reaccion>(),
                        ReferenciaComentario = entity.ReferenciaComentario
                    };
                }
            }
            return model;
        }

        public static List<ReaccionPartido> GetReaccionPartidoListFromEntity(List<YReaccion> entityList)
        {
            List<ReaccionPartido> modelList = new List<ReaccionPartido>();
            foreach (var item in entityList)
            {
                modelList.Add(GetReaccionPartidoFromEntity(item));
            }
            return modelList;
        }

        public static GrupoMensaje GetGrupoMensajeFromEntity(YGrupoMensaje entity)
        {
            GrupoMensaje model;
            if (entity == null)
            {
                model = null;
            }
            else
            {
                model = new GrupoMensaje
                {
                    IdGrupoMensaje = entity.IdGrupoMensaje,
                    IdGrupo = entity.IdGrupo,
                    IdUsuario = entity.IdUsuario,
                    AliasUsuario = entity.AliasUsuario,
                    VersionAvatar = entity.VersionAvatar,
                    Contenido = entity.Contenido,
                    ReferenciaMensaje = entity.ReferenciaMensaje
                };
            }
            return model;
        }

        public static List<GrupoMensaje> GetGrupoMensajeListFromEntity(List<YGrupoMensaje> entityList)
        {
            List<GrupoMensaje> modelList = new List<GrupoMensaje>();
            foreach (var item in entityList)
            {
                modelList.Add(GetGrupoMensajeFromEntity(item));
            }
            return modelList;
        }
    }
}