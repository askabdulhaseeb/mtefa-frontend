import 'package:flutter/material.dart';

import '../../../../../core/database/clear_database.dart';
import '../../../../../core/database/database.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_locations_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/season_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../domain/repositories/category_repository.dart';
import '../../../../../domain/repositories/inventory_colors_repository.dart';
import '../../../../../domain/repositories/inventory_line_repository.dart';
import '../../../../../domain/repositories/inventory_locations_repository.dart';
import '../../../../../domain/repositories/inventory_sizes_repository.dart';
import '../../../../../domain/repositories/season_repository.dart';
import '../../../../../domain/repositories/sub_category_repository.dart';
import '../../../../../domain/repositories/supplier_repository.dart';
import '../../../../../domain/usecases/inventory/get_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_inventory_lines_usecase.dart';
import '../../../../../domain/usecases/inventory/get_sub_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_suppliers_usecase.dart';
import 'inventory_coordinator_provider.dart';

/// Refactored database-driven provider that delegates to the new modular architecture
/// This replaces the previous 870-line monolithic implementation with a focused approach
class DatabaseInventoryProvider extends ChangeNotifier {
  DatabaseInventoryProvider({
    required AppDatabase database,
    required GetInventoryLinesUseCase getInventoryLinesUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetSubCategoriesUseCase getSubCategoriesUseCase,
    required GetSuppliersUseCase getSuppliersUseCase,
    required InventoryLineRepository inventoryLineRepository,
    required CategoryRepository categoryRepository,
    required SubCategoryRepository subCategoryRepository,
    required SupplierRepository supplierRepository,
    required InventoryColorsRepository colorsRepository,
    required InventorySizesRepository sizesRepository,
    required SeasonRepository seasonRepository,
    required InventoryLocationsRepository locationsRepository,
  }) : _database = database {
    _databaseClearer = DatabaseClearer(_database);
    
    // Initialize the coordinator provider with new modular architecture
    _coordinatorProvider = InventoryCoordinatorProvider(
      database: database,
      getInventoryLinesUseCase: getInventoryLinesUseCase,
      getCategoriesUseCase: getCategoriesUseCase,
      getSubCategoriesUseCase: getSubCategoriesUseCase,
      getSuppliersUseCase: getSuppliersUseCase,
      inventoryLineRepository: inventoryLineRepository,
      categoryRepository: categoryRepository,
      subCategoryRepository: subCategoryRepository,
      supplierRepository: supplierRepository,
      colorsRepository: colorsRepository,
      sizesRepository: sizesRepository,
      seasonRepository: seasonRepository,
      locationsRepository: locationsRepository,
    );

    // Forward coordinator notifications
    _coordinatorProvider.addListener(() {
      notifyListeners();
    });

    _initializeWithCleanDatabase();
  }

  final AppDatabase _database;
  late final DatabaseClearer _databaseClearer;
  late final InventoryCoordinatorProvider _coordinatorProvider;

  // Loading and error states specific to database operations
  bool _isDatabaseClearing = false;
  String? _errorMessage;

  // GETTERS - Delegate to coordinator provider
  GlobalKey<FormState> get formKey => _coordinatorProvider.formKey;

  // Form controllers
  TextEditingController get productCodeController => _coordinatorProvider.form.productCodeController;
  TextEditingController get productNameController => _coordinatorProvider.form.productNameController;
  TextEditingController get averageCostController => _coordinatorProvider.form.averageCostController;
  TextEditingController get shopQualityController => _coordinatorProvider.form.shopQualityController;
  TextEditingController get storeQualityController => _coordinatorProvider.form.storeQualityController;
  TextEditingController get priceController => _coordinatorProvider.form.priceController;
  TextEditingController get vatController => _coordinatorProvider.form.vatController;
  TextEditingController get userPriceController => _coordinatorProvider.form.userPriceController;
  TextEditingController get productIdController => _coordinatorProvider.form.productIdController;
  TextEditingController get minimumLevelController => _coordinatorProvider.form.minimumLevelController;
  TextEditingController get optimalLevelController => _coordinatorProvider.form.optimalLevelController;
  TextEditingController get maximumLevelController => _coordinatorProvider.form.maximumLevelController;
  TextEditingController get purchaseConvFactorController => _coordinatorProvider.form.purchaseConvFactorController;
  TextEditingController get commentsController => _coordinatorProvider.form.commentsController;

  // Selected values
  InventoryLineEntity? get selectedLineItem => _coordinatorProvider.form.selectedLineItem;
  SupplierEntity? get selectedSupplier => _coordinatorProvider.form.selectedSupplier;
  CategoryEntity? get selectedCategory => _coordinatorProvider.form.selectedCategory;
  SubCategoryEntity? get selectedSubCategory => _coordinatorProvider.form.selectedSubCategory;
  String? get selectedProductGroup => _coordinatorProvider.form.selectedProductGroup;
  String? get selectedAgeGroup => _coordinatorProvider.form.selectedAgeGroup;
  String? get selectedPackagingType => _coordinatorProvider.form.selectedPackagingType;
  String? get selectedProductGender => _coordinatorProvider.form.selectedProductGender;
  String? get selectedCurrency => _coordinatorProvider.form.selectedCurrency;
  String? get selectedPurchaseConvUnit => _coordinatorProvider.form.selectedPurchaseConvUnit;
  String? get selectedAcquireType => _coordinatorProvider.form.selectedAcquireType;
  String? get selectedPurchaseType => _coordinatorProvider.form.selectedPurchaseType;
  String? get selectedManufacturing => _coordinatorProvider.form.selectedManufacturing;
  List<InventorySizesEntity> get selectedSizes => _coordinatorProvider.form.selectedSizes;
  List<InventoryColorsEntity> get selectedColors => _coordinatorProvider.form.selectedColors;
  InventorySizesEntity? get selectedDefaultSize => _coordinatorProvider.form.selectedDefaultSize;
  InventoryColorsEntity? get selectedDefaultColor => _coordinatorProvider.form.selectedDefaultColor;
  String? get selectedLifeType => _coordinatorProvider.form.selectedLifeType;
  DateTime? get selectedDate => _coordinatorProvider.form.selectedDate;

  // Data lists
  List<InventoryLineEntity> get inventoryLines => _coordinatorProvider.data.inventoryLines;
  List<CategoryEntity> get categories => _coordinatorProvider.data.categories;
  List<SubCategoryEntity> get subCategories => _coordinatorProvider.data.subCategories;
  List<SupplierEntity> get suppliers => _coordinatorProvider.data.suppliers;
  List<InventoryColorsEntity> get colors => _coordinatorProvider.data.colors;
  List<InventorySizesEntity> get sizes => _coordinatorProvider.data.sizes;
  List<SeasonEntity> get seasons => _coordinatorProvider.data.seasons;
  List<InventoryLocationsEntity> get locations => _coordinatorProvider.data.locations;
  List<String> get productGroups => _coordinatorProvider.data.productGroups;
  List<String> get ageGroups => _coordinatorProvider.data.ageGroups;
  List<String> get packagingTypes => _coordinatorProvider.data.packagingTypes;
  List<String> get productGenders => _coordinatorProvider.data.productGenders;
  List<String> get currencies => _coordinatorProvider.data.currencies;
  List<String> get purchaseConvUnits => _coordinatorProvider.data.purchaseConvUnits;
  List<String> get acquireTypes => _coordinatorProvider.data.acquireTypes;
  List<String> get purchaseTypes => _coordinatorProvider.data.purchaseTypes;
  List<String> get manufacturingTypes => _coordinatorProvider.data.manufacturingTypes;
  List<String> get lifeTypes => _coordinatorProvider.data.lifeTypes;

  // States
  bool get isLoading => _coordinatorProvider.isLoading || _isDatabaseClearing;
  bool get isSaving => _coordinatorProvider.isSaving;
  bool get isLoadingSubCategories => _coordinatorProvider.data.isLoadingSubCategories;
  bool get autoGenerateCode => _coordinatorProvider.form.autoGenerateCode;
  String? get errorMessage => _errorMessage;

  // Calculations
  double get profitMargin => _coordinatorProvider.form.profitMargin;
  double get markupPercentage => _coordinatorProvider.form.markupPercentage;

  // Visibility rules - delegate to validation provider
  bool get shouldShowSupplier => _coordinatorProvider.validation.shouldShowSupplier(selectedLineItem);
  bool get shouldShowCategory => _coordinatorProvider.validation.shouldShowCategory(selectedLineItem);
  bool get shouldShowSubCategory => _coordinatorProvider.validation.shouldShowSubCategory(selectedCategory);
  bool get shouldShowAgeGroup => _coordinatorProvider.validation.shouldShowAgeGroup(selectedCategory);
  bool get shouldShowPurchaseConvUnit => _coordinatorProvider.validation.shouldShowPurchaseConvUnit(selectedCategory);
  bool get shouldShowAcquireType => _coordinatorProvider.validation.shouldShowAcquireType(selectedLineItem);
  bool get shouldShowPurchaseType => _coordinatorProvider.validation.shouldShowPurchaseType(selectedLineItem);
  bool get shouldShowManufacturing => _coordinatorProvider.validation.shouldShowManufacturing(selectedLineItem);
  bool get shouldShowSizes => _coordinatorProvider.validation.shouldShowSizes(selectedCategory);
  bool get shouldShowColors => _coordinatorProvider.validation.shouldShowColors(selectedCategory);
  bool get shouldShowDefaultSizeColor => _coordinatorProvider.validation.shouldShowDefaultSizeColor(selectedCategory);
  bool get shouldShowLifeType => _coordinatorProvider.validation.shouldShowLifeType(selectedCategory);

  /// Initialize with clean database - specific to this provider's database-clearing functionality
  Future<void> _initializeWithCleanDatabase() async {
    _isDatabaseClearing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Clear database tables to ensure fresh data
      await _databaseClearer.clearAllInventoryTables();
      
      // Refresh data after clearing
      await _coordinatorProvider.refreshData();

      // Debug: Print table counts
      final Map<String, int> counts = await _databaseClearer.getTableCounts();
      debugPrint('Database table counts after clear and reload: $counts');
    } catch (e) {
      _errorMessage = 'Failed to initialize database: ${e.toString()}';
      debugPrint('Error initializing database: $e');
    } finally {
      _isDatabaseClearing = false;
      notifyListeners();
    }
  }

  /// Clear database and reload - specific functionality of this provider
  Future<void> clearDatabaseAndReload() async {
    await _initializeWithCleanDatabase();
  }

  // FORM ACTIONS - Delegate to coordinator
  void setLineItem(InventoryLineEntity? lineItem) {
    _coordinatorProvider.form.setLineItem(lineItem);
  }

  void setSupplier(SupplierEntity? supplier) {
    _coordinatorProvider.form.setSupplier(supplier);
  }

  void setCategory(CategoryEntity? category) {
    _coordinatorProvider.form.setCategory(category);
  }

  void setSubCategory(SubCategoryEntity? subCategory) {
    _coordinatorProvider.form.setSubCategory(subCategory);
  }

  void setProductGroup(String? productGroup) {
    _coordinatorProvider.form.setProductGroup(productGroup);
  }

  void setAgeGroup(String? ageGroup) {
    _coordinatorProvider.form.setAgeGroup(ageGroup);
  }

  void setPackagingType(String? packagingType) {
    _coordinatorProvider.form.setPackagingType(packagingType);
  }

  void setProductGender(String? gender) {
    _coordinatorProvider.form.setProductGender(gender);
  }

  void setCurrency(String? currency) {
    _coordinatorProvider.form.setCurrency(currency);
  }

  void setPurchaseConvUnit(String? unit) {
    _coordinatorProvider.form.setPurchaseConvUnit(unit);
  }

  void setAcquireType(String? type) {
    _coordinatorProvider.form.setAcquireType(type);
  }

  void setPurchaseType(String? type) {
    _coordinatorProvider.form.setPurchaseType(type);
  }

  void setManufacturing(String? manufacturing) {
    _coordinatorProvider.form.setManufacturing(manufacturing);
  }

  void setSizes(List<InventorySizesEntity> sizes) {
    _coordinatorProvider.form.setSizes(sizes);
  }

  void setColors(List<InventoryColorsEntity> colors) {
    _coordinatorProvider.form.setColors(colors);
  }

  void setDefaultSize(InventorySizesEntity? size) {
    _coordinatorProvider.form.setDefaultSize(size);
  }

  void setDefaultColor(InventoryColorsEntity? color) {
    _coordinatorProvider.form.setDefaultColor(color);
  }

  void setLifeType(String? lifeType) {
    _coordinatorProvider.form.setLifeType(lifeType);
  }

  void setDate(DateTime? date) {
    _coordinatorProvider.form.setDate(date);
  }

  void toggleAutoGenerateCode(bool value) {
    _coordinatorProvider.form.toggleAutoGenerateCode(value);
  }

  // CRUD OPERATIONS - Delegate to coordinator
  Future<void> addNewLineItem(BuildContext context) async {
    await _coordinatorProvider.addNewLineItem(context);
  }

  Future<void> addNewSupplier(BuildContext context) async {
    await _coordinatorProvider.addNewSupplier(context);
  }

  Future<void> addNewCategory(BuildContext context) async {
    await _coordinatorProvider.addNewCategory(context);
  }

  Future<void> addNewSubCategory(BuildContext context) async {
    await _coordinatorProvider.addNewSubCategory(context);
  }

  Future<void> addNewColor(BuildContext context) async {
    await _coordinatorProvider.addNewColor(context);
  }

  Future<void> addNewSize(BuildContext context) async {
    await _coordinatorProvider.addNewSize(context);
  }

  /// Save inventory - delegate to coordinator
  Future<bool> saveInventory() async {
    return await _coordinatorProvider.saveInventory();
  }

  /// Clear form - delegate to coordinator
  void clearForm() {
    _coordinatorProvider.clearForm();
  }

  /// Refresh data - delegate to coordinator
  Future<void> refreshData() async {
    await _coordinatorProvider.refreshData();
  }

  @override
  void dispose() {
    _coordinatorProvider.dispose();
    super.dispose();
  }
}