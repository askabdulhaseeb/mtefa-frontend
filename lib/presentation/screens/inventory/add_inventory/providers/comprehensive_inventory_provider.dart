import 'package:flutter/material.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../domain/usecases/inventory/get_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_colors_usecase.dart';
import '../../../../../domain/usecases/inventory/get_inventory_lines_usecase.dart';
import '../../../../../domain/usecases/inventory/get_sizes_usecase.dart';
import '../../../../../domain/usecases/inventory/get_sub_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_suppliers_usecase.dart';
import '../../../../widgets/dialogs/add_dropdown_item_dialog.dart';
import '../../../../../core/database/database.dart';
import '../../../../../injection_container.dart';
import 'package:uuid/uuid.dart';

/// Comprehensive provider for managing all inventory fields - NO HARDCODED DATA
class ComprehensiveInventoryProvider extends ChangeNotifier {
  ComprehensiveInventoryProvider({
    required GetInventoryLinesUseCase getInventoryLinesUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetCategoriesByParentUseCase getCategoriesByParentUseCase,
    required GetSubCategoriesUseCase getSubCategoriesUseCase,
    required GetSuppliersUseCase getSuppliersUseCase,
    required GetColorsUseCase getColorsUseCase,
    required GetSizesUseCase getSizesUseCase,
  }) : _getInventoryLinesUseCase = getInventoryLinesUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       // _getCategoriesByParentUseCase = getCategoriesByParentUseCase,
       _getSubCategoriesUseCase = getSubCategoriesUseCase,
       _getSuppliersUseCase = getSuppliersUseCase,
       _getColorsUseCase = getColorsUseCase,
       _getSizesUseCase = getSizesUseCase {
    _initializeFormControllers();
    _loadFormData();
  }

  final GetInventoryLinesUseCase _getInventoryLinesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  // final GetCategoriesByParentUseCase _getCategoriesByParentUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;
  final GetSuppliersUseCase _getSuppliersUseCase;
  final GetColorsUseCase _getColorsUseCase;
  final GetSizesUseCase _getSizesUseCase;

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
  final TextEditingController purchaseConvFactorController =
      TextEditingController();

  // ADDITIONAL
  final TextEditingController commentsController = TextEditingController();

  // DATA FROM DATABASE - NO HARDCODED DATA
  List<InventoryLineEntity> _inventoryLines = <InventoryLineEntity>[];
  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<SubCategoryEntity> _subCategories = <SubCategoryEntity>[];
  List<SupplierEntity> _suppliers = <SupplierEntity>[];
  List<InventoryColorsEntity> _colorsEntities = <InventoryColorsEntity>[];
  List<InventorySizesEntity> _sizesEntities = <InventorySizesEntity>[];

  // Placeholder lists for fields not yet in database
  final List<String> _productGroups = <String>[];
  final List<String> _ageGroups = <String>[];
  final List<String> _packagingTypes = <String>[];
  final List<String> _productGenders = <String>[];
  final List<String> _lifeTypes = <String>[];

  // Placeholder selected values
  String? _selectedProductGroup;
  String? _selectedAgeGroup;
  String? _selectedPackagingType;
  String? _selectedProductGender;
  String? _selectedLifeType;

  // SELECTED VALUES
  InventoryLineEntity? _selectedLineItem;
  SupplierEntity? _selectedSupplier;
  CategoryEntity? _selectedCategory;
  SubCategoryEntity? _selectedSubCategory;
  List<String> _selectedSizes = <String>[];
  List<String> _selectedColors = <String>[];
  String? _selectedDefaultSize;
  String? _selectedDefaultColor;
  DateTime? _selectedDate;

  // Only currency remains as minimal configuration
  String _selectedCurrency = 'PKR';
  final List<String> _currencies = <String>['PKR', 'USD', 'EUR', 'GBP', 'AED'];

  // LOADING STATES
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isLoadingSubCategories = false;

  // AUTO-GENERATE OPTIONS
  bool _autoGenerateCode = true;

  // GETTERS
  InventoryLineEntity? get selectedLineItem => _selectedLineItem;
  SupplierEntity? get selectedSupplier => _selectedSupplier;
  CategoryEntity? get selectedCategory => _selectedCategory;
  SubCategoryEntity? get selectedSubCategory => _selectedSubCategory;
  List<String> get selectedSizes => _selectedSizes;
  List<String> get selectedColors => _selectedColors;
  String? get selectedDefaultSize => _selectedDefaultSize;
  String? get selectedDefaultColor => _selectedDefaultColor;
  DateTime? get selectedDate => _selectedDate;
  String get selectedCurrency => _selectedCurrency;

  List<InventoryLineEntity> get inventoryLines => _inventoryLines;
  List<SupplierEntity> get suppliers => _suppliers;
  List<CategoryEntity> get categories => _categories;
  List<SubCategoryEntity> get subCategories => _subCategories;
  List<String> get currencies => _currencies;

  // Convert entities to strings for UI compatibility
  List<String> get sizes =>
      _sizesEntities.map((InventorySizesEntity e) => e.sizeName).toList();
  List<String> get colors =>
      _colorsEntities.map((InventoryColorsEntity e) => e.colorName).toList();

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isLoadingSubCategories => _isLoadingSubCategories;
  bool get autoGenerateCode => _autoGenerateCode;

  // VISIBILITY RULES based on product definition
  bool get shouldShowSupplier => _selectedLineItem != null;
  bool get shouldShowCategory => _selectedLineItem != null;
  bool get shouldShowSubCategory => _selectedCategory != null;
  bool get shouldShowSizes => _selectedCategory != null;
  bool get shouldShowColors => _selectedCategory != null;
  bool get shouldShowDefaultSizeColor =>
      _selectedSizes.isNotEmpty || _selectedColors.isNotEmpty;

  // Additional visibility rules for other fields
  bool get shouldShowAgeGroup => _selectedCategory != null;
  bool get shouldShowLifeType => _selectedCategory != null;
  bool get shouldShowPurchaseConvUnit => _selectedCategory != null;
  bool get shouldShowAcquireType => _selectedLineItem != null;
  bool get shouldShowPurchaseType => _selectedLineItem != null;
  bool get shouldShowManufacturing => _selectedLineItem != null;

  // Getters for placeholder lists
  List<String> get productGroups => _productGroups;
  List<String> get ageGroups => _ageGroups;
  List<String> get packagingTypes => _packagingTypes;
  List<String> get productGenders => _productGenders;
  List<String> get purchaseConvUnits => <String>[];
  List<String> get acquireTypes => <String>[];
  List<String> get purchaseTypes => <String>[];
  List<String> get manufacturingTypes => <String>[];
  List<String> get lifeTypes => _lifeTypes;

  // Placeholder getters for fields not in database yet
  String? get selectedProductGroup => _selectedProductGroup;
  String? get selectedAgeGroup => _selectedAgeGroup;
  String? get selectedPackagingType => _selectedPackagingType;
  String? get selectedProductGender => _selectedProductGender;
  String? get selectedLifeType => _selectedLifeType;
  String? get selectedPurchaseConvUnit => null;
  String? get selectedAcquireType => null;
  String? get selectedPurchaseType => null;
  String? get selectedManufacturing => null;

  // PROFIT CALCULATIONS
  double get profitMargin {
    final double cost = double.tryParse(averageCostController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0;
    if (cost == 0 || price == 0) return 0;
    return ((price - cost) / price) * 100;
  }

  double get markupPercentage {
    final double cost = double.tryParse(averageCostController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0;
    if (cost == 0) return 0;
    return ((price - cost) / cost) * 100;
  }

  /// Initialize form controllers with listeners
  void _initializeFormControllers() {
    averageCostController.addListener(_onPriceChanged);
    priceController.addListener(_onPriceChanged);
  }

  /// Handle price changes for calculations
  void _onPriceChanged() {
    notifyListeners();
  }

  /// Load initial form data from database
  Future<void> _loadFormData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load all data in parallel - NO HARDCODED DATA
      await Future.wait(<Future<void>>[
        _loadInventoryLines(),
        _loadCategories(),
        _loadSuppliers(),
        _loadColors(),
        _loadSizes(),
      ]);

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

  /// Load inventory lines from database
  Future<void> _loadInventoryLines() async {
    final DataState<List<InventoryLineEntity>> result =
        await _getInventoryLinesUseCase.call();

    if (result.isSuccess) {
      _inventoryLines = result.data ?? <InventoryLineEntity>[];
    } else {
      debugPrint('Failed to load inventory lines: ${result.error}');
    }
  }

  /// Load categories from database
  Future<void> _loadCategories() async {
    final DataState<List<CategoryEntity>> result = await _getCategoriesUseCase
        .call();

    if (result.isSuccess) {
      _categories = result.data ?? <CategoryEntity>[];
    } else {
      debugPrint('Failed to load categories: ${result.error}');
    }
  }

  /// Load suppliers from database
  Future<void> _loadSuppliers() async {
    final DataState<List<SupplierEntity>> result = await _getSuppliersUseCase
        .call();

    if (result.isSuccess) {
      _suppliers = result.data ?? <SupplierEntity>[];
    } else {
      debugPrint('Failed to load suppliers: ${result.error}');
    }
  }

  /// Load colors from database
  Future<void> _loadColors() async {
    final DataState<List<InventoryColorsEntity>> result =
        await _getColorsUseCase.call();

    if (result.isSuccess) {
      _colorsEntities = result.data ?? <InventoryColorsEntity>[];
    } else {
      debugPrint('Failed to load colors: ${result.error}');
    }
  }

  /// Load sizes from database
  Future<void> _loadSizes() async {
    final DataState<List<InventorySizesEntity>> result = await _getSizesUseCase
        .call();

    if (result.isSuccess) {
      _sizesEntities = result.data ?? <InventorySizesEntity>[];
    } else {
      debugPrint('Failed to load sizes: ${result.error}');
    }
  }

  /// Load subcategories when category is selected
  Future<void> _loadSubCategories(String categoryId) async {
    _isLoadingSubCategories = true;
    notifyListeners();

    try {
      final DataState<List<SubCategoryEntity>> result =
          await _getSubCategoriesUseCase.call(
            params: GetSubCategoriesParams(categoryId: categoryId),
          );

      if (result.isSuccess) {
        _subCategories = result.data ?? <SubCategoryEntity>[];
      } else {
        _subCategories = <SubCategoryEntity>[];
        debugPrint('Failed to load subcategories: ${result.error}');
      }
    } catch (e) {
      _subCategories = <SubCategoryEntity>[];
      debugPrint('Error loading subcategories: $e');
    } finally {
      _isLoadingSubCategories = false;
      notifyListeners();
    }
  }

  /// Generate product code automatically
  void _generateProductCode() {
    if (_autoGenerateCode) {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      productCodeController.text =
          'PRD-${timestamp.substring(timestamp.length - 8)}';
    }
  }

  /// Set line item
  void setLineItem(InventoryLineEntity? lineItem) {
    _selectedLineItem = lineItem;
    // Reset dependent fields
    _selectedSupplier = null;
    _selectedCategory = null;
    _selectedSubCategory = null;
    _subCategories = <SubCategoryEntity>[];
    notifyListeners();
  }

  /// Set supplier (visibility depends on line item)
  void setSupplier(SupplierEntity? supplier) {
    _selectedSupplier = supplier;
    notifyListeners();
  }

  /// Set category (triggers subcategory load)
  void setCategory(CategoryEntity? category) {
    _selectedCategory = category;
    _selectedSubCategory = null;
    _subCategories = <SubCategoryEntity>[];

    if (category != null) {
      _loadSubCategories(category.categoryId);
    }

    notifyListeners();
  }

  /// Set subcategory
  void setSubCategory(SubCategoryEntity? subCategory) {
    _selectedSubCategory = subCategory;
    notifyListeners();
  }

  /// Set sizes
  void setSizes(List<String> sizes) {
    _selectedSizes = sizes;
    // Reset default size if not in selected sizes
    if (_selectedDefaultSize != null && !sizes.contains(_selectedDefaultSize)) {
      _selectedDefaultSize = null;
    }
    notifyListeners();
  }

  /// Set colors
  void setColors(List<String> colors) {
    _selectedColors = colors;
    // Reset default color if not in selected colors
    if (_selectedDefaultColor != null &&
        !colors.contains(_selectedDefaultColor)) {
      _selectedDefaultColor = null;
    }
    notifyListeners();
  }

  /// Set default size
  void setDefaultSize(String? size) {
    _selectedDefaultSize = size;
    notifyListeners();
  }

  /// Set default color
  void setDefaultColor(String? color) {
    _selectedDefaultColor = color;
    notifyListeners();
  }

  /// Set currency
  void setCurrency(String? currency) {
    _selectedCurrency = currency ?? 'PKR';
    notifyListeners();
  }

  /// Set date
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Toggle auto-generate code
  void toggleAutoGenerateCode(bool value) {
    _autoGenerateCode = value;
    if (value) {
      _generateProductCode();
    }
    notifyListeners();
  }

  // Placeholder setters for fields not in database yet
  void setProductGroup(String? group) {
    _selectedProductGroup = group;
    notifyListeners();
  }

  void setAgeGroup(String? ageGroup) {
    _selectedAgeGroup = ageGroup;
    notifyListeners();
  }

  void setPackagingType(String? type) {
    _selectedPackagingType = type;
    notifyListeners();
  }

  void setProductGender(String? gender) {
    _selectedProductGender = gender;
    notifyListeners();
  }

  void setLifeType(String? type) {
    _selectedLifeType = type;
    notifyListeners();
  }

  void setPurchaseConvUnit(String? unit) => notifyListeners();
  void setAcquireType(String? type) => notifyListeners();
  void setPurchaseType(String? type) => notifyListeners();
  void setManufacturing(String? type) => notifyListeners();

  /// Add new line item dialog
  Future<InventoryLineEntity?> addNewLineItem(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Inventory Line',
        itemType: 'inventory_line',
        hasCodeField: true,
      ),
    );

    if (result != null) {
      try {
        const String businessId = 'default-business';
        final InventoryLineCompanion companion = InventoryLineCompanion.insert(
          inventoryLineId: const Uuid().v4(),
          businessId: businessId,
          lineName: result['name'] as String,
          lineCode: result['code'] as String? ?? '',
        );

        final AppDatabase db = sl<AppDatabase>();
        await db.into(db.inventoryLine).insert(companion);

        // Refresh the inventory lines list
        await _loadInventoryLines();

        // Return the newly created entity
        final InventoryLineEntity newEntity = InventoryLineEntity(
          inventoryLineId: companion.inventoryLineId.value,
          businessId: companion.businessId.value,
          lineName: companion.lineName.value,
          lineCode: companion.lineCode.value,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return newEntity;
      } catch (e) {
        debugPrint('Error adding new inventory line: $e');
        return null;
      }
    }
    return null;
  }

  /// Add new supplier dialog
  Future<SupplierEntity?> addNewSupplier(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Supplier',
        itemType: 'supplier',
        hasCodeField: true,
      ),
    );

    if (result != null) {
      try {
        const String businessId = 'default-business';
        final SuppliersCompanion companion = SuppliersCompanion.insert(
          supplierId: const Uuid().v4(),
          businessId: businessId,
          supplierName: result['name'] as String,
          supplierCode: result['code'] as String? ?? '',
        );

        final AppDatabase db = sl<AppDatabase>();
        await db.into(db.suppliers).insert(companion);

        // Refresh the suppliers list
        await _loadSuppliers();

        // Return the newly created entity
        final SupplierEntity newEntity = SupplierEntity(
          supplierId: companion.supplierId.value,
          businessId: companion.businessId.value,
          supplierName: companion.supplierName.value,
          supplierCode: companion.supplierCode.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return newEntity;
      } catch (e) {
        debugPrint('Error adding new supplier: $e');
        return null;
      }
    }
    return null;
  }

  /// Add new category dialog
  Future<CategoryEntity?> addNewCategory(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => AddDropdownItemDialog(
        title: 'Category',
        itemType: 'category',
        hasCodeField: true,
        parentEntity: _selectedLineItem?.lineName,
      ),
    );

    if (result != null) {
      try {
        const String businessId = 'default-business';
        final CategoryTableCompanion companion = CategoryTableCompanion.insert(
          categoryId: const Uuid().v4(),
          businessId: businessId,
          categoryName: result['name'] as String,
          categoryCode: result['code'] as String? ?? '',
        );

        final AppDatabase db = sl<AppDatabase>();
        await db.into(db.categoryTable).insert(companion);

        // Refresh the categories list
        await _loadCategories();

        // Return the newly created entity
        final CategoryEntity newEntity = CategoryEntity(
          categoryId: companion.categoryId.value,
          businessId: companion.businessId.value,
          categoryName: companion.categoryName.value,
          categoryCode: companion.categoryCode.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return newEntity;
      } catch (e) {
        debugPrint('Error adding new category: $e');
        return null;
      }
    }
    return null;
  }

  /// Add new sub category dialog
  Future<SubCategoryEntity?> addNewSubCategory(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => AddDropdownItemDialog(
        title: 'Sub Category',
        itemType: 'sub_category',
        hasCodeField: true,
        parentEntity: _selectedCategory?.categoryName,
      ),
    );

    if (result != null) {
      try {
        const String businessId = 'default-business';
        final SubCategoryCompanion companion = SubCategoryCompanion.insert(
          subCategoryId: const Uuid().v4(),
          businessId: businessId,
          subCategoryName: result['name'] as String,
          subCategoryCode: result['code'] as String? ?? '',
          categoryId: _selectedCategory?.categoryId ?? '',
        );

        final AppDatabase db = sl<AppDatabase>();
        await db.into(db.subCategory).insert(companion);

        // Refresh the subcategories list
        await _loadSubCategories(companion.categoryId.value);

        // Return the newly created entity
        final SubCategoryEntity newEntity = SubCategoryEntity(
          subCategoryId: companion.subCategoryId.value,
          businessId: companion.businessId.value,
          subCategoryName: companion.subCategoryName.value,
          subCategoryCode: companion.subCategoryCode.value,
          categoryId: companion.categoryId.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        return newEntity;
      } catch (e) {
        debugPrint('Error adding new sub category: $e');
        return null;
      }
    }
    return null;
  }

  /// Add new product group dialog (placeholder - not in database yet)
  Future<String?> addNewProductGroup(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Product Group',
        itemType: 'product_group',
        hasCodeField: false,
      ),
    );

    if (result != null) {
      final String newGroup = result['name'] as String;
      // TODO: Save to database when table is created
      // For now, just add to local list
      _productGroups.add(newGroup);
      notifyListeners();
      return newGroup;
    }
    return null;
  }

  /// Add new age group dialog (placeholder - not in database yet)
  Future<String?> addNewAgeGroup(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Age Group',
        itemType: 'age_group',
        hasCodeField: false,
      ),
    );

    if (result != null) {
      final String newAgeGroup = result['name'] as String;
      // TODO: Save to database when table is created
      // For now, just add to local list
      _ageGroups.add(newAgeGroup);
      notifyListeners();
      return newAgeGroup;
    }
    return null;
  }

  /// Add new packaging type dialog (placeholder - not in database yet)
  Future<String?> addNewPackagingType(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Packaging Type',
        itemType: 'packaging_type',
        hasCodeField: false,
      ),
    );

    if (result != null) {
      final String newPackagingType = result['name'] as String;
      // TODO: Save to database when table is created
      // For now, just add to local list
      _packagingTypes.add(newPackagingType);
      notifyListeners();
      return newPackagingType;
    }
    return null;
  }

  /// Add new product gender dialog (placeholder - not in database yet)
  Future<String?> addNewProductGender(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Product Gender',
        itemType: 'product_gender',
        hasCodeField: false,
      ),
    );

    if (result != null) {
      final String newGender = result['name'] as String;
      // TODO: Save to database when table is created
      // For now, just add to local list
      _productGenders.add(newGender);
      notifyListeners();
      return newGender;
    }
    return null;
  }

  /// Add new life type dialog (placeholder - not in database yet)
  Future<String?> addNewLifeType(BuildContext context) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => const AddDropdownItemDialog(
        title: 'Life Type',
        itemType: 'life_type',
        hasCodeField: false,
      ),
    );

    if (result != null) {
      final String newLifeType = result['name'] as String;
      // TODO: Save to database when table is created
      // For now, just add to local list
      _lifeTypes.add(newLifeType);
      notifyListeners();
      return newLifeType;
    }
    return null;
  }

  /// Clear form
  void clearForm() {
    // Clear all controllers
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
    _selectedSizes = <String>[];
    _selectedColors = <String>[];
    _selectedDefaultSize = null;
    _selectedDefaultColor = null;
    _selectedDate = null;
    _selectedCurrency = 'PKR';

    // Clear subcategories
    _subCategories = <SubCategoryEntity>[];

    // Regenerate code if auto-generate is enabled
    if (_autoGenerateCode) {
      _generateProductCode();
    }

    notifyListeners();
  }

  /// Save inventory
  Future<bool> saveInventory() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    _isSaving = true;
    notifyListeners();

    try {
      // TODO: Implement save to database
      await Future<void>.delayed(const Duration(seconds: 2)); // Simulate save
      return true;
    } catch (e) {
      debugPrint('Error saving inventory: $e');
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
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
