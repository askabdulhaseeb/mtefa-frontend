import 'package:flutter/material.dart';

/// Form data model for inventory creation
class InventoryFormData {
  InventoryFormData();

  // Form Controllers
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController averageCostController = TextEditingController();
  final TextEditingController shopQualityController = TextEditingController();
  final TextEditingController storeQualityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController userPriceController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController minimumLevelController = TextEditingController();
  final TextEditingController optimalLevelController = TextEditingController();
  final TextEditingController maximumLevelController = TextEditingController();
  final TextEditingController purchaseConvFactorController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  // Selected Values
  String? selectedLineItem;
  String? selectedSupplier;
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedProductGroup;
  String? selectedAgeGroup;
  String? selectedPackagingType;
  String? selectedProductGender;
  String? selectedCurrency;
  String? selectedPurchaseConvUnit;
  String? selectedAcquireType;

  // Boolean flags
  bool enableMfgDate = false;
  bool enableExpDate = false;
  bool enableBatchCode = false;
  bool enableSerialNumber = false;
  bool enableSize = false;
  bool enableColor = false;
  bool allowZeroPrice = false;
  bool trackNegativeStock = false;
  bool allowPurchase = false;
  bool allowSale = false;
  bool alertWhenLow = false;
  bool isService = false;
  bool isLoading = false;
  bool hasError = false;

  /// Reset all form data
  void reset() {
    // Clear controllers
    productCodeController.clear();
    productNameController.clear();
    averageCostController.clear();
    shopQualityController.clear();
    storeQualityController.clear();
    priceController.clear();
    vatController.clear();
    userPriceController.clear();
    productIdController.clear();
    minimumLevelController.clear();
    optimalLevelController.clear();
    maximumLevelController.clear();
    purchaseConvFactorController.clear();
    commentsController.clear();

    // Reset selected values
    selectedLineItem = null;
    selectedSupplier = null;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedProductGroup = null;
    selectedAgeGroup = null;
    selectedPackagingType = null;
    selectedProductGender = null;
    selectedCurrency = null;
    selectedPurchaseConvUnit = null;
    selectedAcquireType = null;

    // Reset boolean flags
    enableMfgDate = false;
    enableExpDate = false;
    enableBatchCode = false;
    enableSerialNumber = false;
    enableSize = false;
    enableColor = false;
    allowZeroPrice = false;
    trackNegativeStock = false;
    allowPurchase = false;
    allowSale = false;
    alertWhenLow = false;
    isService = false;
    isLoading = false;
    hasError = false;
  }

  /// Create a copy with updated values
  InventoryFormData copyWith({
    String? selectedLineItem,
    String? selectedSupplier,
    String? selectedCategory,
    bool? enableMfgDate,
    bool? enableExpDate,
    bool? isLoading,
  }) {
    final InventoryFormData copy = InventoryFormData();
    
    // Copy controller values
    copy.productCodeController.text = productCodeController.text;
    copy.productNameController.text = productNameController.text;
    copy.averageCostController.text = averageCostController.text;
    
    // Copy selected values
    copy.selectedLineItem = selectedLineItem ?? this.selectedLineItem;
    copy.selectedSupplier = selectedSupplier ?? this.selectedSupplier;
    copy.selectedCategory = selectedCategory ?? this.selectedCategory;
    
    // Copy boolean flags
    copy.enableMfgDate = enableMfgDate ?? this.enableMfgDate;
    copy.enableExpDate = enableExpDate ?? this.enableExpDate;
    copy.isLoading = isLoading ?? this.isLoading;
    
    return copy;
  }

  /// Dispose all controllers
  void dispose() {
    productCodeController.dispose();
    productNameController.dispose();
    averageCostController.dispose();
    shopQualityController.dispose();
    storeQualityController.dispose();
    priceController.dispose();
    vatController.dispose();
    userPriceController.dispose();
    productIdController.dispose();
    minimumLevelController.dispose();
    optimalLevelController.dispose();
    maximumLevelController.dispose();
    purchaseConvFactorController.dispose();
    commentsController.dispose();
  }
}