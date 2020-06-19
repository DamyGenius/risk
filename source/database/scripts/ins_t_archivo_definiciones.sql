prompt Importing table t_archivo_definiciones...
set feedback off
set define off
insert into t_archivo_definiciones (TABLA, CAMPO, DESCRIPCION, TAMANO_MAXIMO, ORDEN, NOMBRE_REFERENCIA, EXTENSIONES_PERMITIDAS)
values ('T_USUARIOS', 'AVATAR', 'Avatar del usuario (imagen de perfil)', 10000000, 1, 'ALIAS', 'EXTENSION_IMAGEN');

insert into t_archivo_definiciones (TABLA, CAMPO, DESCRIPCION, TAMANO_MAXIMO, ORDEN, NOMBRE_REFERENCIA, EXTENSIONES_PERMITIDAS)
values ('T_CORREO_ADJUNTOS', 'ARCHIVO', 'Archivo adjunto', 10000000, 1, 'ID_CORREO_ADJUNTO', null);

prompt Done.
