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
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Risk.API.Models;

namespace Risk.API.Senders
{
    public class NeMailSender : IMsjSender<Correo>
    {
        private readonly ILogger<NeMailSender> _logger;
        private readonly IConfiguration _configuration;

        // NeMail Configuration
        private static HttpClient httpClient;
        private string neMailEndpoint;

        public NeMailSender(ILogger<NeMailSender> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public async Task Configurar()
        {
            await Task.Run(()=>
            {
                httpClient = new HttpClient();

                neMailEndpoint = "https://www.rama.com.py/proyecto-ne-notif/rest/send-email";
            });
        }

        public async Task Desconfigurar()
        {
            await Task.Run(()=>
            {
                neMailEndpoint = "";
            });
        }

        public async Task Enviar(Correo msj)
        {
            // Preparar cabecera http
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("text/plain"));
            httpClient.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
            httpClient.DefaultRequestHeaders.Add("User-Agent", "Fantasy NE.API");

            // Preparar parámetros
            var dict = new Dictionary<string, string>();
            dict.Add("destinatarios", msj.MensajeTo);
            dict.Add("asunto", msj.MensajeSubject);
            dict.Add("cuerpo", msj.MensajeBody);
            dict.Add("referencia", "");

            var stringTask = httpClient.PostAsync(neMailEndpoint, new FormUrlEncodedContent(dict));

            var msg = await stringTask;
            Console.Write(msg);
        }
    }
}