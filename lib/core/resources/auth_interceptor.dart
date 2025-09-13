import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../utils/token_manager.dart';
import 'api_client.dart';

/// Authentication interceptor for handling token refresh
class AuthInterceptor implements ResponseInterceptor {
  AuthInterceptor({TokenManager? tokenManager, http.Client? httpClient})
    : _tokenManager = tokenManager ?? TokenManager(),
      _httpClient = httpClient ?? http.Client();

  final TokenManager _tokenManager;
  final http.Client _httpClient;
  bool _isRefreshing = false;

  @override
  Future<http.Response> onResponse(http.Response response) async {
    // Check if response is 401 (Unauthorized)
    if (response.statusCode == 401 && !_isRefreshing) {
      // Try to refresh token
      final bool refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the original request with new token
        final String? newToken = await _tokenManager.getAccessToken();
        if (newToken != null) {
          // Create new request with updated token
          final Map<String, String> headers = Map<String, String>.from(
            response.request?.headers ?? <dynamic, dynamic>{},
          );
          headers['Authorization'] = 'Bearer $newToken';

          // Retry the request
          final http.Response retriedResponse = await _retryRequest(
            response.request as http.BaseRequest,
            headers,
          );

          return retriedResponse;
        }
      } else {
        // Refresh failed, clear tokens and redirect to login
        await _tokenManager.clearTokens();
        // You might want to emit an event here to trigger navigation to login
      }
    }

    return response;
  }

  /// Refresh the authentication token
  Future<bool> _refreshToken() async {
    if (_isRefreshing) return false;

    _isRefreshing = true;

    try {
      final String? refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) {
        _isRefreshing = false;
        return false;
      }

      // Make refresh token request
      final Uri uri = Uri.parse('${ApiConfig.instance.baseUrl}/auth/refresh');
      final http.Response response = await _httpClient
          .post(
            uri,
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, String>{'refreshToken': refreshToken}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['success'] == true) {
          final dynamic tokens = responseData['data']['tokens'];

          // Save new tokens
          await _tokenManager.saveTokens(
            accessToken: tokens['accessToken'],
            refreshToken: tokens['refreshToken'],
            expiresIn: tokens['expiresIn'],
          );

          _isRefreshing = false;
          return true;
        }
      }

      _isRefreshing = false;
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Token refresh failed: $e');
      }
      _isRefreshing = false;
      return false;
    }
  }

  /// Retry the original request with new headers
  Future<http.Response> _retryRequest(
    http.BaseRequest originalRequest,
    Map<String, String> headers,
  ) async {
    // Create new request based on the original
    if (originalRequest is http.Request) {
      final http.Request request =
          http.Request(originalRequest.method, originalRequest.url)
            ..headers.addAll(headers)
            ..body = originalRequest.body;

      final http.StreamedResponse streamedResponse = await _httpClient.send(
        request,
      );
      return http.Response.fromStream(streamedResponse);
    }

    // For other request types, just return the original response
    // This shouldn't happen in normal usage
    throw UnsupportedError('Unsupported request type for retry');
  }
}

/// Rate limit interceptor for handling rate limiting
class RateLimitInterceptor implements ResponseInterceptor {
  final Map<String, DateTime> _rateLimitMap = <String, DateTime>{};

  @override
  Future<http.Response> onResponse(http.Response response) async {
    // Check if response is 429 (Too Many Requests)
    if (response.statusCode == 429) {
      // Extract retry-after header
      final String? retryAfterHeader = response.headers['retry-after'];

      if (retryAfterHeader != null) {
        final int? retryAfter = int.tryParse(retryAfterHeader);

        if (retryAfter != null) {
          // Store rate limit information
          final String? endpoint = response.request?.url.path;
          if (endpoint != null) {
            _rateLimitMap[endpoint] = DateTime.now().add(
              Duration(seconds: retryAfter),
            );
          }

          // You might want to emit an event here to show rate limit message
          if (kDebugMode) {
            debugPrint('Rate limited. Retry after $retryAfter seconds');
          }
        }
      }
    }

    return response;
  }

  /// Check if an endpoint is rate limited
  bool isRateLimited(String endpoint) {
    final DateTime? rateLimitTime = _rateLimitMap[endpoint];
    if (rateLimitTime == null) return false;

    if (DateTime.now().isAfter(rateLimitTime)) {
      _rateLimitMap.remove(endpoint);
      return false;
    }

    return true;
  }

  /// Get remaining time for rate limit
  Duration? getRemainingTime(String endpoint) {
    final DateTime? rateLimitTime = _rateLimitMap[endpoint];
    if (rateLimitTime == null) return null;

    final Duration remaining = rateLimitTime.difference(DateTime.now());
    if (remaining.isNegative) {
      _rateLimitMap.remove(endpoint);
      return null;
    }

    return remaining;
  }
}

/// Logging interceptor for debugging
class LoggingInterceptor implements RequestInterceptor, ResponseInterceptor {
  LoggingInterceptor({this.enableLogging = true});
  final bool enableLogging;

  @override
  Future<RequestInterceptorResult> onRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    if (enableLogging && kDebugMode) {
      debugPrint('===> REQUEST [$method] $uri');
      debugPrint('Headers: $headers');
      if (body != null) {
        debugPrint('Body: ${jsonEncode(body)}');
      }
    }

    return RequestInterceptorResult(headers: headers, body: body);
  }

  @override
  Future<http.Response> onResponse(http.Response response) async {
    if (enableLogging && kDebugMode) {
      debugPrint(
        '<=== RESPONSE [${response.statusCode}] ${response.request?.url}',
      );
      debugPrint('Headers: ${response.headers}');
      if (response.body.isNotEmpty) {
        try {
          final dynamic jsonBody = jsonDecode(response.body);
          debugPrint(
            'Body: ${const JsonEncoder.withIndent('  ').convert(jsonBody)}',
          );
        } catch (_) {
          debugPrint('Body: ${response.body}');
        }
      }
    }

    return response;
  }
}
