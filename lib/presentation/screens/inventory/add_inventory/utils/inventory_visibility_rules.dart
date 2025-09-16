/// Visibility rules for inventory form fields based on selections
class InventoryVisibilityRules {
  
  /// Check if category field should be visible
  static bool shouldShowCategory(String? lineItem) {
    if (lineItem == null) return false;
    return <String>[
      'Physical Product',
      'Digital Product',
      'Raw Material',
      'Finished Goods',
    ].contains(lineItem);
  }

  /// Check if subcategory field should be visible
  static bool shouldShowSubCategory(String? category) {
    if (category == null) return false;
    return <String>[
      'Electronics',
      'Clothing',
      'Food & Beverages',
      'Home & Garden',
    ].contains(category);
  }

  /// Check if product group field should be visible
  static bool shouldShowProductGroup(String? lineItem) {
    if (lineItem == null) return false;
    return <String>[
      'Physical Product',
      'Finished Goods',
      'Bundle',
    ].contains(lineItem);
  }

  /// Check if age group field should be visible
  static bool shouldShowAgeGroup(String? category) {
    if (category == null) return false;
    return <String>[
      'Toys & Games',
      'Clothing',
      'Books & Media',
      'Health & Beauty',
    ].contains(category);
  }

  /// Check if packaging type field should be visible
  static bool shouldShowPackagingType(String? lineItem) {
    if (lineItem == null) return false;
    return <String>[
      'Physical Product',
      'Raw Material',
      'Finished Goods',
    ].contains(lineItem);
  }

  /// Check if product gender field should be visible
  static bool shouldShowProductGender(String? category) {
    if (category == null) return false;
    return <String>[
      'Clothing',
      'Health & Beauty',
      'Sports & Outdoor',
    ].contains(category);
  }

  /// Check if VAT field should be visible
  static bool shouldShowVAT(String? lineItem) {
    if (lineItem == null) return false;
    return lineItem != 'Service'; // Services might have different tax rules
  }

  /// Check if manufacturing date should be enabled
  static bool shouldEnableMfgDate(String? lineItem) {
    if (lineItem == null) return false;
    return <String>[
      'Physical Product',
      'Food & Beverages',
      'Raw Material',
      'Finished Goods',
    ].contains(lineItem);
  }

  /// Check if expiry date should be enabled
  static bool shouldEnableExpDate(String? category) {
    if (category == null) return false;
    return <String>[
      'Food & Beverages',
      'Health & Beauty',
      'Electronics', // Warranty expiry
    ].contains(category);
  }

  /// Check if batch code should be enabled
  static bool shouldEnableBatchCode(String? lineItem) {
    if (lineItem == null) return false;
    return <String>[
      'Physical Product',
      'Raw Material',
      'Finished Goods',
    ].contains(lineItem);
  }

  /// Check if serial number should be enabled
  static bool shouldEnableSerialNumber(String? category) {
    if (category == null) return false;
    return <String>[
      'Electronics',
      'Automotive',
      'Home & Garden', // Appliances
    ].contains(category);
  }

  /// Check if size field should be enabled
  static bool shouldEnableSize(String? category) {
    if (category == null) return false;
    return <String>[
      'Clothing',
      'Home & Garden',
      'Sports & Outdoor',
    ].contains(category);
  }

  /// Check if color field should be enabled
  static bool shouldEnableColor(String? category) {
    if (category == null) return false;
    return <String>[
      'Clothing',
      'Electronics',
      'Home & Garden',
      'Automotive',
    ].contains(category);
  }

  /// Check if inventory management section should be visible
  static bool shouldShowInventoryManagement(String? lineItem) {
    if (lineItem == null) return false;
    return lineItem != 'Service'; // Services don't need stock management
  }

  /// Check if purchase configuration should be visible
  static bool shouldShowPurchaseConfig(String? acquireType) {
    if (acquireType == null) return false;
    return <String>[
      'Purchase',
      'Consignment',
    ].contains(acquireType);
  }

  /// Get required fields based on line item
  static List<String> getRequiredFields(String? lineItem) {
    if (lineItem == null) return <String>['productName', 'averageCost'];
    
    switch (lineItem) {
      case 'Physical Product':
        return <String>[
          'productName',
          'productCode',
          'averageCost',
          'category',
        ];
      case 'Service':
        return <String>[
          'productName',
          'averageCost',
        ];
      case 'Digital Product':
        return <String>[
          'productName',
          'productCode',
          'category',
        ];
      default:
        return <String>['productName', 'averageCost'];
    }
  }

  /// Check if field is required
  static bool isFieldRequired(String fieldName, String? lineItem) {
    return getRequiredFields(lineItem).contains(fieldName);
  }
}