import 'package:flutter/material.dart';

import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';

/// Provider responsible for form state management and UI interactions
class InventoryFormProvider extends ChangeNotifier {
  InventoryFormProvider() {
    _initializeFormControllers();
  }

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // REQUIRED FIELDS
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController averageCostController = TextEditingController();

  // BASIC DETAILS
  final TextEditingController shopQualityController = TextEditingController();
  final TextEditingController storeQualityController = TextEditingController();

  // PRICING & SALES
  final TextEditingController priceController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController userPriceController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();

  // INVENTORY MANAGEMENT
  final TextEditingController minimumLevelController = TextEditingController();
  final TextEditingController optimalLevelController = TextEditingController();
  final TextEditingController maximumLevelController = TextEditingController();

  // PURCHASE CONFIGURATION
  final TextEditingController purchaseConvFactorController = TextEditingController();

  // ADDITIONAL
  final TextEditingController commentsController = TextEditingController();

  // SELECTED VALUES
  InventoryLineEntity? _selectedLineItem;
  SupplierEntity? _selectedSupplier;
  CategoryEntity? _selectedCategory;
  SubCategoryEntity? _selectedSubCategory;
  String? _selectedProductGroup;
  String? _selectedAgeGroup;
  String? _selectedPackagingType;
  String? _selectedProductGender;
  String? _selectedCurrency = 'PKR';
  String? _selectedPurchaseConvUnit;
  String? _selectedAcquireType;
  String? _selectedPurchaseType;
  String? _selectedManufacturing;
  List<InventorySizesEntity> _selectedSizes = <InventorySizesEntity>[];
  List<InventoryColorsEntity> _selectedColors = <InventoryColorsEntity>[];
  InventorySizesEntity? _selectedDefaultSize;
  InventoryColorsEntity? _selectedDefaultColor;
  String? _selectedLifeType;
  DateTime? _selectedDate;

  // AUTO-GENERATE OPTIONS
  bool _autoGenerateCode = true;

  // GETTERS
  InventoryLineEntity? get selectedLineItem => _selectedLineItem;
  SupplierEntity? get selectedSupplier => _selectedSupplier;
  CategoryEntity? get selectedCategory => _selectedCategory;
  SubCategoryEntity? get selectedSubCategory => _selectedSubCategory;
  String? get selectedProductGroup => _selectedProductGroup;
  String? get selectedAgeGroup => _selectedAgeGroup;
  String? get selectedPackagingType => _selectedPackagingType;
  String? get selectedProductGender => _selectedProductGender;
  String? get selectedCurrency => _selectedCurrency;
  String? get selectedPurchaseConvUnit => _selectedPurchaseConvUnit;
  String? get selectedAcquireType => _selectedAcquireType;
  String? get selectedPurchaseType => _selectedPurchaseType;
  String? get selectedManufacturing => _selectedManufacturing;
  List<InventorySizesEntity> get selectedSizes => _selectedSizes;
  List<InventoryColorsEntity> get selectedColors => _selectedColors;
  InventorySizesEntity? get selectedDefaultSize => _selectedDefaultSize;
  InventoryColorsEntity? get selectedDefaultColor => _selectedDefaultColor;
  String? get selectedLifeType => _selectedLifeType;
  DateTime? get selectedDate => _selectedDate;
  bool get autoGenerateCode => _autoGenerateCode;

  /// Initialize form controllers with listeners
  void _initializeFormControllers() {
    // Add listeners for profit calculations
    averageCostController.addListener(_onPriceChanged);
    priceController.addListener(_onPriceChanged);
  }

  /// Handle price changes for calculations
  void _onPriceChanged() {
    notifyListeners();
  }

  /// Generate product code automatically
  void _generateProductCode() {
    if (_autoGenerateCode) {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      productCodeController.text = 'PRD-${timestamp.substring(timestamp.length - 8)}';
    }
  }

  /// Set line item
  void setLineItem(InventoryLineEntity? lineItem) {
    _selectedLineItem = lineItem;
    
    // Reset dependent fields based on parent-child relationships
    _selectedSupplier = null;
    _selectedCategory = null;
    _selectedSubCategory = null;
    _selectedAcquireType = null;
    _selectedPurchaseType = null;
    _selectedManufacturing = null;
    
    notifyListeners();
  }

  /// Set supplier
  void setSupplier(SupplierEntity? supplier) {
    _selectedSupplier = supplier;
    notifyListeners();
  }

  /// Set category
  void setCategory(CategoryEntity? category) {
    _selectedCategory = category;
    
    // Reset dependent fields based on parent-child relationships
    _selectedSubCategory = null;
    _selectedAgeGroup = null;
    _selectedPurchaseConvUnit = null;
    _selectedSizes = <InventorySizesEntity>[];
    _selectedColors = <InventoryColorsEntity>[];
    _selectedDefaultSize = null;
    _selectedDefaultColor = null;
    _selectedLifeType = null;
    
    notifyListeners();
  }

  /// Set subcategory
  void setSubCategory(SubCategoryEntity? subCategory) {
    _selectedSubCategory = subCategory;
    notifyListeners();
  }

  /// Set product group
  void setProductGroup(String? productGroup) {
    _selectedProductGroup = productGroup;
    notifyListeners();
  }

  /// Set age group
  void setAgeGroup(String? ageGroup) {
    _selectedAgeGroup = ageGroup;
    notifyListeners();
  }

  /// Set packaging type
  void setPackagingType(String? packagingType) {
    _selectedPackagingType = packagingType;
    notifyListeners();
  }

  /// Set product gender
  void setProductGender(String? gender) {
    _selectedProductGender = gender;
    notifyListeners();
  }

  /// Set currency
  void setCurrency(String? currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  /// Set purchase conversion unit
  void setPurchaseConvUnit(String? unit) {
    _selectedPurchaseConvUnit = unit;
    notifyListeners();
  }

  /// Set acquire type
  void setAcquireType(String? type) {
    _selectedAcquireType = type;
    notifyListeners();
  }

  /// Set purchase type
  void setPurchaseType(String? type) {
    _selectedPurchaseType = type;
    notifyListeners();
  }

  /// Set manufacturing
  void setManufacturing(String? manufacturing) {
    _selectedManufacturing = manufacturing;
    notifyListeners();
  }

  /// Set sizes
  void setSizes(List<InventorySizesEntity> sizes) {
    _selectedSizes = sizes;
    // Reset default size if not in selected sizes
    if (_selectedDefaultSize != null && !sizes.contains(_selectedDefaultSize)) {
      _selectedDefaultSize = null;
    }
    notifyListeners();
  }

  /// Set colors
  void setColors(List<InventoryColorsEntity> colors) {
    _selectedColors = colors;
    // Reset default color if not in selected colors
    if (_selectedDefaultColor != null && !colors.contains(_selectedDefaultColor)) {
      _selectedDefaultColor = null;
    }
    notifyListeners();
  }

  /// Set default size
  void setDefaultSize(InventorySizesEntity? size) {
    _selectedDefaultSize = size;
    notifyListeners();
  }

  /// Set default color
  void setDefaultColor(InventoryColorsEntity? color) {
    _selectedDefaultColor = color;
    notifyListeners();
  }

  /// Set life type
  void setLifeType(String? lifeType) {
    _selectedLifeType = lifeType;
    notifyListeners();
  }

  /// Set date
  void setDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Toggle auto-generate code
  void toggleAutoGenerateCode(bool value) {
    _autoGenerateCode = value;
    if (value) {
      _generateProductCode();
    } else {
      productCodeController.clear();
    }
    notifyListeners();
  }

  /// Calculate profit margin
  double get profitMargin {
    final double cost = double.tryParse(averageCostController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0;
    
    if (price <= 0) return 0;
    return ((price - cost) / price) * 100;
  }

  /// Calculate markup percentage
  double get markupPercentage {
    final double cost = double.tryParse(averageCostController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0;
    
    if (cost <= 0) return 0;
    return ((price - cost) / cost) * 100;
  }

  /// Clear form
  void clearForm() {
    // Clear all text controllers
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
    _selectedLineItem = null;
    _selectedSupplier = null;
    _selectedCategory = null;
    _selectedSubCategory = null;
    _selectedProductGroup = null;
    _selectedAgeGroup = null;
    _selectedPackagingType = null;
    _selectedProductGender = null;
    _selectedCurrency = 'PKR';
    _selectedPurchaseConvUnit = null;
    _selectedAcquireType = null;
    _selectedPurchaseType = null;
    _selectedManufacturing = null;
    _selectedSizes = <InventorySizesEntity>[];
    _selectedColors = <InventoryColorsEntity>[];
    _selectedDefaultSize = null;
    _selectedDefaultColor = null;
    _selectedLifeType = null;
    _selectedDate = null;
    
    if (_autoGenerateCode) {
      _generateProductCode();
    }
    
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose all text controllers
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
    
    super.dispose();
  }
}