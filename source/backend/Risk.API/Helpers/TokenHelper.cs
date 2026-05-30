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
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net.Mail;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.IdentityModel.Tokens;
using Risk.API.Models;
using Risk.API.Services;
using Google.Apis.Auth;
using System.Net.Http;
using Newtonsoft.Json;
using Risk.API.Exceptions;

namespace Risk.API.Helpers
{
    public static class TokenHelper
    {
        private static readonly NLog.Logger Logger = NLog.LogManager.GetCurrentClassLogger();

        public static string GenerarAccessToken(string usuario, IAutService autService, IGenService genService)
        {
            var respDatosUsuario = autService.DatosUsuario(usuario);
            if (!respDatosUsuario.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return string.Empty;
            }

            Usuario datosUsuario = respDatosUsuario.Datos;

            // Crea la lista de claims (pertenencias, características) del usuario
            List<Claim> claims = new List<Claim>();

            claims.Add(new Claim(ClaimTypes.Name, datosUsuario.Alias));
            claims.Add(new Claim(ClaimTypes.GivenName, datosUsuario.Nombre ?? string.Empty));
            claims.Add(new Claim(ClaimTypes.Surname, datosUsuario.Apellido ?? string.Empty));
            claims.Add(new Claim(ClaimTypes.Email, datosUsuario.DireccionCorreo ?? string.Empty));
            //claims.Add(new Claim(ClaimTypes.HomePhone, datosUsuario.NumeroTelefono ?? string.Empty));
            claims.Add(new Claim(ClaimTypes.GroupSid, datosUsuario.Origen.ToString() ?? string.Empty));

            // Agrega los roles del usuario a la lista de claims
            foreach (var rol in datosUsuario.Roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, rol.Nombre));
            }

            var respTiempoExpiracionToken = autService.TiempoExpiracionToken(TipoToken.AccessToken);
            if (!respTiempoExpiracionToken.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return string.Empty;
            }
            int tiempoExpiracion = int.Parse(respTiempoExpiracionToken.Datos.Contenido);

            var respValorParametro = genService.ValorParametro("CLAVE_VALIDACION_ACCESS_TOKEN");
            if (!respValorParametro.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return string.Empty;
            }
            var signingKey = Encoding.ASCII.GetBytes(respValorParametro.Datos.Contenido);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims.ToArray()),
                Expires = DateTime.UtcNow.AddSeconds(tiempoExpiracion),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(signingKey), SecurityAlgorithms.HmacSha256Signature)
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var createdToken = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(createdToken);
        }

        public static string GenerarRefreshToken(int size = 32)
        {
            var randomNumber = new byte[size];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(randomNumber);
                return Convert.ToBase64String(randomNumber);
            }
        }

        public static string GenerarTokenDispositivo()
        {
            return DateTime.Now.Ticks.ToString() + "-" + Guid.NewGuid().ToString();
        }

        public static string ObtenerValorParametroDeHeaders(IHeaderDictionary headers, string headerName)
        {
            string valorParametro = string.Empty;

            string headerValue = null;
            if (headers.Keys.Contains(headerName))
            {
                headerValue = headers[headerName];
            }
            else if (headers.Keys.Contains(headerName.ToLower()))
            {
                headerValue = headers[headerName.ToLower()];
            }
            else if (headers.Keys.Contains(headerName.ToUpper()))
            {
                headerValue = headers[headerName.ToUpper()];
            }

            if (!string.IsNullOrEmpty(headerValue))
            {
                valorParametro = headerValue;
            }

            return valorParametro;
        }

        public static string ObtenerAccessTokenDeHeaders(IHeaderDictionary headers)
        {
            string accessToken = string.Empty;

            string authHeader = headers[RiskConstants.HEADER_AUTHORIZATION];
            if (!string.IsNullOrEmpty(authHeader) && authHeader.StartsWith("Bearer", StringComparison.OrdinalIgnoreCase))
            {
                accessToken = authHeader.Substring("Bearer".Length).Trim();
            }

            return accessToken;
        }

        public static string ObtenerUsuarioDeAccessToken(string accessToken)
        {
            string usuario = string.Empty;

            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            if (tokenHandler.CanReadToken(accessToken))
            {
                JwtSecurityToken jwtToken = tokenHandler.ReadJwtToken(accessToken);
                usuario = jwtToken.Claims.First(claim => claim.Type == "unique_name").Value;
            }

            return usuario;
        }

        public static async Task<UsuarioExterno> ObtenerUsuarioDeTokenGoogleAsync(string idToken, IGenService genService)
        {
            var respValorCliente = genService.ValorParametro("GOOGLE_IDENTIFICADOR_CLIENTE");
            if (!respValorCliente.Codigo.Equals(RiskConstants.CODIGO_OK))
                throw new SecurityTokenValidationException("Cliente de token no válido.");

            var audienciasValidas = respValorCliente.Datos.Contenido
                .Split(new[] { ',', ';', ' ' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(audiencia => audiencia.Trim())
                .Where(audiencia => !string.IsNullOrEmpty(audiencia))
                .ToList();

            if (!audienciasValidas.Any())
                throw new SecurityTokenValidationException("Cliente de token no válido.");

            var audienciasRecibidas = ObtenerAudienciasTokenGoogle(idToken);
            if (!audienciasRecibidas.Any(audienciasValidas.Contains))
            {
                Logger.Warn("Cliente de token Google no válido. Audiencias recibidas: {0}", string.Join(",", audienciasRecibidas));
                throw new SecurityTokenValidationException("Cliente de token no válido.");
            }

            var validationSettings = new GoogleJsonWebSignature.ValidationSettings
            {
                Audience = audienciasValidas
            };

            GoogleJsonWebSignature.Payload validPayload;
            try
            {
                validPayload = await GoogleJsonWebSignature.ValidateAsync(idToken, validationSettings);
            }
            catch (InvalidJwtException e) when (e.Message.Contains("expired", StringComparison.OrdinalIgnoreCase))
            {
                throw new RiskApiException("Sesión de Google expirada. Inicie sesión nuevamente.", e);
            }
            catch (InvalidJwtException e)
            {
                throw new RiskApiException("Token de Google no válido.", e);
            }

            if (validPayload == null)
                throw new SecurityTokenValidationException("Firma de token no válida.");

            var respValorEmisor = genService.ValorParametro("GOOGLE_EMISOR_TOKEN");
            if (!respValorEmisor.Codigo.Equals(RiskConstants.CODIGO_OK) || !validPayload.Issuer.Contains(respValorEmisor.Datos.Contenido, StringComparison.OrdinalIgnoreCase))
                throw new SecurityTokenValidationException("Emisor de token no válido.");

            if (!audienciasValidas.Contains(validPayload.Audience))
                throw new SecurityTokenValidationException("Cliente de token no válido.");

            MailAddress addr = new MailAddress(validPayload.Email);
            string username = addr.User;

            return new UsuarioExterno
            {
                Alias = username,
                Nombre = validPayload.GivenName,
                Apellido = validPayload.FamilyName,
                DireccionCorreo = validPayload.Email,
                Origen = OrigenSesion.Google,
                IdExterno = validPayload.Subject
            };
        }

        private static IEnumerable<string> ObtenerAudienciasTokenGoogle(string idToken)
        {
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            if (!tokenHandler.CanReadToken(idToken))
            {
                return Enumerable.Empty<string>();
            }

            JwtSecurityToken jwtToken = tokenHandler.ReadJwtToken(idToken);
            return jwtToken.Audiences
                .Where(audiencia => !string.IsNullOrWhiteSpace(audiencia))
                .ToList();
        }

        public static UsuarioExterno ObtenerUsuarioDeTokenFacebook(string accessToken, IGenService genService)
        {
            UsuarioExterno usuario = null;
            try
            {
                // Validamos el token a través del Graph de facebook
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri("https://graph.facebook.com");
                    HttpResponseMessage response = client.GetAsync($"me?fields=id,name,email,first_name,last_name&access_token={accessToken}").Result;

                    response.EnsureSuccessStatusCode();
                    string result = response.Content.ReadAsStringAsync().Result;
                    var jsonRes = JsonConvert.DeserializeObject<dynamic>(result);

                    // Obtenemos datos recibidos del usuario en la respuesta del Graph de facebook
                    string idExterno = jsonRes["id"].ToString();
                    string nombreCompleto = jsonRes["name"].ToString();
                    string nombre = jsonRes["first_name"].ToString();
                    string apellido = jsonRes["last_name"].ToString();

                    string direccionCorreo = "";
                    string username, domain;
                    if (jsonRes["email"] != null)
                    {
                        direccionCorreo = jsonRes["email"].ToString();
                        MailAddress addr = new MailAddress(direccionCorreo);
                        username = addr.User;
                        domain = addr.Host;
                    }
                    else
                    {
                        username = $"{nombre}_{apellido}".Replace(' ', '_').ToLower();
                    }

                    usuario = new UsuarioExterno
                    {
                        Alias = username,
                        Nombre = nombre,
                        Apellido = apellido,
                        DireccionCorreo = direccionCorreo,
                        Origen = OrigenSesion.Facebook,
                        IdExterno = idExterno
                    };
                }
            }
            catch (Exception e)
            {
                throw new SecurityTokenValidationException($"Token no válido: {accessToken}.", e);
            }

            return usuario;
        }
    }
}
