/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2021 DamyGenius

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

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Risk.API.Models;
using Risk.API.Services;
using System.Threading.Tasks;

namespace Risk.API.Hubs
{
    [Authorize(Roles = "ADMINISTRADOR,USUARIO,USUARIO_NUEVO")]
    public class FanHub : Hub
    {
        private async Task AgregarAlGrupo(string groupName)
            => await Groups.AddToGroupAsync(Context.ConnectionId, groupName);

        private async Task SacarDelGrupo(string groupName)
            => await Groups.RemoveFromGroupAsync(Context.ConnectionId, groupName);

        public async Task AgregarAlPartido(int idPartido)
            => await AgregarAlGrupo($"partido-{idPartido}");

        public async Task SacarDelPartido(int idPartido)
            => await SacarDelGrupo($"partido-{idPartido}");

        public async Task ComentarPartido(int idPartido, string usuario, string contenido)
            => await Clients.Group($"partido-{idPartido}").SendAsync("comentarpartido", usuario, contenido);

        public async Task AgregarAlChatGrupal(int idGrupo)
            => await AgregarAlGrupo($"grupo-{idGrupo}");

        public async Task SacarDelChatGrupal(int idGrupo)
            => await SacarDelGrupo($"grupo-{idGrupo}");

        public async Task MensajeChatGrupal(int idGrupo, string usuario, string contenido)
            => await Clients.Group($"grupo-{idGrupo}").SendAsync("mensajechatgrupal", usuario, contenido);

        public async Task AgregarAlChatIndividual(int idAmistad)
            => await AgregarAlGrupo($"amigo-{idAmistad}");

        public async Task SacarDelChatIndividual(int idAmistad)
            => await SacarDelGrupo($"amigo-{idAmistad}");

        public async Task MensajeChatIndividual(int idGrupo, string usuario, string contenido)
            => await Clients.Group($"amigo-{idGrupo}").SendAsync("mensajechatindividual", usuario, contenido);
    }
}