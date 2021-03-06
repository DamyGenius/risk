# Guía de estilo para Desarrollo

## Introducción
A la hora de realizar tareas de desarrollo, mantenimiento, soporte y documentación de código en proyectos con equipos de varios desarrolladores, resulta muy conveniente que todos los miembros del equipo conozcan y hagan uso de un mismo estilo de codificación. Esto favorece tanto a la calidad como a la productividad.

Con este propósito, se recomienda a los desarrolladores que deseen colaborar con el proyecto seguir las convenciones de codificación que se describen en esta Guía. La mejor manera de escribir código compatible es familiarizarse con el ya existente y tratar de adaptar un estilo similar.

## Contenido
* [Consideraciones generales](#consideraciones-generales)
* [Nomenclatura](#nomenclatura)
* [Comentarios](#comentarios)
* [Auditoría de tablas](#auditoría-de-tablas)
* [Adjuntos](#adjuntos)


# Consideraciones generales

* Los archivos deben guardarse usando el carácter de fin de línea de Windows CRLF. De esta manera es posible examinarlos sin problemas en editores de texto simples como Notepad.

* Se recomienda evitar el uso de caracteres exclusivos del idioma español (la letra ñ, las vocales con acentos á, é, í, ó, ú, entre otros) en la codificación, ya sea para identificadores, comentarios, nombres de columnas, y objetos de Base de Datos.

  **Nota:** No se restringe el uso de estos caracteres en los datos de las tablas.

* Se recomienda utilizar la herramienta PL/SQL Beautifier antes de la compilación de los programas (paquetes, funciones, procedimientos, etc.).

  **Nota:** Se provee un archivo con la configuración de las reglas definidas para el proyecto (Ver [Adjuntos](#adjuntos)).


# Nomenclatura

## Objetos de Base de Datos
Los nombres de los objetos de Base de Datos deben tener prefijos que indiquen su tipo:

Tipo de objeto|Prefijo
--------------|-------
Tabla|t_
Vista|v_
Vista materializada|vm_
Función|f_
Procedimiento|p_
Paquete|k_
Trigger|g_
Secuencia|s_
Object Type|y_

* Se recomienda que los nombres de las tablas se encuentren en plural.
* Se recomienda que los nombres de los campos se encuentren en singular.
* Se recomienda que los nombres de los paquetes se encuentren en singular.
* Los campos que sirven de identificador o código deben usar el prefijo *id_*.
* Se recomienda usar el prefijo *lf_* para funciones locales.
* Se recomienda usar el prefijo *lp_* para procedimientos locales.
* Se recomienda usar el prefijo *ly_* para types locales.

Sufijos comunes de tablas:

Sufijo|Descripción
------|-----------
_hist|Datos históricos
_temp|Datos temporales

Nombres comunes de campos:

TIPO,
ESTADO,
ACTIVO,
DESCRIPCION,
DENOMINACION,
DETALLE,
OBSERVACION,
REFERENCIA,
COMENTARIO,
FECHA,
FECHA_INICIO,
FECHA_FIN,
MONTO,
CANTIDAD,
ORDEN

## Claves
Los nombres de las claves deben usar prefijos y construirse de la siguiente manera:

Tipo de clave|Prefijo|Nombre
-------------|-------|------
Clave primaria|pk_|Prefijo _ Tabla<sup>1</sup> <sup>2</sup>
Clave foránea|fk_|Prefijo _ Tabla principal<sup>1</sup> _ Tabla referenciada<sup>1</sup> <sup>2</sup>
Clave única|uk_|Prefijo _ Tabla<sup>1</sup> _ Campo(s) <sup>2</sup>

<sup>1</sup> Nombre de la tabla sin el prefijo *t_*

<sup>2</sup> En caso de superar el límite de 31 caracteres se recomienda abreviar el nombre de la tabla principal con los primeros tres caracteres de cada palabra, empezando por la primera (si existe más de una), hasta sortear dicho límite.

**Ejemplos:**
```
PK_PAISES
PK_PERSONAS
PK_SERVICIO_PARAMETROS
FK_USUARIOS_PERSONAS
FK_USUARIO_CLAVES_USUARIOS
UK_USUARIOS_ALIAS
UK_SER_PAR_ID_SERVICIO_ORDEN
```

## Check Constraints
Los nombres de los check constraints deben usar prefijos y construirse de la siguiente manera:

Prefijo|Nombre
-------|------
ck_|Prefijo _ Tabla<sup>1</sup> _ Campo(s) relacionado(s) <sup>2</sup>

<sup>1</sup> Nombre de la tabla sin el prefijo *t_*

<sup>2</sup> En caso de superar el límite de 31 caracteres se recomienda abreviar el nombre de la tabla principal con los primeros tres caracteres de cada palabra, empezando por la primera (si existe más de una), hasta sortear dicho límite.

**Ejemplos:**
```
CK_APLICACIONES_ACTIVO
CK_SISTEMAS_ACTIVO
```

## Triggers
Los nombres de los triggers deben usar prefijos y construirse de la siguiente manera:

Tipo de trigger|Prefijo|Nombre
---------------|-------|------
Trigger de auditoría|ga_|Prefijo _ Tabla<sup>1</sup>
Trigger de secuencia|gs_|Prefijo _ Tabla<sup>1</sup>
Trigger Before|gb_|Prefijo _ Tabla<sup>1</sup>
Trigger After|gf_|Prefijo _ Tabla<sup>1</sup>
Trigger Compound|gc_|Prefijo _ Tabla<sup>1</sup>

<sup>1</sup> Nombre de la tabla sin el prefijo *t_*

**Ejemplos:**
```
GS_USUARIOS
GB_ARCHIVOS
```

## Constantes y Variables
* Las constantes deben usar el prefijo *c_*.
* Las variables globales deben usar el prefijo *g_*.
* Las variables locales deben usar el prefijo *l_*.
* Los cursores deben usar el prefijo *cr_*.
* Los rowtype deben usar el prefijo *rw_*.

## Parámetros
* Los parámetros de entrada deben usar el prefijo *i_*.
* Los parámetros de salida deben usar el prefijo *o_*.
* Los parámetros de entrada y salida deben usar el prefijo *io_*.

Los parámetros de funciones y procedimientos se deben definir en el siguiente orden:
1. Parámetros de salida
1. Parámetros obligatorios de entrada
1. Parámetros opcionales de entrada

## Otros
* Las excepciones deben usar el prefijo *ex_*.
* Los savepoints deben usar el prefijo *sv_*.


# Comentarios

* Se recomienda incluir comentarios al principio de los programas (paquetes, funciones, procedimientos, etc.) con datos de: propósito del programa, autor, lista de parámetros (si aplica), retorno (si aplica) con el formato utilizado en la herramienta plsqldoc.

  **Nota:** Se provee una plantilla (template) para la inserción de estos comentarios (Ver [Adjuntos](#adjuntos)).

* Así mismo, se recomienda el uso de comentarios que faciliten la lectura y ayuden a comprender el funcionamiento de los programas en su estructura, preferentemente con el formato de una sola línea (--).


# Auditoría de tablas

* Todas las tablas deben tener cuatro campos de Auditoría:

Campo|Descripción
-----|-----------
USUARIO_INSERCION|Usuario que realizó la inserción del registro.
FECHA_INSERCION|Fecha en que se realizó la inserción del registro.
USUARIO_MODIFICACION|Usuario que realizó la última modificación en el registro.
FECHA_MODIFICACION|Fecha en que se realizó la última modificación en el registro.

  **Nota:** Se provee una herramienta para la generación de estos campos.

* Todas las tablas deben tener un trigger de Auditoría, que se encarga de los datos de los campos de Auditoría.

  **Nota:** Se provee una herramienta para la generación de este trigger.


# Adjuntos

Nombre del archivo|Descripción
------------------|-----------
[rules.br](https://gist.github.com/jtsoya539)|Reglas de la herramienta PL/SQL Beautifier definidas para el proyecto.
[plsqldoc.tpl](https://gist.github.com/jtsoya539)|Plantilla (template) para inserción de comentarios.
