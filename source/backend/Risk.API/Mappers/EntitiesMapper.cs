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
                    Partidos = GetModelListFromEntity<Prediccion, YPrediccion>(entity.Partidos)
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
                    ReferenciaMensaje = entity.ReferenciaMensaje,
                    Fecha = entity.Fecha
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