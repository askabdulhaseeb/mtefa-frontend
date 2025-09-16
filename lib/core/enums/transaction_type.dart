/// TransactionType enum representing sales transaction types
enum TransactionType {
  sale('sale'),
  returnTransaction('return'),
  exchange('exchange'),
  voidTransaction('void'),
  training('training');

  const TransactionType(this.value);
  final String value;

  /// Convert from string value to enum
  static TransactionType fromValue(String value) {
    return TransactionType.values.firstWhere(
      (TransactionType type) => type.value == value,
      orElse: () => TransactionType.sale,
    );
  }

  /// Convert from string (alias for fromValue)
  static TransactionType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the transaction type
  String get displayName {
    switch (this) {
      case TransactionType.sale:
        return 'Sale';
      case TransactionType.returnTransaction:
        return 'Return';
      case TransactionType.exchange:
        return 'Exchange';
      case TransactionType.voidTransaction:
        return 'Void';
      case TransactionType.training:
        return 'Training';
    }
  }

  /// Check if transaction is sale
  bool get isSale => this == TransactionType.sale;

  /// Check if transaction is return
  bool get isReturn => this == TransactionType.returnTransaction;

  /// Check if transaction is exchange
  bool get isExchange => this == TransactionType.exchange;

  /// Check if transaction is void
  bool get isVoid => this == TransactionType.voidTransaction;

  /// Check if transaction is training
  bool get isTraining => this == TransactionType.training;

  /// Check if transaction affects inventory
  bool get affectsInventory => 
      this == TransactionType.sale || 
      this == TransactionType.returnTransaction || 
      this == TransactionType.exchange;

  /// Check if transaction affects revenue
  bool get affectsRevenue => 
      this == TransactionType.sale || 
      this == TransactionType.returnTransaction || 
      this == TransactionType.exchange ||
      this == TransactionType.voidTransaction;

  /// Check if transaction is a reversal (return, void)
  bool get isReversal => 
      this == TransactionType.returnTransaction || 
      this == TransactionType.voidTransaction;

  /// Check if transaction counts for reporting
  bool get countsForReporting => 
      this != TransactionType.training;
}

/// Extension methods for TransactionType
extension TransactionTypeExtension on String {
  TransactionType toTransactionType() => TransactionType.fromValue(this);
}