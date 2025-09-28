import 'package:flutter/material.dart';

import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';

/// Provider responsible for validation logic and business rules
class InventoryValidationProvider extends ChangeNotifier {
  InventoryValidationProvider();

  // Validation states
  bool _isSaving = false;

  // GETTERS
  bool get isSaving => _isSaving;

  /// Validate required fields for inventory creation
  bool validateRequiredFields({
    required String productCode,
    required String productName,
    required String averageCost,
    required InventoryLineEntity? selectedLineItem,
  }) {
    final List<String> errors = <String>[];

    if (productCode.trim().isEmpty) {
      errors.add('Product code is required');
    }

    if (productName.trim().isEmpty) {
      errors.add('Product name is required');
    }

    if (averageCost.trim().isEmpty) {
      errors.add('Average cost is required');
    } else {
      final double? cost = double.tryParse(averageCost);
      if (cost == null || cost <= 0) {
        errors.add('Average cost must be a valid positive number');
      }
    }

    if (selectedLineItem == null) {
      errors.add('Line item selection is required');
    }

    if (errors.isNotEmpty) {
      debugPrint('Validation errors: ${errors.join(', ')}');
      return false;
    }

    return true;
  }

  /// Validate pricing fields
  bool validatePricing({
    required String averageCost,
    required String price,
  }) {
    final double? cost = double.tryParse(averageCost);
    final double? salePrice = double.tryParse(price);

    if (cost == null || cost <= 0) {
      debugPrint('Invalid average cost');
      return false;
    }

    if (salePrice == null || salePrice <= 0) {
      debugPrint('Invalid sale price');
      return false;
    }

    if (salePrice < cost) {
      debugPrint('Warning: Sale price is lower than cost');
      // This might be allowed in some business cases, so we won't fail validation
      return true;
    }

    return true;
  }

  /// Validate inventory levels
  bool validateInventoryLevels({
    required String minimumLevel,
    required String optimalLevel,
    required String maximumLevel,
  }) {
    if (minimumLevel.isEmpty && optimalLevel.isEmpty && maximumLevel.isEmpty) {
      // All empty is valid (optional fields)
      return true;
    }

    final double? min = double.tryParse(minimumLevel);
    final double? optimal = double.tryParse(optimalLevel);
    final double? max = double.tryParse(maximumLevel);

    if (min != null && min < 0) {
      debugPrint('Minimum level cannot be negative');
      return false;
    }

    if (optimal != null && optimal < 0) {
      debugPrint('Optimal level cannot be negative');
      return false;
    }

    if (max != null && max < 0) {
      debugPrint('Maximum level cannot be negative');
      return false;
    }

    // Check logical order: min <= optimal <= max
    if (min != null && optimal != null && min > optimal) {
      debugPrint('Minimum level cannot be greater than optimal level');
      return false;
    }

    if (optimal != null && max != null && optimal > max) {
      debugPrint('Optimal level cannot be greater than maximum level');
      return false;
    }

    if (min != null && max != null && min > max) {
      debugPrint('Minimum level cannot be greater than maximum level');
      return false;
    }

    return true;
  }

  /// Check if supplier should be visible based on line item selection
  bool shouldShowSupplier(InventoryLineEntity? selectedLineItem) {
    return selectedLineItem != null;
  }

  /// Check if category should be visible based on line item selection
  bool shouldShowCategory(InventoryLineEntity? selectedLineItem) {
    return selectedLineItem != null;
  }

  /// Check if subcategory should be visible based on category selection
  bool shouldShowSubCategory(CategoryEntity? selectedCategory) {
    return selectedCategory != null;
  }

  /// Check if age group should be visible based on category selection
  bool shouldShowAgeGroup(CategoryEntity? selectedCategory) {
    return selectedCategory != null;
  }

  /// Check if purchase conversion unit should be visible based on category selection
  bool shouldShowPurchaseConvUnit(CategoryEntity? selectedCategory) {
    return selectedCategory != null;
  }

  /// Check if acquire type should be visible based on line item selection
  bool shouldShowAcquireType(InventoryLineEntity? selectedLineItem) {
    return selectedLineItem != null;
  }

  /// Check if purchase type should be visible based on line item selection
  bool shouldShowPurchaseType(InventoryLineEntity? selectedLineItem) {
    return selectedLineItem != null;
  }

  /// Check if manufacturing should be visible based on line item selection
  bool shouldShowManufacturing(InventoryLineEntity? selectedLineItem) {
    return selectedLineItem != null;
  }

  /// Check if sizes should be visible based on category selection
  bool shouldShowSizes(CategoryEntity? selectedCategory) {
    // This can be customized based on category type
    // For example, only show for clothing categories
    return selectedCategory != null && 
           (selectedCategory.categoryName.toLowerCase().contains('clothing') ||
            selectedCategory.categoryName.toLowerCase().contains('apparel') ||
            selectedCategory.categoryName.toLowerCase().contains('garment'));
  }

  /// Check if colors should be visible based on category selection
  bool shouldShowColors(CategoryEntity? selectedCategory) {
    // This can be customized based on category type
    return selectedCategory != null && 
           (selectedCategory.categoryName.toLowerCase().contains('clothing') ||
            selectedCategory.categoryName.toLowerCase().contains('apparel') ||
            selectedCategory.categoryName.toLowerCase().contains('garment') ||
            selectedCategory.categoryName.toLowerCase().contains('fabric'));
  }

  /// Check if default size and color should be visible
  bool shouldShowDefaultSizeColor(CategoryEntity? selectedCategory) {
    return shouldShowSizes(selectedCategory) || shouldShowColors(selectedCategory);
  }

  /// Check if life type should be visible based on category selection
  bool shouldShowLifeType(CategoryEntity? selectedCategory) {
    return selectedCategory != null;
  }

  /// Validate product code format
  bool validateProductCode(String productCode) {
    if (productCode.trim().isEmpty) {
      debugPrint('Product code cannot be empty');
      return false;
    }

    // Check for minimum length
    if (productCode.trim().length < 3) {
      debugPrint('Product code must be at least 3 characters');
      return false;
    }

    // Check for special characters that might cause issues
    final RegExp validPattern = RegExp(r'^[A-Za-z0-9\-_]+$');
    if (!validPattern.hasMatch(productCode.trim())) {
      debugPrint('Product code can only contain letters, numbers, hyphens, and underscores');
      return false;
    }

    return true;
  }

  /// Validate VAT percentage
  bool validateVAT(String vat) {
    if (vat.trim().isEmpty) {
      return true; // VAT is optional
    }

    final double? vatValue = double.tryParse(vat);
    if (vatValue == null) {
      debugPrint('VAT must be a valid number');
      return false;
    }

    if (vatValue < 0 || vatValue > 100) {
      debugPrint('VAT must be between 0 and 100 percent');
      return false;
    }

    return true;
  }

  /// Set saving state
  void setSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }

  /// Calculate profit margin
  double calculateProfitMargin(String costStr, String priceStr) {
    final double cost = double.tryParse(costStr) ?? 0;
    final double price = double.tryParse(priceStr) ?? 0;
    
    if (price <= 0) return 0;
    return ((price - cost) / price) * 100;
  }

  /// Calculate markup percentage
  double calculateMarkupPercentage(String costStr, String priceStr) {
    final double cost = double.tryParse(costStr) ?? 0;
    final double price = double.tryParse(priceStr) ?? 0;
    
    if (cost <= 0) return 0;
    return ((price - cost) / cost) * 100;
  }

  /// Check if the form has minimum required data for saving
  bool canSaveInventory({
    required String productCode,
    required String productName,
    required String averageCost,
    required InventoryLineEntity? selectedLineItem,
  }) {
    return validateRequiredFields(
      productCode: productCode,
      productName: productName,
      averageCost: averageCost,
      selectedLineItem: selectedLineItem,
    ) && validateProductCode(productCode);
  }
}