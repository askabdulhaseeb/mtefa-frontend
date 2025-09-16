import 'package:flutter/material.dart';

/// Comprehensive provider for managing all inventory fields based on product definition requirements
class ComprehensiveInventoryProvider extends ChangeNotifier {
  ComprehensiveInventoryProvider() {
    _initializeFormControllers();
    _loadFormData();
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
  String? _selectedLineItem;
  String? _selectedSupplier;
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedProductGroup;
  String? _selectedAgeGroup;
  String? _selectedPackagingType;
  String? _selectedProductGender;
  String? _selectedCurrency;
  String? _selectedPurchaseConvUnit;
  String? _selectedAcquireType;
  String? _selectedPurchaseType;
  String? _selectedManufacturing;
  List<String> _selectedSizes = [];
  List<String> _selectedColors = [];
  String? _selectedDefaultSize;
  String? _selectedDefaultColor;
  String? _selectedLifeType;
  DateTime? _selectedDate;

  // DROPDOWN OPTIONS
  final List<String> _lineItems = [
    'Ladies Shirts',
    'Pharmacy',
    'Electronics',
    'Home & Garden',
    'Sports Equipment',
  ];

  final List<String> _suppliers = [
    'Supplier A',
    'Supplier B', 
    'Supplier C',
    'Local Vendor',
    'International Supplier',
  ];

  final List<String> _categories = [
    'Clothing',
    'Medicine',
    'Electronics',
    'Home Appliances',
    'Sports',
  ];

  final List<String> _subCategories = [
    'Shirts',
    'Tablets',
    'Mobile Phones',
    'Kitchen Appliances',
    'Exercise Equipment',
  ];

  final List<String> _productGroups = [
    'Premium',
    'Standard',
    'Budget',
    'Luxury',
    'Economy',
  ];

  final List<String> _ageGroups = [
    'Infant (0-2)',
    'Toddler (3-5)',
    'Child (6-12)',
    'Teen (13-19)',
    'Adult (20-59)',
    'Senior (60+)',
  ];

  final List<String> _packagingTypes = [
    'Box',
    'Bottle',
    'Bag',
    'Blister Pack',
    'Tube',
    'Container',
  ];

  final List<String> _productGenders = [
    'Male',
    'Female',
    'Unisex',
  ];

  final List<String> _currencies = [
    'PKR',
    'USD',
    'EUR',
    'GBP',
    'AED',
  ];

  final List<String> _purchaseConvUnits = [
    'Pack',
    'Bottle',
    'Box',
    'Carton',
    'Dozen',
  ];

  final List<String> _acquireTypes = [
    'Purchased',
    'Local',
    'Outsourced',
  ];

  final List<String> _purchaseTypes = [
    'Local',
    'Import',
  ];

  final List<String> _manufacturingTypes = [
    'Manufactured',
    'Outsourced',
  ];

  final List<String> _sizes = [
    'XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL',
    '32', '34', '36', '38', '40', '42',
  ];

  final List<String> _colors = [
    'Red', 'Blue', 'Green', 'Yellow', 'Black', 'White',
    'Navy', 'Grey', 'Brown', 'Pink', 'Purple', 'Orange',
  ];

  final List<String> _lifeTypes = [
    'Consumable',
    'Durable',
    'Perishable',
    'Non-Perishable',
    'Disposable',
  ];

  // LOADING STATES
  bool _isLoading = false;
  bool _isSaving = false;

  // AUTO-GENERATE OPTIONS
  bool _autoGenerateCode = true;

  // GETTERS
  String? get selectedLineItem => _selectedLineItem;
  String? get selectedSupplier => _selectedSupplier;
  String? get selectedCategory => _selectedCategory;
  String? get selectedSubCategory => _selectedSubCategory;
  String? get selectedProductGroup => _selectedProductGroup;
  String? get selectedAgeGroup => _selectedAgeGroup;
  String? get selectedPackagingType => _selectedPackagingType;
  String? get selectedProductGender => _selectedProductGender;
  String? get selectedCurrency => _selectedCurrency;
  String? get selectedPurchaseConvUnit => _selectedPurchaseConvUnit;
  String? get selectedAcquireType => _selectedAcquireType;
  String? get selectedPurchaseType => _selectedPurchaseType;
  String? get selectedManufacturing => _selectedManufacturing;
  List<String> get selectedSizes => _selectedSizes;
  List<String> get selectedColors => _selectedColors;
  String? get selectedDefaultSize => _selectedDefaultSize;
  String? get selectedDefaultColor => _selectedDefaultColor;
  String? get selectedLifeType => _selectedLifeType;
  DateTime? get selectedDate => _selectedDate;

  List<String> get lineItems => _lineItems;
  List<String> get suppliers => _suppliers;
  List<String> get categories => _categories;
  List<String> get subCategories => _subCategories;
  List<String> get productGroups => _productGroups;
  List<String> get ageGroups => _ageGroups;
  List<String> get packagingTypes => _packagingTypes;
  List<String> get productGenders => _productGenders;
  List<String> get currencies => _currencies;
  List<String> get purchaseConvUnits => _purchaseConvUnits;
  List<String> get acquireTypes => _acquireTypes;
  List<String> get purchaseTypes => _purchaseTypes;
  List<String> get manufacturingTypes => _manufacturingTypes;
  List<String> get sizes => _sizes;
  List<String> get colors => _colors;
  List<String> get lifeTypes => _lifeTypes;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
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

  /// Load initial form data
  Future<void> _loadFormData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Set default currency
      _selectedCurrency = 'PKR';
      
      // Auto-generate product code if enabled
      if (_autoGenerateCode) {
        _generateProductCode();
      }
    } catch (e) {
      debugPrint('Error loading form data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Generate product code automatically
  void _generateProductCode() {
    if (_autoGenerateCode) {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      productCodeController.text = 'PRD-${timestamp.substring(timestamp.length - 8)}';
    }
  }

  /// Set line item
  void setLineItem(String? lineItem) {
    _selectedLineItem = lineItem;
    // Reset dependent fields
    _selectedSupplier = null;
    _selectedCategory = null;
    _selectedSubCategory = null;
    notifyListeners();
  }

  /// Set supplier (visibility depends on line item)
  void setSupplier(String? supplier) {
    _selectedSupplier = supplier;
    notifyListeners();
  }

  /// Set category (visibility depends on line item)
  void setCategory(String? category) {
    _selectedCategory = category;
    _selectedSubCategory = null; // Reset subcategory
    _selectedAgeGroup = null; // Reset age group
    notifyListeners();
  }

  /// Set subcategory (visibility depends on category)
  void setSubCategory(String? subCategory) {
    _selectedSubCategory = subCategory;
    notifyListeners();
  }

  /// Set product group
  void setProductGroup(String? productGroup) {
    _selectedProductGroup = productGroup;
    notifyListeners();
  }

  /// Set age group (visibility depends on category)
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

  /// Set purchase conversion unit (visibility depends on category)
  void setPurchaseConvUnit(String? unit) {
    _selectedPurchaseConvUnit = unit;
    notifyListeners();
  }

  /// Set acquire type (visibility depends on line item)
  void setAcquireType(String? type) {
    _selectedAcquireType = type;
    notifyListeners();
  }

  /// Set purchase type (visibility depends on line item)
  void setPurchaseType(String? type) {
    _selectedPurchaseType = type;
    notifyListeners();
  }

  /// Set manufacturing (visibility depends on line item)
  void setManufacturing(String? manufacturing) {
    _selectedManufacturing = manufacturing;
    notifyListeners();
  }

  /// Set sizes (visibility depends on category)
  void setSizes(List<String> sizes) {
    _selectedSizes = sizes;
    // Reset default size if not in selected sizes
    if (_selectedDefaultSize != null && !sizes.contains(_selectedDefaultSize)) {
      _selectedDefaultSize = null;
    }
    notifyListeners();
  }

  /// Set colors (visibility depends on category)
  void setColors(List<String> colors) {
    _selectedColors = colors;
    // Reset default color if not in selected colors
    if (_selectedDefaultColor != null && !colors.contains(_selectedDefaultColor)) {
      _selectedDefaultColor = null;
    }
    notifyListeners();
  }

  /// Set default size (visibility depends on category)
  void setDefaultSize(String? size) {
    _selectedDefaultSize = size;
    notifyListeners();
  }

  /// Set default color (visibility depends on category)
  void setDefaultColor(String? color) {
    _selectedDefaultColor = color;
    notifyListeners();
  }

  /// Set life type (visibility depends on category)
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

  /// Check if supplier should be visible (depends on line item)
  bool get shouldShowSupplier {
    return _selectedLineItem != null;
  }

  /// Check if category should be visible (depends on line item)
  bool get shouldShowCategory {
    return _selectedLineItem != null;
  }

  /// Check if subcategory should be visible (depends on category)
  bool get shouldShowSubCategory {
    return _selectedCategory != null;
  }

  /// Check if age group should be visible (depends on category)
  bool get shouldShowAgeGroup {
    return _selectedCategory != null;
  }

  /// Check if purchase conv unit should be visible (depends on category)
  bool get shouldShowPurchaseConvUnit {
    return _selectedCategory != null;
  }

  /// Check if acquire type should be visible (depends on line item)
  bool get shouldShowAcquireType {
    return _selectedLineItem != null;
  }

  /// Check if purchase type should be visible (depends on line item)
  bool get shouldShowPurchaseType {
    return _selectedLineItem != null;
  }

  /// Check if manufacturing should be visible (depends on line item)
  bool get shouldShowManufacturing {
    return _selectedLineItem != null;
  }

  /// Check if sizes should be visible (depends on category)
  bool get shouldShowSizes {
    return _selectedCategory == 'Clothing';
  }

  /// Check if colors should be visible (depends on category)
  bool get shouldShowColors {
    return _selectedCategory == 'Clothing';
  }

  /// Check if default size and color should be visible (depends on category)
  bool get shouldShowDefaultSizeColor {
    return shouldShowSizes && shouldShowColors;
  }

  /// Check if life type should be visible (depends on category)
  bool get shouldShowLifeType {
    return _selectedCategory != null;
  }

  /// Add new line item
  Future<String?> addNewLineItem() async {
    // TODO: Implement add new line item dialog
    // For now, just return a mock value
    final String newItem = 'New Line Item ${_lineItems.length + 1}';
    _lineItems.add(newItem);
    notifyListeners();
    return newItem;
  }

  /// Add new supplier
  Future<String?> addNewSupplier() async {
    // TODO: Implement add new supplier dialog
    final String newSupplier = 'New Supplier ${_suppliers.length + 1}';
    _suppliers.add(newSupplier);
    notifyListeners();
    return newSupplier;
  }

  /// Add new category
  Future<String?> addNewCategory() async {
    // TODO: Implement add new category dialog
    final String newCategory = 'New Category ${_categories.length + 1}';
    _categories.add(newCategory);
    notifyListeners();
    return newCategory;
  }

  /// Validate and save inventory
  Future<bool> saveInventory() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    // Validate required fields
    if (_selectedLineItem == null) {
      debugPrint('Please select a line item');
      return false;
    }

    _isSaving = true;
    notifyListeners();

    try {
      // TODO: Save inventory to repository
      await Future.delayed(const Duration(seconds: 2));
      
      debugPrint('Inventory saved successfully');
      clearForm();
      return true;
    } catch (e) {
      debugPrint('Error saving inventory: $e');
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
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
    _selectedSizes = [];
    _selectedColors = [];
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