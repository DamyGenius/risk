# GenApi

All URIs are relative to *https://risk-project-api.azurewebsites.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listarPais**](GenApi.md#listarPais) | **GET** /Api/Gen/ListarPaises/{idPais} | ListarPais
[**listarPaises**](GenApi.md#listarPaises) | **GET** /Api/Gen/ListarPaises | ListarPaises
[**significadoCodigo**](GenApi.md#significadoCodigo) | **GET** /Api/Gen/SignificadoCodigo | SignificadoCodigo
[**valorParametro**](GenApi.md#valorParametro) | **GET** /Api/Gen/ValorParametro | ValorParametro
[**versionSistema**](GenApi.md#versionSistema) | **GET** /Api/Gen/VersionSistema | VersionSistema



## listarPais

> PaisPaginaRespuesta listarPais(idPais)

ListarPais

Obtiene los datos de un país

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.auth.*;
import org.openapitools.client.models.*;
import org.openapitools.client.api.GenApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("https://risk-project-api.azurewebsites.net");
        
        // Configure API key authorization: RiskAppKey
        ApiKeyAuth RiskAppKey = (ApiKeyAuth) defaultClient.getAuthentication("RiskAppKey");
        RiskAppKey.setApiKey("YOUR API KEY");
        // Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
        //RiskAppKey.setApiKeyPrefix("Token");

        GenApi apiInstance = new GenApi(defaultClient);
        Integer idPais = 56; // Integer | Identificador del país
        try {
            PaisPaginaRespuesta result = apiInstance.listarPais(idPais);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling GenApi#listarPais");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idPais** | **Integer**| Identificador del país |

### Return type

[**PaisPaginaRespuesta**](PaisPaginaRespuesta.md)

### Authorization

[RiskAppKey](../README.md#RiskAppKey)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Operación exitosa |  -  |
| **403** | Aplicación no autorizada |  -  |
| **400** | Operación con error |  -  |
| **500** | Error inesperado |  -  |
| **501** | Servicio no implementado o inactivo |  -  |


## listarPaises

> PaisPaginaRespuesta listarPaises(pagina, porPagina, noPaginar)

ListarPaises

Obtiene una lista de países

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.auth.*;
import org.openapitools.client.models.*;
import org.openapitools.client.api.GenApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("https://risk-project-api.azurewebsites.net");
        
        // Configure API key authorization: RiskAppKey
        ApiKeyAuth RiskAppKey = (ApiKeyAuth) defaultClient.getAuthentication("RiskAppKey");
        RiskAppKey.setApiKey("YOUR API KEY");
        // Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
        //RiskAppKey.setApiKeyPrefix("Token");

        GenApi apiInstance = new GenApi(defaultClient);
        Integer pagina = 56; // Integer | Número de la página
        Integer porPagina = 56; // Integer | Cantidad de elementos por página
        String noPaginar = "noPaginar_example"; // String | No paginar? (S/N)
        try {
            PaisPaginaRespuesta result = apiInstance.listarPaises(pagina, porPagina, noPaginar);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling GenApi#listarPaises");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pagina** | **Integer**| Número de la página | [optional]
 **porPagina** | **Integer**| Cantidad de elementos por página | [optional]
 **noPaginar** | **String**| No paginar? (S/N) | [optional]

### Return type

[**PaisPaginaRespuesta**](PaisPaginaRespuesta.md)

### Authorization

[RiskAppKey](../README.md#RiskAppKey)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Operación exitosa |  -  |
| **403** | Aplicación no autorizada |  -  |
| **400** | Operación con error |  -  |
| **500** | Error inesperado |  -  |
| **501** | Servicio no implementado o inactivo |  -  |


## significadoCodigo

> DatoRespuesta significadoCodigo(dominio, codigo)

SignificadoCodigo

Obtiene el significado de un código dentro de un dominio

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.auth.*;
import org.openapitools.client.models.*;
import org.openapitools.client.api.GenApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("https://risk-project-api.azurewebsites.net");
        
        // Configure HTTP bearer authorization: AccessToken
        HttpBearerAuth AccessToken = (HttpBearerAuth) defaultClient.getAuthentication("AccessToken");
        AccessToken.setBearerToken("BEARER TOKEN");

        // Configure API key authorization: RiskAppKey
        ApiKeyAuth RiskAppKey = (ApiKeyAuth) defaultClient.getAuthentication("RiskAppKey");
        RiskAppKey.setApiKey("YOUR API KEY");
        // Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
        //RiskAppKey.setApiKeyPrefix("Token");

        GenApi apiInstance = new GenApi(defaultClient);
        String dominio = "dominio_example"; // String | Dominio
        String codigo = "codigo_example"; // String | Código
        try {
            DatoRespuesta result = apiInstance.significadoCodigo(dominio, codigo);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling GenApi#significadoCodigo");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dominio** | **String**| Dominio |
 **codigo** | **String**| Código |

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization

[AccessToken](../README.md#AccessToken), [RiskAppKey](../README.md#RiskAppKey)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Operación exitosa |  -  |
| **403** | Aplicación no autorizada |  -  |
| **401** | Operación no autorizada |  -  |
| **400** | Operación con error |  -  |
| **500** | Error inesperado |  -  |
| **501** | Servicio no implementado o inactivo |  -  |


## valorParametro

> DatoRespuesta valorParametro(parametro)

ValorParametro

Obtiene el valor de un parámetro

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.auth.*;
import org.openapitools.client.models.*;
import org.openapitools.client.api.GenApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("https://risk-project-api.azurewebsites.net");
        
        // Configure HTTP bearer authorization: AccessToken
        HttpBearerAuth AccessToken = (HttpBearerAuth) defaultClient.getAuthentication("AccessToken");
        AccessToken.setBearerToken("BEARER TOKEN");

        // Configure API key authorization: RiskAppKey
        ApiKeyAuth RiskAppKey = (ApiKeyAuth) defaultClient.getAuthentication("RiskAppKey");
        RiskAppKey.setApiKey("YOUR API KEY");
        // Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
        //RiskAppKey.setApiKeyPrefix("Token");

        GenApi apiInstance = new GenApi(defaultClient);
        String parametro = "parametro_example"; // String | Identificador del parámetro
        try {
            DatoRespuesta result = apiInstance.valorParametro(parametro);
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling GenApi#valorParametro");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **parametro** | **String**| Identificador del parámetro |

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization

[AccessToken](../README.md#AccessToken), [RiskAppKey](../README.md#RiskAppKey)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Operación exitosa |  -  |
| **403** | Aplicación no autorizada |  -  |
| **401** | Operación no autorizada |  -  |
| **400** | Operación con error |  -  |
| **500** | Error inesperado |  -  |
| **501** | Servicio no implementado o inactivo |  -  |


## versionSistema

> DatoRespuesta versionSistema()

VersionSistema

Obtiene la versión actual del sistema

### Example

```java
// Import classes:
import org.openapitools.client.ApiClient;
import org.openapitools.client.ApiException;
import org.openapitools.client.Configuration;
import org.openapitools.client.models.*;
import org.openapitools.client.api.GenApi;

public class Example {
    public static void main(String[] args) {
        ApiClient defaultClient = Configuration.getDefaultApiClient();
        defaultClient.setBasePath("https://risk-project-api.azurewebsites.net");

        GenApi apiInstance = new GenApi(defaultClient);
        try {
            DatoRespuesta result = apiInstance.versionSistema();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling GenApi#versionSistema");
            System.err.println("Status code: " + e.getCode());
            System.err.println("Reason: " + e.getResponseBody());
            System.err.println("Response headers: " + e.getResponseHeaders());
            e.printStackTrace();
        }
    }
}
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**DatoRespuesta**](DatoRespuesta.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Operación exitosa |  -  |
| **400** | Operación con error |  -  |
| **500** | Error inesperado |  -  |
| **501** | Servicio no implementado o inactivo |  -  |
