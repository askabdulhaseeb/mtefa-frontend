/// PaymentMethod enum representing available payment methods
enum PaymentMethod {
  cash('cash'),
  card('card'),
  mobilePayment('mobile_payment'),
  bankTransfer('bank_transfer'),
  check('check'),
  storeCredit('store_credit'),
  loyaltyPoints('loyalty_points');

  const PaymentMethod(this.value);
  final String value;

  /// Convert from string value to enum
  static PaymentMethod fromValue(String value) {
    return PaymentMethod.values.firstWhere(
      (PaymentMethod method) => method.value == value,
      orElse: () => PaymentMethod.cash,
    );
  }

  /// Convert from string (alias for fromValue)
  static PaymentMethod fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the payment method
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.mobilePayment:
        return 'Mobile Payment';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.check:
        return 'Check';
      case PaymentMethod.storeCredit:
        return 'Store Credit';
      case PaymentMethod.loyaltyPoints:
        return 'Loyalty Points';
    }
  }

  /// Get icon name for the payment method
  String get iconName {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.card:
        return 'credit_card';
      case PaymentMethod.mobilePayment:
        return 'smartphone';
      case PaymentMethod.bankTransfer:
        return 'account_balance';
      case PaymentMethod.check:
        return 'receipt';
      case PaymentMethod.storeCredit:
        return 'card_giftcard';
      case PaymentMethod.loyaltyPoints:
        return 'stars';
    }
  }

  /// Check if payment method is cash
  bool get isCash => this == PaymentMethod.cash;

  /// Check if payment method is card
  bool get isCard => this == PaymentMethod.card;

  /// Check if payment method is mobile payment
  bool get isMobilePayment => this == PaymentMethod.mobilePayment;

  /// Check if payment method is bank transfer
  bool get isBankTransfer => this == PaymentMethod.bankTransfer;

  /// Check if payment method is check
  bool get isCheck => this == PaymentMethod.check;

  /// Check if payment method is store credit
  bool get isStoreCredit => this == PaymentMethod.storeCredit;

  /// Check if payment method is loyalty points
  bool get isLoyaltyPoints => this == PaymentMethod.loyaltyPoints;

  /// Check if payment method is electronic (card, mobile, bank transfer)
  bool get isElectronic => 
      this == PaymentMethod.card || 
      this == PaymentMethod.mobilePayment || 
      this == PaymentMethod.bankTransfer;

  /// Check if payment method requires physical handling (cash, check)
  bool get requiresPhysicalHandling => 
      this == PaymentMethod.cash || 
      this == PaymentMethod.check;

  /// Check if payment method is instant (cash, card, mobile)
  bool get isInstant => 
      this == PaymentMethod.cash || 
      this == PaymentMethod.card || 
      this == PaymentMethod.mobilePayment ||
      this == PaymentMethod.storeCredit ||
      this == PaymentMethod.loyaltyPoints;

  /// Check if payment method requires verification
  bool get requiresVerification => 
      this == PaymentMethod.check || 
      this == PaymentMethod.bankTransfer;
}

/// Extension methods for PaymentMethod
extension PaymentMethodExtension on String {
  PaymentMethod toPaymentMethod() => PaymentMethod.fromValue(this);
}