import 'package:flutter/material.dart';

import '../../../../../core/database/database.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
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
import 'inventory_crud_provider.dart';
import 'inventory_data_provider.dart';
import 'inventory_form_provider.dart';
import 'inventory_validation_provider.dart';

/// Coordinator provider that manages all inventory-related sub-providers
/// This replaces the monolithic ComprehensiveInventoryProviderRefactored
class InventoryCoordinatorProvider extends ChangeNotifier {
  InventoryCoordinatorProvider({
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
  }) {
    // Initialize focused providers
    _formProvider = InventoryFormProvider();
    _dataProvider = InventoryDataProvider(
      database: database,
      getInventoryLinesUseCase: getInventoryLinesUseCase,
      getCategoriesUseCase: getCategoriesUseCase,
      getSubCategoriesUseCase: getSubCategoriesUseCase,
      getSuppliersUseCase: getSuppliersUseCase,
      colorsRepository: colorsRepository,
      sizesRepository: sizesRepository,
      seasonRepository: seasonRepository,
      locationsRepository: locationsRepository,
    );
    _validationProvider = InventoryValidationProvider();
    _crudProvider = InventoryCrudProvider(
      inventoryLineRepository: inventoryLineRepository,
      categoryRepository: categoryRepository,
      subCategoryRepository: subCategoryRepository,
      supplierRepository: supplierRepository,
      colorsRepository: colorsRepository,
      sizesRepository: sizesRepository,
    );

    // Set up listeners for cross-provider communication
    _setupProviderListeners();
  }

  // Sub-providers
  late final InventoryFormProvider _formProvider;
  late final InventoryDataProvider _dataProvider;
  late final InventoryValidationProvider _validationProvider;
  late final InventoryCrudProvider _crudProvider;

  // Provider getters
  InventoryFormProvider get form => _formProvider;
  InventoryDataProvider get data => _dataProvider;
  InventoryValidationProvider get validation => _validationProvider;
  InventoryCrudProvider get crud => _crudProvider;

  // Convenience getters that delegate to sub-providers
  GlobalKey<FormState> get formKey => _formProvider.formKey;
  bool get isLoading => _dataProvider.isLoading;
  bool get isSaving => _validationProvider.isSaving || _crudProvider.isCreatingItem;

  /// Set up listeners for cross-provider communication
  void _setupProviderListeners() {
    // Listen to form provider changes and forward them
    _formProvider.addListener(() {
      notifyListeners();
    });

    // Listen to data provider changes and forward them
    _dataProvider.addListener(() {
      notifyListeners();
    });

    // Listen to validation provider changes and forward them
    _validationProvider.addListener(() {
      notifyListeners();
    });

    // Listen to CRUD provider changes and forward them
    _crudProvider.addListener(() {
      notifyListeners();
    });

    // Set up category selection listener to load subcategories
    _formProvider.addListener(() {
      if (_formProvider.selectedCategory != null) {
        _dataProvider.loadSubCategories(_formProvider.selectedCategory!.categoryId);
      }
    });
  }

  /// Add new line item and set it as selected
  Future<void> addNewLineItem(BuildContext context) async {
    final InventoryLineEntity? newItem = await _crudProvider.addNewLineItem(context);
    if (newItem != null) {
      await _dataProvider.reloadInventoryLines();
      _formProvider.setLineItem(newItem);
    }
  }

  /// Add new supplier and set it as selected
  Future<void> addNewSupplier(BuildContext context) async {
    final SupplierEntity? newSupplier = await _crudProvider.addNewSupplier(context);
    if (newSupplier != null) {
      await _dataProvider.reloadSuppliers();
      _formProvider.setSupplier(newSupplier);
    }
  }

  /// Add new category and set it as selected
  Future<void> addNewCategory(BuildContext context) async {
    final CategoryEntity? newCategory = await _crudProvider.addNewCategory(context);
    if (newCategory != null) {
      await _dataProvider.reloadCategories();
      _formProvider.setCategory(newCategory);
    }
  }

  /// Add new sub category and set it as selected
  Future<void> addNewSubCategory(BuildContext context) async {
    final SubCategoryEntity? newSubCategory = await _crudProvider.addNewSubCategory(
      context,
      _formProvider.selectedCategory,
    );
    if (newSubCategory != null) {
      if (_formProvider.selectedCategory != null) {
        await _dataProvider.loadSubCategories(_formProvider.selectedCategory!.categoryId);
      }
      _formProvider.setSubCategory(newSubCategory);
    }
  }

  /// Add new color and refresh colors list
  Future<void> addNewColor(BuildContext context) async {
    final InventoryColorsEntity? newColor = await _crudProvider.addNewColor(context);
    if (newColor != null) {
      await _dataProvider.reloadColors();
    }
  }

  /// Add new size and refresh sizes list
  Future<void> addNewSize(BuildContext context) async {
    final InventorySizesEntity? newSize = await _crudProvider.addNewSize(context);
    if (newSize != null) {
      await _dataProvider.reloadSizes();
    }
  }

  /// Validate and save inventory
  Future<bool> saveInventory() async {
    if (!_formProvider.formKey.currentState!.validate()) {
      return false;
    }

    // Use validation provider to check all business rules
    if (!_validationProvider.canSaveInventory(
      productCode: _formProvider.productCodeController.text,
      productName: _formProvider.productNameController.text,
      averageCost: _formProvider.averageCostController.text,
      selectedLineItem: _formProvider.selectedLineItem,
    )) {
      return false;
    }

    // Use CRUD provider to save the inventory
    final bool success = await _crudProvider.saveInventory(
      productCode: _formProvider.productCodeController.text,
      productName: _formProvider.productNameController.text,
      averageCost: _formProvider.averageCostController.text,
      selectedLineItem: _formProvider.selectedLineItem,
      selectedSupplierId: _formProvider.selectedSupplier?.supplierId,
      selectedCategoryId: _formProvider.selectedCategory?.categoryId,
      selectedSubCategoryId: _formProvider.selectedSubCategory?.subCategoryId,
      comments: _formProvider.commentsController.text,
    );

    if (success) {
      _formProvider.clearForm();
    }

    return success;
  }

  /// Clear all form data
  void clearForm() {
    _formProvider.clearForm();
  }

  /// Refresh all data from database
  Future<void> refreshData() async {
    await _dataProvider.refreshData();
  }

  @override
  void dispose() {
    _formProvider.dispose();
    // Data, validation, and CRUD providers don't need disposal as they don't have controllers
    super.dispose();
  }
}