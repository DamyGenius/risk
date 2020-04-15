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

using System.Collections.Generic;
using Risk.API.Entities;
using Risk.API.Models;

namespace Risk.API.Services
{
    public class EntitiesMapper
    {
        public static Archivo GetArchivoFromEntity(YArchivo entity)
        {
            return new Archivo
            {
                Contenido = entity.Contenido,
                Checksum = entity.Checksum,
                Tamano = entity.Tamano,
                Nombre = entity.Nombre,
                Extension = entity.Extension
            };
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
            return new Rol
            {
                IdRol = entity.IdRol,
                Nombre = entity.Nombre,
                Activo = entity.Activo,
                Detalle = entity.Detalle
            };
        }

        public static List<Rol> GetRolListFromEntity(List<YRol> entityList)
        {
            List<Rol> roles = new List<Rol>();
            foreach (var item in entityList)
            {
                roles.Add(GetRolFromEntity(item));
            }
            return roles;
        }

        public static Sesion GetSesionFromEntity(YSesion entity)
        {
            return new Sesion
            {
                IdSesion = entity.IdSesion,
                Estado = entity.Estado,
                AccessToken = entity.AccessToken,
                RefreshToken = entity.RefreshToken,
                TiempoExpiracion = entity.TiempoExpiracion
            };
        }

        public static Usuario GetUsuarioFromEntity(YUsuario entity)
        {
            return new Usuario
            {
                IdUsuario = entity.IdUsuario,
                Alias = entity.Alias,
                Nombre = entity.Nombre,
                Apellido = entity.Apellido,
                TipoPersona = entity.TipoPersona,
                Estado = entity.Estado,
                DireccionCorreo = entity.DireccionCorreo,
                NumeroTelefono = entity.NumeroTelefono,
                Roles = GetRolListFromEntity(entity.Roles)
            };
        }
    }
}