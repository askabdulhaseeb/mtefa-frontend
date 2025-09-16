import 'dart:math';

/// Calculation utilities for inventory form
class InventoryCalculations {
  
  /// Calculate profit margin percentage
  static double calculateProfitMargin(double costPrice, double sellingPrice) {
    if (costPrice <= 0 || sellingPrice <= 0) return 0.0;
    return ((sellingPrice - costPrice) / sellingPrice) * 100;
  }

  /// Calculate markup percentage
  static double calculateMarkup(double costPrice, double sellingPrice) {
    if (costPrice <= 0) return 0.0;
    return ((sellingPrice - costPrice) / costPrice) * 100;
  }

  /// Calculate selling price from cost and margin
  static double calculateSellingPriceFromMargin(double costPrice, double marginPercent) {
    if (costPrice <= 0 || marginPercent <= 0) return costPrice;
    return costPrice / (1 - marginPercent / 100);
  }

  /// Calculate selling price from cost and markup
  static double calculateSellingPriceFromMarkup(double costPrice, double markupPercent) {
    if (costPrice <= 0) return 0.0;
    return costPrice * (1 + markupPercent / 100);
  }

  /// Calculate VAT amount
  static double calculateVATAmount(double amount, double vatPercent) {
    if (amount <= 0 || vatPercent <= 0) return 0.0;
    return amount * (vatPercent / 100);
  }

  /// Calculate price including VAT
  static double calculatePriceWithVAT(double price, double vatPercent) {
    return price + calculateVATAmount(price, vatPercent);
  }

  /// Calculate price excluding VAT
  static double calculatePriceExcludingVAT(double priceWithVAT, double vatPercent) {
    if (priceWithVAT <= 0 || vatPercent <= 0) return priceWithVAT;
    return priceWithVAT / (1 + vatPercent / 100);
  }

  /// Generate product code
  static String generateProductCode(String? category, String? lineItem) {
    final String categoryPrefix = _getCategoryPrefix(category);
    final String lineItemPrefix = _getLineItemPrefix(lineItem);
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final String randomSuffix = (Random().nextInt(99) + 1).toString().padLeft(2, '0');
    
    return '$categoryPrefix$lineItemPrefix$timestamp$randomSuffix';
  }

  /// Get category prefix for product code
  static String _getCategoryPrefix(String? category) {
    if (category == null) return 'GEN';
    
    switch (category) {
      case 'Electronics':
        return 'ELE';
      case 'Clothing':
        return 'CLO';
      case 'Food & Beverages':
        return 'FOO';
      case 'Home & Garden':
        return 'HOM';
      case 'Health & Beauty':
        return 'HEA';
      case 'Books & Media':
        return 'BOO';
      case 'Sports & Outdoor':
        return 'SPO';
      case 'Toys & Games':
        return 'TOY';
      case 'Automotive':
        return 'AUT';
      case 'Office Supplies':
        return 'OFF';
      default:
        return 'GEN';
    }
  }

  /// Get line item prefix for product code
  static String _getLineItemPrefix(String? lineItem) {
    if (lineItem == null) return 'P';
    
    switch (lineItem) {
      case 'Physical Product':
        return 'P';
      case 'Digital Product':
        return 'D';
      case 'Service':
        return 'S';
      case 'Bundle':
        return 'B';
      case 'Raw Material':
        return 'R';
      case 'Finished Goods':
        return 'F';
      case 'Work in Progress':
        return 'W';
      case 'Consignment':
        return 'C';
      default:
        return 'P';
    }
  }

  /// Validate numeric input
  static String? validateNumericInput(String? value, {
    required String fieldName,
    bool required = false,
    double? minValue,
    double? maxValue,
  }) {
    if (value == null || value.trim().isEmpty) {
      return required ? '$fieldName is required' : null;
    }

    final double? numericValue = double.tryParse(value.trim());
    if (numericValue == null) {
      return '$fieldName must be a valid number';
    }

    if (minValue != null && numericValue < minValue) {
      return '$fieldName must be at least $minValue';
    }

    if (maxValue != null && numericValue > maxValue) {
      return '$fieldName must not exceed $maxValue';
    }

    return null;
  }

  /// Validate price input
  static String? validatePrice(String? value, {
    required String fieldName,
    bool required = false,
    bool allowZero = false,
  }) {
    return validateNumericInput(
      value,
      fieldName: fieldName,
      required: required,
      minValue: allowZero ? 0.0 : 0.01,
      maxValue: 999999999.99,
    );
  }

  /// Validate percentage input
  static String? validatePercentage(String? value, {
    required String fieldName,
    bool required = false,
  }) {
    return validateNumericInput(
      value,
      fieldName: fieldName,
      required: required,
      minValue: 0.0,
      maxValue: 100.0,
    );
  }

  /// Validate stock level input
  static String? validateStockLevel(String? value, {
    required String fieldName,
    bool required = false,
  }) {
    return validateNumericInput(
      value,
      fieldName: fieldName,
      required: required,
      minValue: 0.0,
      maxValue: 999999999.0,
    );
  }

  /// Format currency display
  static String formatCurrency(double amount, {String currency = 'PKR'}) {
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  /// Format percentage display
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(2)}%';
  }

  /// Round to 2 decimal places
  static double roundToTwoDecimals(double value) {
    return (value * 100).round() / 100;
  }

  /// Check if profit margin is healthy
  static bool isHealthyProfitMargin(double margin) {
    return margin >= 20.0; // At least 20% margin is considered healthy
  }

  /// Get profit margin status
  static String getProfitMarginStatus(double margin) {
    if (margin < 10) return 'Low';
    if (margin < 20) return 'Moderate';
    if (margin < 40) return 'Good';
    return 'Excellent';
  }
}