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

/// Data provider for managing inventory data loading and caching
class InventoryDataProvider extends ChangeNotifier {
  InventoryDataProvider({
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
       _getSizesUseCase = getSizesUseCase;

  final GetInventoryLinesUseCase _getInventoryLinesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  // final GetCategoriesByParentUseCase _getCategoriesByParentUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;
  final GetSuppliersUseCase _getSuppliersUseCase;
  final GetColorsUseCase _getColorsUseCase;
  final GetSizesUseCase _getSizesUseCase;

  // DATA LISTS
  List<InventoryLineEntity> _inventoryLines = <InventoryLineEntity>[];
  List<CategoryEntity> _categories = <CategoryEntity>[];
  List<SubCategoryEntity> _subCategories = <SubCategoryEntity>[];
  List<SupplierEntity> _suppliers = <SupplierEntity>[];
  List<InventoryColorsEntity> _colorsEntities = <InventoryColorsEntity>[];
  List<InventorySizesEntity> _sizesEntities = <InventorySizesEntity>[];

  // PLACEHOLDER LISTS
  final List<String> _productGroups = <String>[];
  final List<String> _ageGroups = <String>[];
  final List<String> _packagingTypes = <String>[];
  final List<String> _productGenders = <String>[];
  final List<String> _lifeTypes = <String>[];

  // LOADING STATES
  bool _isLoading = false;
  bool _isLoadingSubCategories = false;

  // GETTERS
  List<InventoryLineEntity> get inventoryLines => _inventoryLines;
  List<CategoryEntity> get categories => _categories;
  List<SubCategoryEntity> get subCategories => _subCategories;
  List<SupplierEntity> get suppliers => _suppliers;
  List<String> get sizes =>
      _sizesEntities.map((InventorySizesEntity e) => e.sizeName).toList();
  List<String> get colors =>
      _colorsEntities.map((InventoryColorsEntity e) => e.colorName).toList();
  List<String> get productGroups => _productGroups;
  List<String> get ageGroups => _ageGroups;
  List<String> get packagingTypes => _packagingTypes;
  List<String> get productGenders => _productGenders;
  List<String> get lifeTypes => _lifeTypes;

  bool get isLoading => _isLoading;
  bool get isLoadingSubCategories => _isLoadingSubCategories;

  /// Load all initial data
  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait(<Future<void>>[
        _loadInventoryLines(),
        _loadCategories(),
        _loadSuppliers(),
        _loadColors(),
        _loadSizes(),
      ]);
    } catch (e) {
      debugPrint('Error loading initial data: $e');
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

  /// Refresh inventory lines data
  Future<void> refreshInventoryLines() async {
    await _loadInventoryLines();
    notifyListeners();
  }

  /// Refresh suppliers data
  Future<void> refreshSuppliers() async {
    await _loadSuppliers();
    notifyListeners();
  }

  /// Refresh categories data
  Future<void> refreshCategories() async {
    await _loadCategories();
    notifyListeners();
  }

  /// Add item to placeholder list
  void addToPlaceholderList(String listType, String item) {
    switch (listType) {
      case 'productGroups':
        _productGroups.add(item);
        break;
      case 'ageGroups':
        _ageGroups.add(item);
        break;
      case 'packagingTypes':
        _packagingTypes.add(item);
        break;
      case 'productGenders':
        _productGenders.add(item);
        break;
      case 'lifeTypes':
        _lifeTypes.add(item);
        break;
    }
    notifyListeners();
  }
}
