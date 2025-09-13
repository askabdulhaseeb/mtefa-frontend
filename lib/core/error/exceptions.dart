/// Base exception class for the application
class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.statusCode,
    this.details,
  });
  final String message;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;

  @override
  String toString() =>
      'AppException: $message (code: $code, status: $statusCode)';
}

/// Server exception for API errors
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Network exception for connection errors
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network connection failed',
    super.code = 'NETWORK_ERROR',
  });
}

/// Cache exception for local storage errors
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache operation failed',
    super.code = 'CACHE_ERROR',
  });
}

/// Authentication exception
class AuthenticationException extends AppException {
  const AuthenticationException({
    super.message = 'Authentication failed',
    super.code = 'AUTH_ERROR',
    super.statusCode = 401,
  });
}

/// Token expired exception
class TokenExpiredException extends AuthenticationException {
  const TokenExpiredException({
    super.message = 'Token has expired',
    super.code = 'TOKEN_EXPIRED',
  });
}

/// Rate limit exception
class RateLimitException extends AppException {
  const RateLimitException({
    super.message = 'Too many requests',
    super.code = 'RATE_LIMIT_EXCEEDED',
    this.retryAfter,
  }) : super(statusCode: 429);
  final int? retryAfter;
}

/// Timeout exception
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timeout',
    super.code = 'TIMEOUT_ERROR',
  });
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
  });
}
