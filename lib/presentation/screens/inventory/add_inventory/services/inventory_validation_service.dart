/// Inventory form validation service
class InventoryValidationService {
  /// Validate product code
  static String? validateProductCode(String? value, bool autoGenerate) {
    if (!autoGenerate && (value?.isEmpty ?? true)) {
      return 'Product code is required';
    }
    return null;
  }

  /// Validate product name
  static String? validateProductName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Product name is required';
    }
    if (value!.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  /// Validate average cost
  static String? validateAverageCost(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Cost is required for pricing calculations';
    }
    final double? cost = double.tryParse(value!);
    if (cost == null || cost < 0) {
      return 'Please enter a valid cost amount';
    }
    return null;
  }

  /// Validate price
  static String? validatePrice(String? value) {
    if (value?.isNotEmpty == true) {
      final double? price = double.tryParse(value!);
      if (price == null || price < 0) {
        return 'Enter a valid price';
      }
    }
    return null;
  }

  /// Validate VAT percentage
  static String? validateVAT(String? value) {
    if (value?.isNotEmpty == true) {
      final double? vat = double.tryParse(value!);
      if (vat == null || vat < 0 || vat > 100) {
        return 'Enter a valid VAT percentage (0-100)';
      }
    }
    return null;
  }

  /// Validate quality rating
  static String? validateQuality(String? value) {
    if (value?.isNotEmpty == true) {
      final double? quality = double.tryParse(value!);
      if (quality == null || quality < 0 || quality > 100) {
        return 'Enter a valid quality rating (0-100)';
      }
    }
    return null;
  }

  /// Validate quantity
  static String? validateQuantity(String? value) {
    if (value?.isNotEmpty == true) {
      final double? quantity = double.tryParse(value!);
      if (quantity == null || quantity < 0) {
        return 'Enter a valid quantity';
      }
    }
    return null;
  }

  /// Validate conversion factor
  static String? validateConversionFactor(String? value) {
    if (value?.isNotEmpty == true) {
      final double? factor = double.tryParse(value!);
      if (factor == null || factor <= 0) {
        return 'Enter a valid conversion factor';
      }
    }
    return null;
  }
}