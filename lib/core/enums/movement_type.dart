/// MovementType enum representing cash movement types
enum MovementType {
  sale('sale'),
  refund('refund'),
  deposit('deposit'),
  withdrawal('withdrawal'),
  floatIn('float_in'),
  floatOut('float_out'),
  adjustment('adjustment');

  const MovementType(this.value);
  final String value;

  /// Convert from string value to enum
  static MovementType fromValue(String value) {
    return MovementType.values.firstWhere(
      (MovementType type) => type.value == value,
      orElse: () => MovementType.sale,
    );
  }

  /// Convert from string (alias for fromValue)
  static MovementType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if movement is sale
  bool get isSale => this == MovementType.sale;

  /// Check if movement is refund
  bool get isRefund => this == MovementType.refund;

  /// Check if movement is deposit
  bool get isDeposit => this == MovementType.deposit;

  /// Check if movement is withdrawal
  bool get isWithdrawal => this == MovementType.withdrawal;

  /// Check if movement is float in
  bool get isFloatIn => this == MovementType.floatIn;

  /// Check if movement is float out
  bool get isFloatOut => this == MovementType.floatOut;

  /// Check if movement is adjustment
  bool get isAdjustment => this == MovementType.adjustment;

  /// Check if movement increases cash (sale, deposit, float_in)
  bool get increasesCash => 
      this == MovementType.sale || 
      this == MovementType.deposit || 
      this == MovementType.floatIn;

  /// Check if movement decreases cash (refund, withdrawal, float_out)
  bool get decreasesCash => 
      this == MovementType.refund || 
      this == MovementType.withdrawal || 
      this == MovementType.floatOut;
}

/// Extension methods for MovementType
extension MovementTypeExtension on String {
  MovementType toMovementType() => MovementType.fromValue(this);
}