import 'package:equatable/equatable.dart';

/// Base failure class for handling errors in the application
abstract class Failure extends Equatable {
  const Failure({
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
  List<Object?> get props => <Object?>[message, code, statusCode, details];
}

/// Server failure for API errors
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.statusCode,
    super.details,
  });
}

/// Network failure for connection errors
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network connection failed',
    super.code = 'NETWORK_ERROR',
  });
}

/// Cache failure for local storage errors
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache operation failed',
    super.code = 'CACHE_ERROR',
  });
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    super.message = 'Authentication failed',
    super.code = 'AUTH_ERROR',
    super.statusCode,
  });
}

/// Validation failure for input errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
  });
}

/// Rate limit failure
class RateLimitFailure extends Failure {
  const RateLimitFailure({
    super.message = 'Too many requests',
    super.code = 'RATE_LIMIT_EXCEEDED',
    this.retryAfter,
  }) : super(statusCode: 429);
  final int? retryAfter;

  @override
  List<Object?> get props => <Object?>[message, code, statusCode, retryAfter];
}

/// Timeout failure
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timeout',
    super.code = 'TIMEOUT_ERROR',
  });
}

/// Unknown failure for unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred',
    super.code = 'UNKNOWN_ERROR',
  });
}
