/// PaymentStatus enum representing payment transaction states
enum PaymentStatus {
  pending('pending'),
  processing('processing'),
  completed('completed'),
  failed('failed'),
  cancelled('cancelled'),
  refunded('refunded'),
  partiallyRefunded('partially_refunded');

  const PaymentStatus(this.value);
  final String value;

  /// Convert from string value to enum
  static PaymentStatus fromValue(String value) {
    return PaymentStatus.values.firstWhere(
      (PaymentStatus status) => status.value == value,
      orElse: () => PaymentStatus.pending,
    );
  }

  /// Convert from string (alias for fromValue)
  static PaymentStatus fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the payment status
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.partiallyRefunded:
        return 'Partially Refunded';
    }
  }

  /// Get color for the payment status (as hex string)
  String get colorHex {
    switch (this) {
      case PaymentStatus.pending:
        return '#FFA500'; // Orange
      case PaymentStatus.processing:
        return '#2196F3'; // Blue
      case PaymentStatus.completed:
        return '#4CAF50'; // Green
      case PaymentStatus.failed:
        return '#F44336'; // Red
      case PaymentStatus.cancelled:
        return '#9E9E9E'; // Grey
      case PaymentStatus.refunded:
        return '#FF9800'; // Deep Orange
      case PaymentStatus.partiallyRefunded:
        return '#FF5722'; // Deep Orange variant
    }
  }

  /// Check if payment is pending
  bool get isPending => this == PaymentStatus.pending;

  /// Check if payment is processing
  bool get isProcessing => this == PaymentStatus.processing;

  /// Check if payment is completed
  bool get isCompleted => this == PaymentStatus.completed;

  /// Check if payment is failed
  bool get isFailed => this == PaymentStatus.failed;

  /// Check if payment is cancelled
  bool get isCancelled => this == PaymentStatus.cancelled;

  /// Check if payment is refunded
  bool get isRefunded => this == PaymentStatus.refunded;

  /// Check if payment is partially refunded
  bool get isPartiallyRefunded => this == PaymentStatus.partiallyRefunded;

  /// Check if payment is in progress (pending or processing)
  bool get isInProgress => 
      this == PaymentStatus.pending || 
      this == PaymentStatus.processing;

  /// Check if payment is final (completed, failed, cancelled, refunded)
  bool get isFinal => 
      this == PaymentStatus.completed || 
      this == PaymentStatus.failed || 
      this == PaymentStatus.cancelled || 
      this == PaymentStatus.refunded ||
      this == PaymentStatus.partiallyRefunded;

  /// Check if payment was successful
  bool get isSuccessful => 
      this == PaymentStatus.completed;

  /// Check if payment has refund (refunded or partially refunded)
  bool get hasRefund => 
      this == PaymentStatus.refunded || 
      this == PaymentStatus.partiallyRefunded;
}

/// Extension methods for PaymentStatus
extension PaymentStatusExtension on String {
  PaymentStatus toPaymentStatus() => PaymentStatus.fromValue(this);
}