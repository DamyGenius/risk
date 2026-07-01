update t_importador_urls a
   set a.descripcion = 'https://sportsdemo.co/html/v3/minapp/init/index.html',
       a.activo = 'S'
 where a.id_url in ('SPO')
   and a.activo = 'S';

update t_importador_urls a
   set a.descripcion = 'https://ix.cnn.io/data/sports/html/v3/minapp/init/index.html',
       a.activo = 'S'
 where a.id_url in ('CNN')
   and a.activo = 'S';

update t_importador_urls a
   set a.descripcion = 'https://estadisticas-deportes.tycsports.com/html/v3/minapp/init/index.html',
       a.activo = 'S'
 where a.id_url in ('TYC');
