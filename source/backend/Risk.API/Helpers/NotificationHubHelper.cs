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
using Microsoft.Azure.NotificationHubs;
using Newtonsoft.Json.Linq;
using Risk.API.Models;
using Risk.API.Services;

namespace Risk.API.Helpers
{
    public static class NotificationHubHelper
    {
        public static void RegistrarDispositivo(string tokenDispositivo, IAutService autService, INotificationHubClientConnection notificationHubClientConnection)
        {
            if (notificationHubClientConnection.Hub == null)
            {
                return;
            }

            var respDatosDispositivo = autService.DatosDispositivo(tokenDispositivo);
            if (!respDatosDispositivo.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return;
            }

            Dispositivo dispositivo = respDatosDispositivo.Datos;

            if (dispositivo.TokenNotificacion == null || dispositivo.TokenNotificacion.Equals(string.Empty))
            {
                return;
            }

            NotificationPlatform platform = ObtenerPlataformaNotificacion(dispositivo.PlataformaNotificacion);

            List<string> tags = new List<string>();
            if (dispositivo.Suscripciones != null)
            {
                foreach (var item in dispositivo.Suscripciones)
                {
                    tags.Add(item.Contenido);
                }
            }

            var templates = new Dictionary<string, InstallationTemplate>();
            if (dispositivo.Plantillas != null)
            {
                foreach (var item in dispositivo.Plantillas)
                {
                    templates.Add(item.Nombre, new InstallationTemplate { Body = ObtenerPlantilla(item.Contenido, platform) });
                }
            }

            Installation installation = new Installation
            {
                InstallationId = dispositivo.TokenDispositivo,
                Platform = platform,
                PushChannel = dispositivo.TokenNotificacion,
                PushChannelExpired = false,
                Tags = tags,
                Templates = templates
            };

            notificationHubClientConnection.Hub.CreateOrUpdateInstallation(installation);
        }

        private static NotificationPlatform ObtenerPlataformaNotificacion(string plataformaNotificacion)
        {
            switch (plataformaNotificacion?.Trim().ToLowerInvariant())
            {
                case "wns":
                    return NotificationPlatform.Wns;
                case "apns":
                    return NotificationPlatform.Apns;
                case "mpns":
                    return NotificationPlatform.Mpns;
                case "adm":
                    return NotificationPlatform.Adm;
                case "baidu":
                    return NotificationPlatform.Baidu;
                case "gcm":
                case "fcm-legacy":
                case "fcm_legacy":
                    return NotificationPlatform.Fcm;
                case "fcm":
                case "fcmv1":
                case "fcm-v1":
                case "fcm_v1":
                default:
                    return NotificationPlatform.FcmV1;
            }
        }

        private static string ObtenerPlantilla(string plantilla, NotificationPlatform platform)
        {
            if (platform != NotificationPlatform.FcmV1 || string.IsNullOrWhiteSpace(plantilla))
            {
                return plantilla;
            }

            try
            {
                JObject json = JObject.Parse(plantilla);
                if (json["message"] != null)
                {
                    return plantilla;
                }

                JObject message = new JObject();
                if (json["notification"] != null)
                {
                    message["notification"] = json["notification"];
                }

                if (json["data"] != null)
                {
                    message["data"] = NormalizarDataFcmV1(json["data"]);
                }

                if (json["android"] != null)
                {
                    message["android"] = json["android"];
                }

                if (!message.HasValues)
                {
                    return plantilla;
                }

                return new JObject { ["message"] = message }.ToString(Newtonsoft.Json.Formatting.None);
            }
            catch
            {
                return plantilla;
            }
        }

        private static JObject NormalizarDataFcmV1(JToken data)
        {
            JObject dataNormalizada = new JObject();
            if (data is not JObject dataObject)
            {
                return dataNormalizada;
            }

            foreach (var property in dataObject.Properties())
            {
                dataNormalizada[property.Name] = property.Value.Type == JTokenType.String
                    ? property.Value
                    : property.Value.ToString(Newtonsoft.Json.Formatting.None);
            }

            return dataNormalizada;
        }
    }
}
