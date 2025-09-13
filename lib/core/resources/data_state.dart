import 'package:equatable/equatable.dart';

/// Base class for handling data states in the application
/// Following the pattern described in CLAUDE.md
abstract class DataState<T> extends Equatable {
  const DataState({
    this.data,
    this.error,
    this.errorCode,
    this.statusCode,
    this.errorDetails,
  });

  final T? data;
  final String? error;
  final String? errorCode;
  final int? statusCode;
  final Map<String, dynamic>? errorDetails;

  /// Check if the state is a success state
  bool get isSuccess => this is DataSuccess<T>;

  /// Check if the state is a failed state
  bool get isFailed => this is DataFailed<T>;

  /// Check if the state is a loading state
  bool get isLoading => this is DataLoading<T>;

  /// Pattern matching for different states
  R when<R>({
    required R Function(T data) success,
    required R Function(
      String error,
      String? errorCode,
      int? statusCode,
      Map<String, dynamic>? errorDetails,
    )
    failed,
    required R Function() loading,
  }) {
    if (this is DataSuccess<T>) {
      return success((this as DataSuccess<T>).data);
    } else if (this is DataFailed<T>) {
      final DataFailed<T> failedState = this as DataFailed<T>;
      return failed(
        failedState.error,
        failedState.errorCode,
        failedState.statusCode,
        failedState.errorDetails,
      );
    } else if (this is DataLoading<T>) {
      return loading();
    }
    throw Exception('Unknown DataState type');
  }

  /// Optional pattern matching for different states
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(
      String error,
      String? errorCode,
      int? statusCode,
      Map<String, dynamic>? errorDetails,
    )?
    failed,
    R Function()? loading,
  }) {
    if (this is DataSuccess<T> && success != null) {
      return success((this as DataSuccess<T>).data);
    } else if (this is DataFailed<T> && failed != null) {
      final DataFailed<T> failedState = this as DataFailed<T>;
      return failed(
        failedState.error,
        failedState.errorCode,
        failedState.statusCode,
        failedState.errorDetails,
      );
    } else if (this is DataLoading<T> && loading != null) {
      return loading();
    }
    return null;
  }
}

/// Success state with data
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  T get data => super.data!;

  @override
  List<Object?> get props => <Object?>[data];
}

/// Failed state with error information
class DataFailed<T> extends DataState<T> {
  const DataFailed({
    required String super.error,
    super.errorCode,
    super.statusCode,
    super.errorDetails,
  });

  @override
  String get error => super.error!;

  @override
  List<Object?> get props => <Object?>[
    error,
    errorCode,
    statusCode,
    errorDetails,
  ];
}

/// Loading state
class DataLoading<T> extends DataState<T> {
  const DataLoading();

  @override
  List<Object?> get props => <Object?>[];
}
