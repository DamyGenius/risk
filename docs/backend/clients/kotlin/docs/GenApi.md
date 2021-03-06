# GenApi

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**guardarArchivo**](GenApi.md#guardarArchivo) | **POST** /Api/Gen/GuardarArchivo | GuardarArchivo
[**listarAplicaciones**](GenApi.md#listarAplicaciones) | **GET** /Api/Gen/ListarAplicaciones | ListarAplicaciones
[**listarBarrios**](GenApi.md#listarBarrios) | **GET** /Api/Gen/ListarBarrios | ListarBarrios
[**listarCiudades**](GenApi.md#listarCiudades) | **GET** /Api/Gen/ListarCiudades | ListarCiudades
[**listarDepartamentos**](GenApi.md#listarDepartamentos) | **GET** /Api/Gen/ListarDepartamentos | ListarDepartamentos
[**listarErrores**](GenApi.md#listarErrores) | **GET** /Api/Gen/ListarErrores | ListarErrores
[**listarPaises**](GenApi.md#listarPaises) | **GET** /Api/Gen/ListarPaises | ListarPaises
[**listarSignificados**](GenApi.md#listarSignificados) | **GET** /Api/Gen/ListarSignificados | ListarSignificados
[**recuperarArchivo**](GenApi.md#recuperarArchivo) | **GET** /Api/Gen/RecuperarArchivo | RecuperarArchivo
[**recuperarTexto**](GenApi.md#recuperarTexto) | **GET** /Api/Gen/RecuperarTexto | RecuperarTexto
[**reporteListarSignificados**](GenApi.md#reporteListarSignificados) | **GET** /Api/Gen/ReporteListarSignificados | ReporteListarSignificados
[**reporteVersionSistema**](GenApi.md#reporteVersionSistema) | **GET** /Api/Gen/ReporteVersionSistema | ReporteVersionSistema
[**significadoCodigo**](GenApi.md#significadoCodigo) | **GET** /Api/Gen/SignificadoCodigo | SignificadoCodigo
[**valorParametro**](GenApi.md#valorParametro) | **GET** /Api/Gen/ValorParametro | ValorParametro
[**versionServicio**](GenApi.md#versionServicio) | **GET** /Api/Gen/VersionServicio | VersionServicio
[**versionSistema**](GenApi.md#versionSistema) | **GET** /Gen/VersionSistema | VersionSistema


<a name="guardarArchivo"></a>
# **guardarArchivo**
> DatoRespuesta guardarArchivo(tabla, campo, referencia, riskMinusServiceMinusVersion, archivo, url, nombre, extension)

GuardarArchivo

Permite guardar un archivo

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val tabla : kotlin.String = tabla_example // kotlin.String | Tabla
val campo : kotlin.String = campo_example // kotlin.String | Campo
val referencia : kotlin.String = referencia_example // kotlin.String | Referencia
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
val archivo : java.io.File = BINARY_DATA_HERE // java.io.File | Contenido del archivo
val url : kotlin.String = url_example // kotlin.String | URL del archivo
val nombre : kotlin.String = nombre_example // kotlin.String | Nombre del archivo
val extension : kotlin.String = extension_example // kotlin.String | Extensión del archivo
try {
    val result : DatoRespuesta = apiInstance.guardarArchivo(tabla, campo, referencia, riskMinusServiceMinusVersion, archivo, url, nombre, extension)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#guardarArchivo")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#guardarArchivo")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tabla** | **kotlin.String**| Tabla |
 **campo** | **kotlin.String**| Campo |
 **referencia** | **kotlin.String**| Referencia |
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]
 **archivo** | **java.io.File**| Contenido del archivo | [optional]
 **url** | **kotlin.String**| URL del archivo | [optional]
 **nombre** | **kotlin.String**| Nombre del archivo | [optional]
 **extension** | **kotlin.String**| Extensión del archivo | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json, text/plain

<a name="listarAplicaciones"></a>
# **listarAplicaciones**
> AplicacionPaginaRespuesta listarAplicaciones(idAplicacion, claveAplicacion, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarAplicaciones

Obtiene una lista de aplicaciones

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val idAplicacion : kotlin.String = idAplicacion_example // kotlin.String | Identificador de la aplicacion
val claveAplicacion : kotlin.String = claveAplicacion_example // kotlin.String | Clave de la aplicacion
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : AplicacionPaginaRespuesta = apiInstance.listarAplicaciones(idAplicacion, claveAplicacion, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarAplicaciones")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarAplicaciones")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idAplicacion** | **kotlin.String**| Identificador de la aplicacion | [optional]
 **claveAplicacion** | **kotlin.String**| Clave de la aplicacion | [optional]
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**AplicacionPaginaRespuesta**](AplicacionPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarBarrios"></a>
# **listarBarrios**
> BarrioPaginaRespuesta listarBarrios(idPais, idDepartamento, idCiudad, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarBarrios

Obtiene una lista de barrios

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val idPais : kotlin.Int = 56 // kotlin.Int | Identificador del país
val idDepartamento : kotlin.Int = 56 // kotlin.Int | Identificador del departamento
val idCiudad : kotlin.Int = 56 // kotlin.Int | Identificador de la ciudad
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : BarrioPaginaRespuesta = apiInstance.listarBarrios(idPais, idDepartamento, idCiudad, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarBarrios")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarBarrios")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idPais** | **kotlin.Int**| Identificador del país | [optional]
 **idDepartamento** | **kotlin.Int**| Identificador del departamento | [optional]
 **idCiudad** | **kotlin.Int**| Identificador de la ciudad | [optional]
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**BarrioPaginaRespuesta**](BarrioPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarCiudades"></a>
# **listarCiudades**
> CiudadPaginaRespuesta listarCiudades(idPais, idDepartamento, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarCiudades

Obtiene una lista de ciudades

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val idPais : kotlin.Int = 56 // kotlin.Int | Identificador del país
val idDepartamento : kotlin.Int = 56 // kotlin.Int | Identificador del departamento
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : CiudadPaginaRespuesta = apiInstance.listarCiudades(idPais, idDepartamento, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarCiudades")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarCiudades")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idPais** | **kotlin.Int**| Identificador del país | [optional]
 **idDepartamento** | **kotlin.Int**| Identificador del departamento | [optional]
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**CiudadPaginaRespuesta**](CiudadPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarDepartamentos"></a>
# **listarDepartamentos**
> DepartamentoPaginaRespuesta listarDepartamentos(idPais, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarDepartamentos

Obtiene una lista de departamentos

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val idPais : kotlin.Int = 56 // kotlin.Int | Identificador del país
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DepartamentoPaginaRespuesta = apiInstance.listarDepartamentos(idPais, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarDepartamentos")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarDepartamentos")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idPais** | **kotlin.Int**| Identificador del país | [optional]
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DepartamentoPaginaRespuesta**](DepartamentoPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarErrores"></a>
# **listarErrores**
> ErrorPaginaRespuesta listarErrores(idError, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarErrores

Obtiene una lista de errores

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val idError : kotlin.String = idError_example // kotlin.String | Identificador del error
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : ErrorPaginaRespuesta = apiInstance.listarErrores(idError, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarErrores")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarErrores")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idError** | **kotlin.String**| Identificador del error | [optional]
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**ErrorPaginaRespuesta**](ErrorPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarPaises"></a>
# **listarPaises**
> PaisPaginaRespuesta listarPaises(pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarPaises

Obtiene una lista de países

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : PaisPaginaRespuesta = apiInstance.listarPaises(pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarPaises")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarPaises")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**PaisPaginaRespuesta**](PaisPaginaRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="listarSignificados"></a>
# **listarSignificados**
> SignificadoPaginaRespuesta listarSignificados(dominio, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)

ListarSignificados

Obtiene una lista de significados dentro de un dominio

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val dominio : kotlin.String = dominio_example // kotlin.String | Dominio
val pagina : kotlin.Int = 56 // kotlin.Int | Número de la página
val porPagina : kotlin.Int = 56 // kotlin.Int | Cantidad de elementos por página
val noPaginar : kotlin.Boolean = true // kotlin.Boolean | No paginar?
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : SignificadoPaginaRespuesta = apiInstance.listarSignificados(dominio, pagina, porPagina, noPaginar, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#listarSignificados")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#listarSignificados")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dominio** | **kotlin.String**| Dominio |
 **pagina** | **kotlin.Int**| Número de la página | [optional]
 **porPagina** | **kotlin.Int**| Cantidad de elementos por página | [optional]
 **noPaginar** | **kotlin.Boolean**| No paginar? | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**SignificadoPaginaRespuesta**](SignificadoPaginaRespuesta.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="recuperarArchivo"></a>
# **recuperarArchivo**
> java.io.File recuperarArchivo(tabla, campo, referencia, version, riskMinusServiceMinusVersion)

RecuperarArchivo

Permite recuperar un archivo

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val tabla : kotlin.String = tabla_example // kotlin.String | Tabla
val campo : kotlin.String = campo_example // kotlin.String | Campo
val referencia : kotlin.String = referencia_example // kotlin.String | Referencia
val version : kotlin.Int = 56 // kotlin.Int | Versión
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : java.io.File = apiInstance.recuperarArchivo(tabla, campo, referencia, version, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#recuperarArchivo")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#recuperarArchivo")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tabla** | **kotlin.String**| Tabla |
 **campo** | **kotlin.String**| Campo |
 **referencia** | **kotlin.String**| Referencia |
 **version** | **kotlin.Int**| Versión | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**java.io.File**](java.io.File.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/octet-stream, text/plain

<a name="recuperarTexto"></a>
# **recuperarTexto**
> DatoRespuesta recuperarTexto(referencia, riskMinusServiceMinusVersion)

RecuperarTexto

Obtiene un texto definido en el sistema

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val referencia : kotlin.String = referencia_example // kotlin.String | Referencia del texto
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DatoRespuesta = apiInstance.recuperarTexto(referencia, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#recuperarTexto")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#recuperarTexto")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **referencia** | **kotlin.String**| Referencia del texto |
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="reporteListarSignificados"></a>
# **reporteListarSignificados**
> java.io.File reporteListarSignificados(formato, dominio, riskMinusServiceMinusVersion)

ReporteListarSignificados

Obtiene un reporte con los significados dentro de un dominio

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val formato : FormatoReporte =  // FormatoReporte | Formato del reporte
val dominio : kotlin.String = dominio_example // kotlin.String | Dominio
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : java.io.File = apiInstance.reporteListarSignificados(formato, dominio, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#reporteListarSignificados")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#reporteListarSignificados")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **formato** | [**FormatoReporte**](.md)| Formato del reporte | [enum: Pdf, Docx, Xlsx, Txt]
 **dominio** | **kotlin.String**| Dominio | [optional]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**java.io.File**](java.io.File.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/octet-stream, text/plain

<a name="reporteVersionSistema"></a>
# **reporteVersionSistema**
> java.io.File reporteVersionSistema(formato, riskMinusServiceMinusVersion)

ReporteVersionSistema

Obtiene un reporte con la versión actual del sistema

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val formato : FormatoReporte =  // FormatoReporte | Formato del reporte
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : java.io.File = apiInstance.reporteVersionSistema(formato, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#reporteVersionSistema")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#reporteVersionSistema")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **formato** | [**FormatoReporte**](.md)| Formato del reporte | [enum: Pdf, Docx, Xlsx, Txt]
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**java.io.File**](java.io.File.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/octet-stream, text/plain

<a name="significadoCodigo"></a>
# **significadoCodigo**
> DatoRespuesta significadoCodigo(dominio, codigo, riskMinusServiceMinusVersion)

SignificadoCodigo

Obtiene el significado de un código dentro de un dominio

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val dominio : kotlin.String = dominio_example // kotlin.String | Dominio
val codigo : kotlin.String = codigo_example // kotlin.String | Código
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DatoRespuesta = apiInstance.significadoCodigo(dominio, codigo, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#significadoCodigo")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#significadoCodigo")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dominio** | **kotlin.String**| Dominio |
 **codigo** | **kotlin.String**| Código |
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="valorParametro"></a>
# **valorParametro**
> DatoRespuesta valorParametro(parametro, riskMinusServiceMinusVersion)

ValorParametro

Obtiene el valor de un parámetro

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val parametro : kotlin.String = parametro_example // kotlin.String | Identificador del parámetro
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DatoRespuesta = apiInstance.valorParametro(parametro, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#valorParametro")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#valorParametro")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **parametro** | **kotlin.String**| Identificador del parámetro |
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization


Configure AccessToken:
    ApiClient.accessToken = ""
Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="versionServicio"></a>
# **versionServicio**
> DatoRespuesta versionServicio(servicio, riskMinusServiceMinusVersion)

VersionServicio

Obtiene la versión actual del servicio

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val servicio : kotlin.String = servicio_example // kotlin.String | Nombre del servicio
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DatoRespuesta = apiInstance.versionServicio(servicio, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#versionServicio")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#versionServicio")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **servicio** | **kotlin.String**| Nombre del servicio |
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization


Configure RiskAppKey:
    ApiClient.apiKey["Risk-App-Key"] = ""
    ApiClient.apiKeyPrefix["Risk-App-Key"] = ""

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain

<a name="versionSistema"></a>
# **versionSistema**
> DatoRespuesta versionSistema(riskMinusServiceMinusVersion)

VersionSistema

Obtiene la versión actual del sistema

### Example
```kotlin
// Import classes:
//import py.com.risk.client.infrastructure.*
//import py.com.risk.client.models.*

val apiInstance = GenApi()
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : DatoRespuesta = apiInstance.versionSistema(riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling GenApi#versionSistema")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling GenApi#versionSistema")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **riskMinusServiceMinusVersion** | **kotlin.String**| Versión del Servicio | [optional]

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

