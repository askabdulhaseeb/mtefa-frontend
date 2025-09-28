import 'package:flutter/material.dart';

import '../../../../../core/database/database.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_locations_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/season_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../domain/repositories/inventory_colors_repository.dart';
import '../../../../../domain/repositories/inventory_locations_repository.dart';
import '../../../../../domain/repositories/inventory_sizes_repository.dart';
import '../../../../../domain/repositories/season_repository.dart';
import '../../../../../domain/usecases/inventory/get_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_inventory_lines_usecase.dart';
import '../../../../../domain/usecases/inventory/get_sub_categories_usecase.dart';
import '../../../../../domain/usecases/inventory/get_suppliers_usecase.dart';

/// Provider responsible for data loading and management from repositories
class InventoryDataProvider extends ChangeNotifier {
  InventoryDataProvider({
    required AppDatabase database,
    required GetInventoryLinesUseCase getInventoryLinesUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetSubCategoriesUseCase getSubCategoriesUseCase,
    required GetSuppliersUseCase getSuppliersUseCase,
    required InventoryColorsRepository colorsRepository,
    required InventorySizesRepository sizesRepository,
    required SeasonRepository seasonRepository,
    required InventoryLocationsRepository locationsRepository,
  })  : _database = database,
        _getInventoryLinesUseCase = getInventoryLinesUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        _getSubCategoriesUseCase = getSubCategoriesUseCase,
        _getSuppliersUseCase = getSuppliersUseCase,
        _colorsRepository = colorsRepository,
        _sizesRepository = sizesRepository,
        _seasonRepository = seasonRepository,
        _locationsRepository = locationsRepository {
    _loadAllData();
  }

  // Dependencies
  final AppDatabase _database;
  final GetInventoryLinesUseCase _getInventoryLinesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;
  final GetSuppliersUseCase _getSuppliersUseCase;
  final InventoryColorsRepository _colorsRepository;
  final InventorySizesRepository _sizesRepository;
  final SeasonRepository _seasonRepository;
  final InventoryLocationsRepository _locationsRepository;

  // DATA FROM DATABASE
  List<InventoryLineEntity> _inventoryLines = <InventoryLineEntity>[];
  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<SubCategoryEntity> _subCategories = <SubCategoryEntity>[];
  List<SupplierEntity> _suppliers = <SupplierEntity>[];
  List<InventoryColorsEntity> _colors = <InventoryColorsEntity>[];
  List<InventorySizesEntity> _sizes = <InventorySizesEntity>[];
  List<SeasonEntity> _seasons = <SeasonEntity>[];
  List<InventoryLocationsEntity> _locations = <InventoryLocationsEntity>[];
  
  // Dynamic lists loaded from database
  List<String> _productGroups = <String>[];
  List<String> _ageGroups = <String>[];
  List<String> _packagingTypes = <String>[];
  List<String> _productGenders = <String>[];
  List<String> _currencies = <String>[];
  List<String> _purchaseConvUnits = <String>[];
  List<String> _acquireTypes = <String>[];
  List<String> _purchaseTypes = <String>[];
  List<String> _manufacturingTypes = <String>[];
  List<String> _lifeTypes = <String>[];

  // LOADING STATES
  bool _isLoading = false;
  bool _isLoadingSubCategories = false;

  // GETTERS
  List<InventoryLineEntity> get inventoryLines => _inventoryLines;
  List<SupplierEntity> get suppliers => _suppliers;
  List<CategoryEntity> get categories => _categories;
  List<SubCategoryEntity> get subCategories => _subCategories;
  List<InventoryColorsEntity> get colors => _colors;
  List<InventorySizesEntity> get sizes => _sizes;
  List<SeasonEntity> get seasons => _seasons;
  List<InventoryLocationsEntity> get locations => _locations;
  
  List<String> get productGroups => _productGroups;
  List<String> get ageGroups => _ageGroups;
  List<String> get packagingTypes => _packagingTypes;
  List<String> get productGenders => _productGenders;
  List<String> get currencies => _currencies;
  List<String> get purchaseConvUnits => _purchaseConvUnits;
  List<String> get acquireTypes => _acquireTypes;
  List<String> get purchaseTypes => _purchaseTypes;
  List<String> get manufacturingTypes => _manufacturingTypes;
  List<String> get lifeTypes => _lifeTypes;

  bool get isLoading => _isLoading;
  bool get isLoadingSubCategories => _isLoadingSubCategories;

  /// Clear all database tables and start fresh
  Future<void> clearAllData() async {
    try {
      // Clear database tables manually
      await _database.delete(_database.inventoryVariants).go();
      await _database.delete(_database.inventoryLocations).go();
      await _database.delete(_database.inventorySizes).go();
      await _database.delete(_database.inventoryColors).go();
      await _database.delete(_database.season).go();
      await _database.delete(_database.subCategory).go();
      await _database.delete(_database.categoryTable).go();
      await _database.delete(_database.suppliers).go();
      await _database.delete(_database.inventoryLine).go();
      await _loadAllData();
      debugPrint('All inventory tables cleared successfully');
    } catch (e) {
      debugPrint('Error clearing database tables: $e');
    }
  }

  /// Load all data from database
  Future<void> _loadAllData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load all data in parallel
      await Future.wait(<Future<void>>[
        _loadInventoryLines(),
        _loadCategories(),
        _loadSuppliers(),
        _loadColors(),
        _loadSizes(),
        _loadSeasons(),
        _loadLocations(),
        _loadDynamicLists(),
      ]);

      // Set default currency to PKR as per requirements
      if (!_currencies.contains('PKR')) {
        _currencies.insert(0, 'PKR');
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
    final DataState<List<InventoryColorsEntity>> result = await _colorsRepository.getColors();
    
    if (result.isSuccess) {
      _colors = result.data ?? <InventoryColorsEntity>[];
    } else {
      debugPrint('Failed to load colors: ${result.error}');
      _colors = <InventoryColorsEntity>[];
    }
  }

  /// Load sizes from database
  Future<void> _loadSizes() async {
    final DataState<List<InventorySizesEntity>> result = await _sizesRepository.getSizes();
    
    if (result.isSuccess) {
      _sizes = result.data ?? <InventorySizesEntity>[];
    } else {
      debugPrint('Failed to load sizes: ${result.error}');
      _sizes = <InventorySizesEntity>[];
    }
  }

  /// Load seasons from database
  Future<void> _loadSeasons() async {
    final DataState<List<SeasonEntity>> result = await _seasonRepository.getSeasons();
    
    if (result.isSuccess) {
      _seasons = result.data ?? <SeasonEntity>[];
    } else {
      debugPrint('Failed to load seasons: ${result.error}');
      _seasons = <SeasonEntity>[];
    }
  }

  /// Load locations from database
  Future<void> _loadLocations() async {
    final DataState<List<InventoryLocationsEntity>> result = await _locationsRepository.getLocations();
    
    if (result.isSuccess) {
      _locations = result.data ?? <InventoryLocationsEntity>[];
    } else {
      debugPrint('Failed to load locations: ${result.error}');
      _locations = <InventoryLocationsEntity>[];
    }
  }

  /// Load dynamic lists from database or configuration
  Future<void> _loadDynamicLists() async {
    // These would typically be loaded from a configuration table or settings
    // For now, we'll initialize with empty lists that can be populated via the add dialog
    _productGroups = <String>[];
    _ageGroups = <String>[];
    _packagingTypes = <String>[];
    _productGenders = <String>['Male', 'Female', 'Unisex']; // Basic defaults
    _currencies = <String>['PKR', 'USD', 'EUR', 'GBP'];
    _purchaseConvUnits = <String>[];
    _acquireTypes = <String>[];
    _purchaseTypes = <String>[];
    _manufacturingTypes = <String>[];
    _lifeTypes = <String>[];
  }

  /// Load subcategories for a specific category
  Future<void> loadSubCategories(String categoryId) async {
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

  /// Reload all data from database
  Future<void> refreshData() async {
    await _loadAllData();
  }

  /// Reload specific data type
  Future<void> reloadInventoryLines() async {
    await _loadInventoryLines();
    notifyListeners();
  }

  Future<void> reloadCategories() async {
    await _loadCategories();
    notifyListeners();
  }

  Future<void> reloadSuppliers() async {
    await _loadSuppliers();
    notifyListeners();
  }

  Future<void> reloadColors() async {
    await _loadColors();
    notifyListeners();
  }

  Future<void> reloadSizes() async {
    await _loadSizes();
    notifyListeners();
  }

  Future<void> reloadLocations() async {
    await _loadLocations();
    notifyListeners();
  }

  Future<void> reloadSeasons() async {
    await _loadSeasons();
    notifyListeners();
  }
}
