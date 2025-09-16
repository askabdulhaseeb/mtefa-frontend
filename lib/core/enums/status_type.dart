/// StatusType enum representing entity status states
enum StatusType {
  active('active'),
  blocked('blocked'),
  deleted('deleted');

  const StatusType(this.value);
  final String value;

  /// Convert from string value to enum
  static StatusType fromValue(String value) {
    return StatusType.values.firstWhere(
      (StatusType type) => type.value == value,
      orElse: () => StatusType.active,
    );
  }

  /// Convert from string (alias for fromValue)
  static StatusType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if status is active
  bool get isActive => this == StatusType.active;

  /// Check if status is blocked
  bool get isBlocked => this == StatusType.blocked;

  /// Check if status is deleted
  bool get isDeleted => this == StatusType.deleted;
}

/// Extension methods for StatusType
extension StatusTypeExtension on String {
  StatusType toStatusType() => StatusType.fromValue(this);
}