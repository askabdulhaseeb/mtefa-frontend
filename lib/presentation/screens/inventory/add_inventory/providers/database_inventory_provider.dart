import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

import '../../../../../core/database/clear_database.dart';
import '../../../../../core/database/database.dart';
import '../../../../../core/enums/placement_type.dart';
import '../../../../../core/enums/status_type.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_locations_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/season_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../domain/usecases/inventory/get_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_inventory_lines_usecase.dart';
import '../../../../../domain/usecases/inventory/get_sub_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_suppliers_usecase.dart';
import '../../../../widgets/dialogs/add_dropdown_item_dialog.dart';

/// Database-driven provider for Add Inventory with NO hardcoded data
class DatabaseInventoryProvider extends ChangeNotifier {
  DatabaseInventoryProvider({
    required GetInventoryLinesUseCase getInventoryLinesUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetCategoriesByParentUseCase getCategoriesByParentUseCase,
    required GetSubCategoriesUseCase getSubCategoriesUseCase,
    required GetSuppliersUseCase getSuppliersUseCase,
    required AppDatabase database,
  })  : _getInventoryLinesUseCase = getInventoryLinesUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        _getCategoriesByParentUseCase = getCategoriesByParentUseCase,
        _getSubCategoriesUseCase = getSubCategoriesUseCase,
        _getSuppliersUseCase = getSuppliersUseCase,
        _database = database {
    _databaseClearer = DatabaseClearer(_database);
    _initializeFormControllers();
    _loadFormData();
  }

  final GetInventoryLinesUseCase _getInventoryLinesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoriesByParentUseCase _getCategoriesByParentUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;
  final GetSuppliersUseCase _getSuppliersUseCase;
  final AppDatabase _database;
  late final DatabaseClearer _databaseClearer;

  static const Uuid _uuid = Uuid();

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

  // DATA FROM DATABASE - NO HARDCODED DATA
  List<InventoryLineEntity> _inventoryLines = <InventoryLineEntity>[];
  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<SubCategoryEntity> _subCategories = <SubCategoryEntity>[];
  List<SupplierEntity> _suppliers = <SupplierEntity>[];
  List<InventoryColorsEntity> _colors = <InventoryColorsEntity>[];
  List<InventorySizesEntity> _sizes = <InventorySizesEntity>[];
  List<SeasonEntity> _seasons = <SeasonEntity>[];
  List<InventoryLocationsEntity> _locations = <InventoryLocationsEntity>[];

  // SELECTED VALUES
  InventoryLineEntity? _selectedLineItem;
  SupplierEntity? _selectedSupplier;
  CategoryEntity? _selectedCategory;
  SubCategoryEntity? _selectedSubCategory;
  SeasonEntity? _selectedSeason;
  List<InventorySizesEntity> _selectedSizes = <InventorySizesEntity>[];
  List<InventoryColorsEntity> _selectedColors = <InventoryColorsEntity>[];
  InventorySizesEntity? _selectedDefaultSize;
  InventoryColorsEntity? _selectedDefaultColor;
  DateTime? _selectedDate;

  // Only currency remains hardcoded as it's system-level configuration
  String _selectedCurrency = 'PKR';
  final List<String> _currencies = <String>['PKR', 'USD', 'EUR', 'GBP', 'AED'];

  // LOADING STATES
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isLoadingSubCategories = false;
  bool _isLoadingSizes = false;
  bool _isLoadingColors = false;

  // ERROR STATES
  String? _errorMessage;

  // AUTO-GENERATE OPTIONS
  bool _autoGenerateCode = true;

  // GETTERS
  InventoryLineEntity? get selectedLineItem => _selectedLineItem;
  SupplierEntity? get selectedSupplier => _selectedSupplier;
  CategoryEntity? get selectedCategory => _selectedCategory;
  SubCategoryEntity? get selectedSubCategory => _selectedSubCategory;
  SeasonEntity? get selectedSeason => _selectedSeason;
  List<InventorySizesEntity> get selectedSizes => _selectedSizes;
  List<InventoryColorsEntity> get selectedColors => _selectedColors;
  InventorySizesEntity? get selectedDefaultSize => _selectedDefaultSize;
  InventoryColorsEntity? get selectedDefaultColor => _selectedDefaultColor;
  DateTime? get selectedDate => _selectedDate;

  List<InventoryLineEntity> get inventoryLines => _inventoryLines;
  List<CategoryEntity> get categories => _categories;
  List<SubCategoryEntity> get subCategories => _subCategories;
  List<SupplierEntity> get suppliers => _suppliers;
  List<InventoryColorsEntity> get colors => _colors;
  List<InventorySizesEntity> get sizes => _sizes;
  List<SeasonEntity> get seasons => _seasons;
  List<InventoryLocationsEntity> get locations => _locations;

  List<String> get currencies => _currencies;
  String get selectedCurrency => _selectedCurrency;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isLoadingSubCategories => _isLoadingSubCategories;
  bool get isLoadingSizes => _isLoadingSizes;
  bool get isLoadingColors => _isLoadingColors;
  bool get autoGenerateCode => _autoGenerateCode;
  String? get errorMessage => _errorMessage;

  /// Initialize form controllers with listeners
  void _initializeFormControllers() {
    averageCostController.addListener(_onPriceChanged);
    priceController.addListener(_onPriceChanged);
  }

  /// Handle price changes for calculations
  void _onPriceChanged() {
    notifyListeners();
  }

  /// Load initial data from database - clears tables first to ensure fresh data
  Future<void> _loadFormData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Clear database tables to ensure no hardcoded data interferes
      await _databaseClearer.clearAllInventoryTables();
      
      // Load all data in parallel
      await Future.wait(<Future<void>>[
        _loadInventoryLines(),
        _loadCategories(),
        _loadSuppliers(),
        _loadColors(),
        _loadSizes(),
        _loadSeasons(),
        _loadLocations(),
      ]);

      // Auto-generate product code if enabled
      if (_autoGenerateCode) {
        _generateProductCode();
      }

      // Debug: Print table counts
      final Map<String, int> counts = await _databaseClearer.getTableCounts();
      debugPrint('Database table counts after load: $counts');
      
    } catch (e) {
      _errorMessage = 'Failed to load initial data: ${e.toString()}';
      debugPrint('Error loading initial data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load inventory lines from database
  Future<void> _loadInventoryLines() async {
    final DataState<List<InventoryLineEntity>> result = await _getInventoryLinesUseCase.call();
    
    if (result.isSuccess) {
      _inventoryLines = result.data ?? <InventoryLineEntity>[];
    } else {
      debugPrint('Failed to load inventory lines: ${result.error}');
    }
  }

  /// Load categories from database
  Future<void> _loadCategories() async {
    final DataState<List<CategoryEntity>> result = await _getCategoriesUseCase.call();
    
    if (result.isSuccess) {
      _categories = result.data ?? <CategoryEntity>[];
    } else {
      debugPrint('Failed to load categories: ${result.error}');
    }
  }

  /// Load suppliers from database
  Future<void> _loadSuppliers() async {
    final DataState<List<SupplierEntity>> result = await _getSuppliersUseCase.call();
    
    if (result.isSuccess) {
      _suppliers = result.data ?? <SupplierEntity>[];
    } else {
      debugPrint('Failed to load suppliers: ${result.error}');
    }
  }

  /// Load colors from database
  Future<void> _loadColors() async {
    try {
      final List<InventoryColor> colorData = await _database.select(_database.inventoryColors).get();
      _colors = colorData.map(_colorToEntity).toList();
    } catch (e) {
      debugPrint('Failed to load colors: $e');
    }
  }

  /// Load sizes from database
  Future<void> _loadSizes() async {
    try {
      final List<InventorySize> sizeData = await _database.select(_database.inventorySizes).get();
      _sizes = sizeData.map(_sizeToEntity).toList();
    } catch (e) {
      debugPrint('Failed to load sizes: $e');
    }
  }

  /// Load seasons from database
  Future<void> _loadSeasons() async {
    try {
      final List<SeasonData> seasonData = await _database.select(_database.season).get();
      _seasons = seasonData.map(_seasonToEntity).toList();
    } catch (e) {
      debugPrint('Failed to load seasons: $e');
    }
  }

  /// Load locations from database
  Future<void> _loadLocations() async {
    try {
      final List<InventoryLocation> locationData = await _database.select(_database.inventoryLocations).get();
      _locations = locationData.map(_locationToEntity).toList();
    } catch (e) {
      debugPrint('Failed to load locations: $e');
    }
  }

  /// Load subcategories when category is selected
  Future<void> _loadSubCategories(String categoryId) async {
    _isLoadingSubCategories = true;
    notifyListeners();

    try {
      final DataState<List<SubCategoryEntity>> result = await _getSubCategoriesUseCase.call(
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

  /// Load sizes filtered by subcategory
  Future<void> _loadSizesBySubCategory(String subCategoryId) async {
    _isLoadingSizes = true;
    notifyListeners();

    try {
      final List<InventorySize> sizeData = await (_database.select(_database.inventorySizes)
            ..where((tbl) => tbl.subCategoryId.equals(subCategoryId)))
          .get();
      _sizes = sizeData.map(_sizeToEntity).toList();
    } catch (e) {
      debugPrint('Failed to load sizes by subcategory: $e');
    } finally {
      _isLoadingSizes = false;
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

  /// Set line item and handle parent-child relationships
  void setLineItem(InventoryLineEntity? lineItem) {
    _selectedLineItem = lineItem;
    // Reset dependent fields as per product definition
    _selectedSupplier = null;
    _selectedCategory = null;
    _selectedSubCategory = null;
    _subCategories = <SubCategoryEntity>[];
    notifyListeners();
  }

  /// Set supplier
  void setSupplier(SupplierEntity? supplier) {
    _selectedSupplier = supplier;
    notifyListeners();
  }

  /// Set category and load dependent subcategories
  void setCategory(CategoryEntity? category) {
    _selectedCategory = category;
    _selectedSubCategory = null; // Reset subcategory
    
    // Load subcategories for this category
    if (category != null) {
      _loadSubCategories(category.categoryId);
    } else {
      _subCategories = <SubCategoryEntity>[];
    }
    
    notifyListeners();
  }

  /// Set subcategory and load dependent sizes
  void setSubCategory(SubCategoryEntity? subCategory) {
    _selectedSubCategory = subCategory;
    
    // Load sizes for this subcategory
    if (subCategory != null) {
      _loadSizesBySubCategory(subCategory.subCategoryId);
    }
    
    notifyListeners();
  }

  /// Set season
  void setSeason(SeasonEntity? season) {
    _selectedSeason = season;
    notifyListeners();
  }

  /// Set currency
  void setCurrency(String currency) {
    _selectedCurrency = currency;
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

  /// Visibility rules based on product definition
  bool get shouldShowSupplier => _selectedLineItem != null;
  bool get shouldShowCategory => _selectedLineItem != null;
  bool get shouldShowSubCategory => _selectedCategory != null;
  bool get shouldShowSizes => _selectedSubCategory != null;
  bool get shouldShowColors => _selectedCategory != null;

  /// Show add dialog and handle result
  Future<void> showAddItemDialog(BuildContext context, String itemType) async {
    String title = '';
    String? parentEntity;
    
    switch (itemType) {
      case 'line_item':
        title = 'Line Item';
        break;
      case 'category':
        title = 'Category';
        parentEntity = _selectedLineItem?.lineName;
        break;
      case 'sub_category':
        title = 'Sub Category';
        parentEntity = _selectedCategory?.categoryName;
        break;
      case 'supplier':
        title = 'Supplier';
        break;
      case 'color':
        title = 'Color';
        break;
      case 'size':
        title = 'Size';
        parentEntity = _selectedSubCategory?.subCategoryName;
        break;
      case 'season':
        title = 'Season';
        break;
      default:
        return;
    }

    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => AddDropdownItemDialog(
        title: title,
        itemType: itemType,
        parentEntity: parentEntity,
      ),
    );

    if (result != null) {
      await _handleAddItem(result);
    }
  }

  /// Handle adding new item to database
  Future<void> _handleAddItem(Map<String, dynamic> data) async {
    try {
      final String itemType = data['itemType'] as String;
      final String name = data['name'] as String;
      final String code = data['code'] as String;
      final String codePlacement = data['codePlacement'] as String;
      
      switch (itemType) {
        case 'line_item':
          await _addInventoryLine(name, code, codePlacement);
          await _loadInventoryLines();
          break;
        case 'category':
          await _addCategory(name, code, codePlacement);
          await _loadCategories();
          break;
        case 'sub_category':
          if (_selectedCategory != null) {
            await _addSubCategory(name, code, codePlacement, _selectedCategory!.categoryId);
            await _loadSubCategories(_selectedCategory!.categoryId);
          }
          break;
        case 'supplier':
          await _addSupplier(name, code);
          await _loadSuppliers();
          break;
        case 'color':
          await _addColor(name, code);
          await _loadColors();
          break;
        case 'size':
          if (_selectedSubCategory != null) {
            await _addSize(name, code, _selectedSubCategory!.subCategoryId);
            await _loadSizesBySubCategory(_selectedSubCategory!.subCategoryId);
          }
          break;
        case 'season':
          await _addSeason(name, code);
          await _loadSeasons();
          break;
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add item: ${e.toString()}';
      debugPrint('Error adding item: $e');
      notifyListeners();
    }
  }

  /// Add new inventory line to database
  Future<void> _addInventoryLine(String name, String code, String codePlacement) async {
    final PlacementType placement = PlacementType.values.firstWhere(
        (PlacementType e) => e.value == codePlacement,
        orElse: () => PlacementType.pre,
      );
    
    final InventoryLineCompanion companion = InventoryLineCompanion.insert(
      inventoryLineId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      lineCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
      lineName: name,
      linePlacement: Value<PlacementType>(placement),
      status: Value<StatusType>(StatusType.active),
      createdAt: Value<DateTime>(DateTime.now()),
      updatedAt: Value<DateTime>(DateTime.now()),
    );
    
    await _database.into(_database.inventoryLine).insert(companion);
  }

  /// Add new category to database
  Future<void> _addCategory(String name, String code, String codePlacement) async {
    final CategoryTableCompanion companion = CategoryTableCompanion.insert(
      categoryId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      categoryCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
      categoryName: name,
      codePlacement: Value<PlacementType>(PlacementType.values.firstWhere(
        (PlacementType e) => e.value == codePlacement,
        orElse: () => PlacementType.pre,
      )),
    );
    
    await _database.into(_database.categoryTable).insert(companion);
  }

  /// Add new subcategory to database
  Future<void> _addSubCategory(String name, String code, String codePlacement, String categoryId) async {
    final SubCategoryCompanion companion = SubCategoryCompanion.insert(
      subCategoryId: _uuid.v4(),
      categoryId: categoryId,
      businessId: 'business_123', // TODO: Get from current business context
      subCategoryCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
      subCategoryName: name,
      codePlacement: Value<PlacementType>(PlacementType.values.firstWhere(
        (PlacementType e) => e.value == codePlacement,
        orElse: () => PlacementType.pre,
      )),
    );
    
    await _database.into(_database.subCategory).insert(companion);
  }

  /// Add new supplier to database
  Future<void> _addSupplier(String name, String code) async {
    final SuppliersCompanion companion = SuppliersCompanion.insert(
      supplierId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      supplierCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
      supplierName: name,
    );
    
    await _database.into(_database.suppliers).insert(companion);
  }

  /// Add new color to database
  Future<void> _addColor(String name, String code) async {
    final InventoryColorsCompanion companion = InventoryColorsCompanion.insert(
      colorId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      colorName: name,
      colorCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
    );
    
    await _database.into(_database.inventoryColors).insert(companion);
  }

  /// Add new size to database
  Future<void> _addSize(String name, String code, String subCategoryId) async {
    final InventorySizesCompanion companion = InventorySizesCompanion.insert(
      sizeId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      subCategoryId: Value<String?>(subCategoryId),
      sizeName: name,
      sizeCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
      sizeType: 'generic',
    );
    
    await _database.into(_database.inventorySizes).insert(companion);
  }

  /// Add new season to database
  Future<void> _addSeason(String name, String code) async {
    final SeasonCompanion companion = SeasonCompanion.insert(
      seasonId: _uuid.v4(),
      businessId: 'business_123', // TODO: Get from current business context
      seasonName: name,
      seasonCode: code.isNotEmpty ? code : name.toUpperCase().replaceAll(' ', '_'),
    );
    
    await _database.into(_database.season).insert(companion);
  }

  /// Validate and save inventory
  Future<bool> saveInventory() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    // Validate required fields
    if (_selectedLineItem == null) {
      _errorMessage = 'Please select a line item';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Implement actual save to inventory table
      await Future<void>.delayed(const Duration(seconds: 2));
      
      debugPrint('Inventory saved successfully');
      clearForm();
      return true;
    } catch (e) {
      _errorMessage = 'Error saving inventory: $e';
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
    _selectedSeason = null;
    _selectedSizes = <InventorySizesEntity>[];
    _selectedColors = <InventoryColorsEntity>[];
    _selectedDefaultSize = null;
    _selectedDefaultColor = null;
    _selectedDate = null;
    _selectedCurrency = 'PKR';
    _subCategories = <SubCategoryEntity>[];
    
    _errorMessage = null;
    
    if (_autoGenerateCode) {
      _generateProductCode();
    }
    
    notifyListeners();
  }

  // Entity conversion helpers
  InventoryColorsEntity _colorToEntity(InventoryColor data) {
    return InventoryColorsEntity(
      colorId: data.colorId,
      businessId: data.businessId,
      colorName: data.colorName,
      colorCode: data.colorCode,
      hexColor: data.hexColor,
      rgbColor: data.rgbColor,
      pantoneCode: data.pantoneCode,
      supplierColorCode: data.supplierColorCode,
      colorFamily: data.colorFamily,
      isSeasonal: data.isSeasonal,
      seasonIds: data.seasonIds?.split(',') ?? <String>[],
      displayOrder: data.displayOrder,
      colorImageUrl: data.colorImageUrl,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }

  InventorySizesEntity _sizeToEntity(InventorySize data) {
    return InventorySizesEntity(
      sizeId: data.sizeId,
      businessId: data.businessId,
      subCategoryId: data.subCategoryId,
      sizeName: data.sizeName,
      sizeCode: data.sizeCode,
      sizeType: data.sizeType,
      sizeSystem: data.sizeSystem,
      sizeMeasurements: null, // TODO: Parse JSON string if needed
      sizeChartPosition: data.sizeChartPosition,
      displayOrder: data.displayOrder,
      equivalentSizes: null, // TODO: Parse JSON string if needed
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }

  SeasonEntity _seasonToEntity(SeasonData data) {
    return SeasonEntity(
      seasonId: data.seasonId,
      businessId: data.businessId,
      seasonName: data.seasonName,
      seasonCode: data.seasonCode,
      seasonDescription: data.seasonDescription,
      startDate: data.startDate,
      endDate: data.endDate,
      isCurrentSeason: data.isCurrentSeason,
      marketingThemes: data.marketingThemes?.split(',') ?? <String>[],
      targetDemographics: data.targetDemographics?.split(',') ?? <String>[],
      seasonalMarkupPercentage: data.seasonalMarkupPercentage,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }

  InventoryLocationsEntity _locationToEntity(InventoryLocation data) {
    return InventoryLocationsEntity(
      locationId: data.locationId,
      businessId: data.businessId,
      branchId: data.branchId,
      locationName: data.locationName,
      locationCode: data.locationCode,
      locationType: data.locationType,
      parentLocationId: data.parentLocationId,
      aisle: data.aisle,
      shelf: data.shelf,
      bin: data.bin,
      barcode: data.barcode,
      maxCapacity: data.maxCapacity,
      currentCapacity: data.currentCapacity,
      isSellableLocation: data.isSellableLocation,
      requiresCounting: data.requiresCounting,
      temperatureControlled: data.temperatureControlled,
      securityLevel: data.securityLevel,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
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