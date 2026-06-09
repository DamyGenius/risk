update t_importador_urls a
   set a.activo = 'N'
 where a.id_url in ('UHO', 'TIG', 'ABC', 'CER', 'TYC', 'FOX')
   and a.activo = 'S';

update t_importador_urls a
   set a.descripcion = 'https://sportsdemo.co/html/v3/minapp/modules/futbol/page/page.html'
 where a.id_url in ('SCO')
   and a.activo = 'S';
