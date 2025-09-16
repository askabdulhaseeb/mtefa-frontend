/// ReconciliationStatus enum representing cash reconciliation states
enum ReconciliationStatus {
  balanced('balanced'),
  over('over'),
  short('short');

  const ReconciliationStatus(this.value);
  final String value;

  /// Convert from string value to enum
  static ReconciliationStatus fromValue(String value) {
    return ReconciliationStatus.values.firstWhere(
      (ReconciliationStatus type) => type.value == value,
      orElse: () => ReconciliationStatus.balanced,
    );
  }

  /// Convert from string (alias for fromValue)
  static ReconciliationStatus fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if reconciliation is balanced
  bool get isBalanced => this == ReconciliationStatus.balanced;

  /// Check if reconciliation is over
  bool get isOver => this == ReconciliationStatus.over;

  /// Check if reconciliation is short
  bool get isShort => this == ReconciliationStatus.short;

  /// Check if reconciliation has discrepancy
  bool get hasDiscrepancy => this != ReconciliationStatus.balanced;
}

/// Extension methods for ReconciliationStatus
extension ReconciliationStatusExtension on String {
  ReconciliationStatus toReconciliationStatus() => ReconciliationStatus.fromValue(this);
}