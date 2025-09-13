import 'dart:async';
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../entities/pagination_info.dart';
import '../error/failures.dart';
import '../utils/token_manager.dart';
import 'api_client.dart';
import 'auth_interceptor.dart';
import 'data_state.dart';

/// Base API service that can be extended for specific services
abstract class BaseApiService {
  BaseApiService({ApiClient? apiClient, TokenManager? tokenManager})
    : _tokenManager = tokenManager ?? TokenManager() {
    _apiClient = apiClient ?? ApiClient(tokenManager: _tokenManager);
    _setupInterceptors();
  }
  late final ApiClient _apiClient;
  final TokenManager _tokenManager;

  /// Get the API client instance
  @protected
  ApiClient get apiClient => _apiClient;

  /// Get the token manager instance
  @protected
  TokenManager get tokenManager => _tokenManager;

  /// Setup interceptors
  void _setupInterceptors() {
    // Add authentication interceptor
    _apiClient.addResponseInterceptor(
      AuthInterceptor(tokenManager: _tokenManager),
    );

    // Add rate limit interceptor
    _apiClient.addResponseInterceptor(RateLimitInterceptor());

    // Add logging interceptor in debug mode
    if (kDebugMode && ApiConfig.instance.enableLogging) {
      final LoggingInterceptor loggingInterceptor = LoggingInterceptor();
      _apiClient.addRequestInterceptor(loggingInterceptor);
      _apiClient.addResponseInterceptor(loggingInterceptor);
    }
  }

  /// Execute a function with error handling
  @protected
  Future<DataState<T>> execute<T>(
    Future<DataState<T>> Function() operation,
  ) async {
    try {
      return await operation();
    } catch (e) {
      if (kDebugMode) {
        print('Error in ${runtimeType.toString()}: $e');
      }
      return DataFailed<T>(
        error: 'An unexpected error occurred',
        errorCode: 'EXECUTION_ERROR',
        errorDetails: <String, dynamic>{'error': e.toString()},
      );
    }
  }

  /// Convert DataState to Failure for repository pattern
  @protected
  Failure dataStateToFailure<T>(DataFailed<T> dataFailed) {
    final String? errorCode = dataFailed.errorCode;
    final int? statusCode = dataFailed.statusCode;

    // Map to specific failure types
    if (errorCode == 'NETWORK_ERROR') {
      return NetworkFailure(message: dataFailed.error);
    }

    if (errorCode == 'AUTH_ERROR' || statusCode == 401) {
      return AuthenticationFailure(
        message: dataFailed.error,
        code: errorCode,
        statusCode: statusCode,
      );
    }

    if (errorCode == 'VALIDATION_ERROR' || statusCode == 400) {
      return ValidationFailure(
        message: dataFailed.error,
        code: errorCode,
        details: dataFailed.errorDetails,
      );
    }

    if (errorCode == 'RATE_LIMIT_EXCEEDED' || statusCode == 429) {
      return RateLimitFailure(
        message: dataFailed.error,
        code: errorCode,
        retryAfter: dataFailed.errorDetails?['retryAfter'],
      );
    }

    if (errorCode == 'TIMEOUT_ERROR') {
      return TimeoutFailure(message: dataFailed.error);
    }

    // Default to server failure
    return ServerFailure(
      message: dataFailed.error,
      code: errorCode,
      statusCode: statusCode,
      details: dataFailed.errorDetails,
    );
  }

  /// Parse pagination information from response
  @protected
  PaginationInfo? parsePagination(Map<String, dynamic>? data) {
    if (data == null || !data.containsKey('pagination')) return null;

    final dynamic pagination = data['pagination'];
    if (pagination is! Map<String, dynamic>) return null;

    return PaginationInfo(
      currentPage: pagination['currentPage'] ?? pagination['page'] ?? 1,
      totalPages: pagination['totalPages'] ?? 1,
      totalItems: pagination['totalItems'] ?? pagination['total'] ?? 0,
      hasNext: pagination['hasNext'] ?? pagination['hasMore'] ?? false,
      hasPrev: pagination['hasPrev'] ?? false,
      limit: pagination['limit'] ?? 10,
    );
  }

  /// Build query parameters with null safety
  @protected
  Map<String, dynamic> buildQueryParams({
    int? page,
    int? limit,
    String? search,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) {
    final Map<String, dynamic> params = <String, dynamic>{};

    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (sortBy != null && sortBy.isNotEmpty) params['sortBy'] = sortBy;
    if (sortOrder != null && sortOrder.isNotEmpty) {
      params['sortOrder'] = sortOrder;
    }

    // Add custom filters
    if (filters != null) {
      filters.forEach((String key, dynamic value) {
        if (value != null) {
          params[key] = value;
        }
      });
    }

    return params;
  }

  /// Dispose of resources
  void dispose() {
    _apiClient.dispose();
  }
}
