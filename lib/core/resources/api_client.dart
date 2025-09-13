import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../error/exceptions.dart';
import '../utils/token_manager.dart';
import 'data_state.dart';

/// Base API client using http package with comprehensive error handling
class ApiClient {
  ApiClient({
    http.Client? httpClient,
    TokenManager? tokenManager,
    Connectivity? connectivity,
  }) : _httpClient = httpClient ?? http.Client(),
       _tokenManager = tokenManager ?? TokenManager(),
       _connectivity = connectivity ?? Connectivity();
       
  final http.Client _httpClient;
  final TokenManager _tokenManager;
  final Connectivity _connectivity;

  // Request interceptors
  final List<RequestInterceptor> _requestInterceptors = <RequestInterceptor>[];
  final List<ResponseInterceptor> _responseInterceptors =
      <ResponseInterceptor>[];

  /// Add request interceptor
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
  }

  /// Add response interceptor
  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
  }

  /// GET request
  Future<DataState<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    return _performRequest<T>(
      method: 'GET',
      endpoint: endpoint,
      headers: headers,
      queryParameters: queryParameters,
      fromJson: fromJson,
      timeout: timeout,
    );
  }

  /// POST request
  Future<DataState<T>> post<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    return _performRequest<T>(
      method: 'POST',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      fromJson: fromJson,
      timeout: timeout,
    );
  }

  /// PUT request
  Future<DataState<T>> put<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    return _performRequest<T>(
      method: 'PUT',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      fromJson: fromJson,
      timeout: timeout,
    );
  }

  /// PATCH request
  Future<DataState<T>> patch<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    return _performRequest<T>(
      method: 'PATCH',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      fromJson: fromJson,
      timeout: timeout,
    );
  }

  /// DELETE request
  Future<DataState<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    return _performRequest<T>(
      method: 'DELETE',
      endpoint: endpoint,
      headers: headers,
      queryParameters: queryParameters,
      fromJson: fromJson,
      timeout: timeout,
    );
  }

  /// Perform the actual HTTP request
  Future<DataState<T>> _performRequest<T>({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? timeout,
  }) async {
    try {
      // Check network connectivity
      await _checkConnectivity();

      // Build URL
      final Uri uri = _buildUri(endpoint, queryParameters);

      // Build headers
      final Map<String, String> requestHeaders = await _buildHeaders(headers);

      // Apply request interceptors
      Map<String, String> finalHeaders = requestHeaders;
      Map<String, dynamic>? finalBody = body;
      for (final RequestInterceptor interceptor in _requestInterceptors) {
        final RequestInterceptorResult result = await interceptor.onRequest(
          method: method,
          uri: uri,
          headers: finalHeaders,
          body: finalBody,
        );
        finalHeaders = result.headers;
        finalBody = result.body;
      }

      // Create request
      http.Response response;
      final Duration requestTimeout =
          timeout ?? ApiConfig.instance.receiveTimeout;

      switch (method) {
        case 'GET':
          response = await _httpClient
              .get(uri, headers: finalHeaders)
              .timeout(requestTimeout);
          break;
        case 'POST':
          response = await _httpClient
              .post(
                uri,
                headers: finalHeaders,
                body: finalBody != null ? jsonEncode(finalBody) : null,
              )
              .timeout(requestTimeout);
          break;
        case 'PUT':
          response = await _httpClient
              .put(
                uri,
                headers: finalHeaders,
                body: finalBody != null ? jsonEncode(finalBody) : null,
              )
              .timeout(requestTimeout);
          break;
        case 'PATCH':
          response = await _httpClient
              .patch(
                uri,
                headers: finalHeaders,
                body: finalBody != null ? jsonEncode(finalBody) : null,
              )
              .timeout(requestTimeout);
          break;
        case 'DELETE':
          response = await _httpClient
              .delete(uri, headers: finalHeaders)
              .timeout(requestTimeout);
          break;
        default:
          throw UnsupportedError('Method $method not supported');
      }

      // Apply response interceptors
      for (final ResponseInterceptor interceptor in _responseInterceptors) {
        response = await interceptor.onResponse(response);
      }

      // Handle response
      return _handleResponse<T>(response, fromJson);
    } on TimeoutException {
      return DataFailed<T>(
        error: 'Request timeout',
        errorCode: 'TIMEOUT_ERROR',
      );
    } on SocketException {
      return DataFailed<T>(
        error: 'Network connection failed',
        errorCode: 'NETWORK_ERROR',
      );
    } on FormatException {
      return DataFailed<T>(
        error: 'Invalid response format',
        errorCode: 'FORMAT_ERROR',
      );
    } on AppException catch (e) {
      return DataFailed<T>(
        error: e.message,
        errorCode: e.code,
        statusCode: e.statusCode,
        errorDetails: e.details,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Unexpected error: $e');
      }
      return DataFailed<T>(
        error: 'An unexpected error occurred',
        errorCode: 'UNKNOWN_ERROR',
        errorDetails: <String, dynamic>{'originalError': e.toString()},
      );
    }
  }

  /// Check network connectivity
  Future<void> _checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await _connectivity
        .checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw const NetworkException();
    }
  }

  /// Build URI with query parameters
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final String baseUrl = ApiConfig.instance.baseUrl;
    final String path = endpoint.startsWith('/') ? endpoint : '/$endpoint';

    // Convert query parameters to string map
    final Map<String, String> queryParams = <String, String>{};
    queryParameters?.forEach((String key, dynamic value) {
      if (value != null) {
        queryParams[key] = value.toString();
      }
    });

    final Uri uri = Uri.parse('$baseUrl$path');
    if (queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  /// Build request headers
  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? headers,
  ) async {
    final Map<String, String> requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Flutter Mobile App v1.0.0',
      ...?headers,
    };

    // Add authorization header if available
    final String? token = await _tokenManager.getAccessToken();
    if (token != null) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    return requestHeaders;
  }

  /// Handle HTTP response
  DataState<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    // Log response in debug mode
    if (kDebugMode && ApiConfig.instance.enableLogging) {
      debugPrint('Response [${response.statusCode}]: ${response.body}');
    }

    // Handle successful responses
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return DataSuccess<T>(null as T);
      }

      final Map<String, dynamic> jsonData =
          jsonDecode(response.body) as Map<String, dynamic>;

      // Check if response indicates success
      if (jsonData['success'] == true) {
        final dynamic data = jsonData['data'];
        if (fromJson != null && data != null) {
          return DataSuccess<T>(fromJson(data as Map<String, dynamic>));
        }
        return DataSuccess<T>(data as T);
      } else {
        // API returned success: false
        return _handleErrorResponse(jsonData, response.statusCode);
      }
    }

    // Handle error responses
    try {
      final Map<String, dynamic> errorData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return _handleErrorResponse(errorData, response.statusCode);
    } catch (_) {
      // Failed to parse error response
      return DataFailed<T>(
        error: _getErrorMessageForStatusCode(response.statusCode),
        errorCode: _getErrorCodeForStatusCode(response.statusCode),
        statusCode: response.statusCode,
      );
    }
  }

  /// Handle error response from API
  DataState<T> _handleErrorResponse<T>(
    Map<String, dynamic> errorData,
    int statusCode,
  ) {
    final dynamic error = errorData['error'];
    if (error is Map<String, dynamic>) {
      return DataFailed<T>(
        error: error['message'] ?? 'Request failed',
        errorCode: error['code'],
        statusCode: error['statusCode'] ?? statusCode,
        errorDetails: error['details'] as Map<String, dynamic>?,
      );
    }

    return DataFailed<T>(
      error: errorData['message'] ?? 'Request failed',
      errorCode: errorData['code'],
      statusCode: statusCode,
    );
  }

  /// Get error message for status code
  String _getErrorMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 429:
        return 'Too many requests';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Request failed';
    }
  }

  /// Get error code for status code
  String _getErrorCodeForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'BAD_REQUEST';
      case 401:
        return 'UNAUTHORIZED';
      case 403:
        return 'FORBIDDEN';
      case 404:
        return 'NOT_FOUND';
      case 429:
        return 'RATE_LIMIT_EXCEEDED';
      case 500:
        return 'INTERNAL_SERVER_ERROR';
      case 502:
        return 'BAD_GATEWAY';
      case 503:
        return 'SERVICE_UNAVAILABLE';
      default:
        return 'HTTP_ERROR';
    }
  }

  /// Dispose of resources
  void dispose() {
    _httpClient.close();
  }
}

/// Request interceptor interface
abstract class RequestInterceptor {
  Future<RequestInterceptorResult> onRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  });
}

/// Response interceptor interface
abstract class ResponseInterceptor {
  Future<http.Response> onResponse(http.Response response);
}

/// Request interceptor result
class RequestInterceptorResult {
  RequestInterceptorResult({required this.headers, this.body});
  final Map<String, String> headers;
  final Map<String, dynamic>? body;
}
