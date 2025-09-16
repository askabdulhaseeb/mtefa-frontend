/// PromotionType enum representing promotion campaign types
enum PromotionType {
  percentage('percentage'),
  fixedAmount('fixed_amount'),
  buyXGetY('buy_x_get_y'),
  freeShipping('free_shipping'),
  loyaltyBonus('loyalty_bonus');

  const PromotionType(this.value);
  final String value;

  /// Convert from string value to enum
  static PromotionType fromValue(String value) {
    return PromotionType.values.firstWhere(
      (PromotionType type) => type.value == value,
      orElse: () => PromotionType.percentage,
    );
  }

  /// Convert from string (alias for fromValue)
  static PromotionType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the promotion type
  String get displayName {
    switch (this) {
      case PromotionType.percentage:
        return 'Percentage Discount';
      case PromotionType.fixedAmount:
        return 'Fixed Amount Off';
      case PromotionType.buyXGetY:
        return 'Buy X Get Y';
      case PromotionType.freeShipping:
        return 'Free Shipping';
      case PromotionType.loyaltyBonus:
        return 'Loyalty Bonus';
    }
  }

  /// Get short display name for the promotion type
  String get shortDisplayName {
    switch (this) {
      case PromotionType.percentage:
        return '% Off';
      case PromotionType.fixedAmount:
        return 'Amount Off';
      case PromotionType.buyXGetY:
        return 'BOGO';
      case PromotionType.freeShipping:
        return 'Free Ship';
      case PromotionType.loyaltyBonus:
        return 'Loyalty';
    }
  }

  /// Get icon name for the promotion type
  String get iconName {
    switch (this) {
      case PromotionType.percentage:
        return 'percent';
      case PromotionType.fixedAmount:
        return 'attach_money';
      case PromotionType.buyXGetY:
        return 'add_shopping_cart';
      case PromotionType.freeShipping:
        return 'local_shipping';
      case PromotionType.loyaltyBonus:
        return 'star';
    }
  }

  /// Check if promotion is percentage
  bool get isPercentage => this == PromotionType.percentage;

  /// Check if promotion is fixed amount
  bool get isFixedAmount => this == PromotionType.fixedAmount;

  /// Check if promotion is buy X get Y
  bool get isBuyXGetY => this == PromotionType.buyXGetY;

  /// Check if promotion is free shipping
  bool get isFreeShipping => this == PromotionType.freeShipping;

  /// Check if promotion is loyalty bonus
  bool get isLoyaltyBonus => this == PromotionType.loyaltyBonus;

  /// Check if promotion is a discount (percentage or fixed amount)
  bool get isDiscount => 
      this == PromotionType.percentage || 
      this == PromotionType.fixedAmount;

  /// Check if promotion requires quantity calculation
  bool get requiresQuantityCalculation => 
      this == PromotionType.buyXGetY;

  /// Check if promotion affects shipping
  bool get affectsShipping => 
      this == PromotionType.freeShipping;

  /// Check if promotion requires loyalty membership
  bool get requiresLoyalty => 
      this == PromotionType.loyaltyBonus;
}

/// Extension methods for PromotionType
extension PromotionTypeExtension on String {
  PromotionType toPromotionType() => PromotionType.fromValue(this);
}