prompt Importing table t_importador_urls...
set feedback off
set define off

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('SPO', 'https://sportsdemo.co/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('UHO', 'https://df.ultimahora.com/adjuntos/datafactory/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('TIG', 'https://estaticopy.tigocloud.net/datafactory/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('ABC', 'https://archivo.abc.com.py/datos/deportes/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('CER', 'https://cerro.com.py/v3/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('TYC', 'https://estadisticas-deportes.tycsports.com/html/v3/index.html', 'S');

insert into t_importador_urls (ID_URL, DESCRIPCION, ACTIVO)
values ('FOX', 'https://foxsports-stats.tbxnet.com/html/v3/index.html', 'S');

prompt Done.
