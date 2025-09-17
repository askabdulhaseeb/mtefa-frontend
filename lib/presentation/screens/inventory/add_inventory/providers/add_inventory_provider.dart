import 'package:flutter/material.dart';

import '../../../../../domain/entities/inventory/brand_entity.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_entity.dart';

/// Provider for managing add inventory screen state
class AddInventoryProvider extends ChangeNotifier {
  AddInventoryProvider() {
    _initializeFormControllers();
    _loadFormData();
  }

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController minimumStockController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Selected values
  CategoryEntity? _selectedCategory;
  BrandEntity? _selectedBrand;
  String _selectedUnit = 'pieces';

  // Lists for dropdowns
  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<BrandEntity> _brands = <BrandEntity>[];
  final List<String> _unitOfMeasurements = <String>[
    'pieces',
    'kg',
    'grams',
    'liters',
    'ml',
    'meters',
    'cm',
    'dozen',
    'box',
    'pack',
  ];

  // Loading states
  bool _isLoading = false;
  bool _isSaving = false;

  // Auto-generate SKU
  bool _autoGenerateCode = true;


  // Getters
  CategoryEntity? get selectedCategory => _selectedCategory;
  BrandEntity? get selectedBrand => _selectedBrand;
  String get selectedUnit => _selectedUnit;
  List<CategoryEntity> get categories => _categories;
  List<BrandEntity> get brands => _brands;
  List<String> get unitOfMeasurements => _unitOfMeasurements;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get autoGenerateCode => _autoGenerateCode;

  /// Calculate profit margin
  double get profitMargin {
    final double cost = double.tryParse(costPriceController.text) ?? 0;
    final double selling = double.tryParse(sellingPriceController.text) ?? 0;
    
    if (selling <= 0) return 0;
    return ((selling - cost) / selling) * 100;
  }

  /// Calculate markup percentage
  double get markupPercentage {
    final double cost = double.tryParse(costPriceController.text) ?? 0;
    final double selling = double.tryParse(sellingPriceController.text) ?? 0;
    
    if (cost <= 0) return 0;
    return ((selling - cost) / cost) * 100;
  }

  /// Initialize form controllers with listeners
  void _initializeFormControllers() {
    // Add listeners to price controllers for profit calculations
    costPriceController.addListener(_onPriceChanged);
    sellingPriceController.addListener(_onPriceChanged);
  }

  /// Handle price changes
  void _onPriceChanged() {
    notifyListeners();
  }

  /// Load initial form data (categories, brands)
  Future<void> _loadFormData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Load categories and brands from repository
      // For now, using mock data
      await Future<void>.delayed(const Duration(milliseconds: 500));
      
      _categories = _getMockCategories();
      _brands = _getMockBrands();

      // Auto-generate inventory code if enabled
      if (_autoGenerateCode) {
        _generateInventoryCode();
      }
    } catch (e) {
      debugPrint('Error loading form data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Generate inventory code automatically
  void _generateInventoryCode() {
    if (_autoGenerateCode) {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      codeController.text = 'INV-${timestamp.substring(timestamp.length - 8)}';
    }
  }

  /// Set selected category
  void setCategory(CategoryEntity? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Set selected brand
  void setBrand(BrandEntity? brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  /// Set selected unit of measurement
  void setUnit(String unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  /// Toggle auto-generate code
  void toggleAutoGenerateCode(bool value) {
    _autoGenerateCode = value;
    if (value) {
      _generateInventoryCode();
    } else {
      codeController.clear();
    }
    notifyListeners();
  }


  /// Validate and save inventory
  Future<bool> saveInventory() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (_selectedCategory == null) {
      debugPrint('Please select a category');
      return false;
    }

    if (_selectedBrand == null) {
      debugPrint('Please select a brand');
      return false;
    }

    _isSaving = true;
    notifyListeners();

    try {
      final InventoryEntity inventory = InventoryEntity(
        name: nameController.text.trim(),
        code: codeController.text.trim(),
        categoryId: _selectedCategory!.categoryId,
        brandId: _selectedBrand!.id,
        description: descriptionController.text.trim(),
        costPrice: double.parse(costPriceController.text),
        sellingPrice: double.parse(sellingPriceController.text),
        stockQuantity: int.parse(stockQuantityController.text),
        minimumStockLevel: int.parse(minimumStockController.text),
        unitOfMeasurement: _selectedUnit,
        imageUrl: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // TODO: Save inventory to repository
      await Future<void>.delayed(const Duration(seconds: 1));
      debugPrint('Inventory saved: ${inventory.name}');

      // Clear form after successful save
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
    nameController.clear();
    codeController.clear();
    descriptionController.clear();
    costPriceController.clear();
    sellingPriceController.clear();
    stockQuantityController.clear();
    minimumStockController.clear();
    
    _selectedCategory = null;
    _selectedBrand = null;
    _selectedUnit = 'pieces';
    
    if (_autoGenerateCode) {
      _generateInventoryCode();
    }
    
    notifyListeners();
  }

  /// Mock data for categories
  List<CategoryEntity> _getMockCategories() {
    final DateTime now = DateTime.now();
    return <CategoryEntity>[
      CategoryEntity(
        categoryId: '1',
        businessId: 'business-001',
        categoryCode: 'ELEC',
        categoryName: 'Electronics',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '2',
        businessId: 'business-001',
        categoryCode: 'CLOTH',
        categoryName: 'Clothing',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '3',
        businessId: 'business-001',
        categoryCode: 'FOOD',
        categoryName: 'Food & Beverages',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '4',
        businessId: 'business-001',
        categoryCode: 'HOME',
        categoryName: 'Home & Garden',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '5',
        businessId: 'business-001',
        categoryCode: 'HEALTH',
        categoryName: 'Health & Beauty',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '6',
        businessId: 'business-001',
        categoryCode: 'SPORT',
        categoryName: 'Sports & Outdoors',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '7',
        businessId: 'business-001',
        categoryCode: 'BOOKS',
        categoryName: 'Books & Stationery',
        createdAt: now,
        updatedAt: now,
      ),
      CategoryEntity(
        categoryId: '8',
        businessId: 'business-001',
        categoryCode: 'TOYS',
        categoryName: 'Toys & Games',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  /// Mock data for brands
  List<BrandEntity> _getMockBrands() {
    return const <BrandEntity>[
      BrandEntity(id: '1', name: 'Samsung'),
      BrandEntity(id: '2', name: 'Apple'),
      BrandEntity(id: '3', name: 'Nike'),
      BrandEntity(id: '4', name: 'Adidas'),
      BrandEntity(id: '5', name: 'Sony'),
      BrandEntity(id: '6', name: 'LG'),
      BrandEntity(id: '7', name: 'Nestle'),
      BrandEntity(id: '8', name: 'Coca-Cola'),
    ];
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    costPriceController.dispose();
    sellingPriceController.dispose();
    stockQuantityController.dispose();
    minimumStockController.dispose();
    super.dispose();
  }
}