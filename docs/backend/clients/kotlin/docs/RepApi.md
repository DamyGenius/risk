# RepApi

All URIs are relative to *http://localhost:5000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reporteListarSignificados**](RepApi.md#reporteListarSignificados) | **GET** /Api/Gen/ReporteListarSignificados | ReporteListarSignificados
[**reporteVersionSistema**](RepApi.md#reporteVersionSistema) | **GET** /Api/Gen/ReporteVersionSistema | ReporteVersionSistema


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

val apiInstance = RepApi()
val formato : FormatoReporte =  // FormatoReporte | Formato del reporte
val dominio : kotlin.String = dominio_example // kotlin.String | Dominio
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : java.io.File = apiInstance.reporteListarSignificados(formato, dominio, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling RepApi#reporteListarSignificados")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling RepApi#reporteListarSignificados")
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

val apiInstance = RepApi()
val formato : FormatoReporte =  // FormatoReporte | Formato del reporte
val riskMinusServiceMinusVersion : kotlin.String = riskMinusServiceMinusVersion_example // kotlin.String | Versión del Servicio
try {
    val result : java.io.File = apiInstance.reporteVersionSistema(formato, riskMinusServiceMinusVersion)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling RepApi#reporteVersionSistema")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling RepApi#reporteVersionSistema")
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

