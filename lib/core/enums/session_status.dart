/// SessionStatus enum representing cashier session states
enum SessionStatus {
  active('active'),
  suspended('suspended'),
  closed('closed');

  const SessionStatus(this.value);
  final String value;

  /// Convert from string value to enum
  static SessionStatus fromValue(String value) {
    return SessionStatus.values.firstWhere(
      (SessionStatus type) => type.value == value,
      orElse: () => SessionStatus.closed,
    );
  }

  /// Convert from string (alias for fromValue)
  static SessionStatus fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if session is active
  bool get isActive => this == SessionStatus.active;

  /// Check if session is suspended
  bool get isSuspended => this == SessionStatus.suspended;

  /// Check if session is closed
  bool get isClosed => this == SessionStatus.closed;

  /// Check if session is open (active or suspended)
  bool get isOpen => this == SessionStatus.active || this == SessionStatus.suspended;
}

/// Extension methods for SessionStatus
extension SessionStatusExtension on String {
  SessionStatus toSessionStatus() => SessionStatus.fromValue(this);
}