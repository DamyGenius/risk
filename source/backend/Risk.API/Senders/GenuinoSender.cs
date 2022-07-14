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
using System.Linq;
using System.Threading.Tasks;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MimeKit;
using Risk.API.Helpers;
using Risk.API.Models;

namespace Risk.API.Senders
{
    public class GenuinoSender : IMsjSender<Correo>
    {
        private readonly ILogger<GenuinoSender> _logger;
        private readonly IConfiguration _configuration;

        // Genuino Configuration
        private string mailboxFromName;
        private string mailboxFromAddress;
        private SmtpClient smtpClient;

        public GenuinoSender(ILogger<GenuinoSender> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public async Task Configurar()
        {
            mailboxFromName = _configuration["MsjConfiguration:Gmail:MailboxFromName"];
            mailboxFromAddress = _configuration["MsjConfiguration:Gmail:MailboxFromAddress"];

            smtpClient = new SmtpClient();
            smtpClient.Connect("secure.emailsrvr.com", 465, SecureSocketOptions.SslOnConnect);


            await smtpClient.AuthenticateAsync(_configuration["MsjConfiguration:Gmail:UserName"], _configuration["MsjConfiguration:Gmail:Password"]);
        }

        public async Task Desconfigurar()
        {
            await smtpClient.DisconnectAsync(true);
        }

        public async Task Enviar(Correo msj)
        {
            var message = new MimeMessage();

            // https://stackoverflow.com/a/59993188
            message.From.Add(new MailboxAddress(mailboxFromName, mailboxFromAddress));
            foreach (string address in msj.MensajeTo.Replace(";", ",").Split(",")) // Split on ,
            {
                message.To.Add(new MailboxAddress(address.Trim(), address.Trim()));
            }

            if (msj.MensajeReplyTo != null)
            {
                foreach (string address in msj.MensajeReplyTo.Replace(";", ",").Split(",")) // Split on ,
                {
                    message.ReplyTo.Add(new MailboxAddress(address.Trim(), address.Trim()));
                }
            }

            if (msj.MensajeCc != null)
            {
                foreach (string address in msj.MensajeCc.Replace(";", ",").Split(",")) // Split on ,
                {
                    message.Cc.Add(new MailboxAddress(address.Trim(), address.Trim()));
                }
            }

            if (msj.MensajeBcc != null)
            {
                foreach (string address in msj.MensajeBcc.Replace(";", ",").Split(",")) // Split on ,
                {
                    message.Bcc.Add(new MailboxAddress(address.Trim(), address.Trim()));
                }
            }

            message.Subject = msj.MensajeSubject;

            var multipart = new Multipart("mixed");

            // Body
            string subtype;
            if (msj.MensajeBody.Contains("<html") && msj.MensajeBody.Contains("</html>"))
            {
                subtype = "html";
            }
            else
            {
                subtype = "plain";
            }
            var body = new TextPart(subtype)
            {
                Text = msj.MensajeBody
            };
            multipart.Add(body);

            // Attachments
            if (msj.Adjuntos.Any())
            {
                foreach (var adjunto in msj.Adjuntos)
                {
                    string contentType = adjunto.TipoMime;
                    if (contentType == null)
                    {
                        contentType = "application/octet-stream";
                    }

                    byte[] contenido = GZipHelper.Decompress(Convert.FromBase64String(adjunto.Contenido));
                    var ms = new MemoryStream();
                    ms.Write(contenido, 0, contenido.Length);

                    var attachment = new MimePart(contentType)
                    {
                        Content = new MimeContent(ms, ContentEncoding.Default),
                        ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                        ContentTransferEncoding = ContentEncoding.Base64,
                        FileName = string.Concat(adjunto.Nombre, ".", adjunto.Extension)
                    };
                    multipart.Add(attachment);
                }
            }

            message.Body = multipart;
            await smtpClient.SendAsync(message);
        }
    }
}