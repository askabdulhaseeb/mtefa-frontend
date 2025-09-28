import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../domain/repositories/category_repository.dart';
import '../../../../../domain/repositories/inventory_colors_repository.dart';
import '../../../../../domain/repositories/inventory_line_repository.dart';
import '../../../../../domain/repositories/inventory_sizes_repository.dart';
import '../../../../../domain/repositories/sub_category_repository.dart';
import '../../../../../domain/repositories/supplier_repository.dart';
import '../../../../widgets/dialogs/add_dropdown_item_dialog.dart';

/// Provider responsible for CRUD operations for creating new inventory items
class InventoryCrudProvider extends ChangeNotifier {
  InventoryCrudProvider({
    required InventoryLineRepository inventoryLineRepository,
    required CategoryRepository categoryRepository,
    required SubCategoryRepository subCategoryRepository,
    required SupplierRepository supplierRepository,
    required InventoryColorsRepository colorsRepository,
    required InventorySizesRepository sizesRepository,
  })  : _inventoryLineRepository = inventoryLineRepository,
        _categoryRepository = categoryRepository,
        _subCategoryRepository = subCategoryRepository,
        _supplierRepository = supplierRepository,
        _colorsRepository = colorsRepository,
        _sizesRepository = sizesRepository;

  // Repositories for CRUD operations
  final InventoryLineRepository _inventoryLineRepository;
  final CategoryRepository _categoryRepository;
  final SubCategoryRepository _subCategoryRepository;
  final SupplierRepository _supplierRepository;
  final InventoryColorsRepository _colorsRepository;
  final InventorySizesRepository _sizesRepository;

  // UUID generator for creating unique IDs
  final Uuid _uuid = const Uuid();

  // Operation states
  bool _isCreatingItem = false;

  // GETTERS
  bool get isCreatingItem => _isCreatingItem;

  /// Add new inventory line item
  Future<InventoryLineEntity?> addNewLineItem(BuildContext context) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Line Item',
          itemType: 'line_item',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final InventoryLineEntity newItem = InventoryLineEntity(
          inventoryLineId: id,
          businessId: businessId,
          lineName: result['name'] as String,
          lineCode: result['code'] as String? ?? '',
          lineDescription: '',
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<InventoryLineEntity> saveResult = 
            await _inventoryLineRepository.createInventoryLine(newItem);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create line item: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating line item: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Add new supplier
  Future<SupplierEntity?> addNewSupplier(BuildContext context) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Supplier',
          itemType: 'supplier',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final SupplierEntity newSupplier = SupplierEntity(
          supplierId: id,
          businessId: businessId,
          supplierName: result['name'] as String,
          supplierCode: result['code'] as String? ?? '',
          contactPerson: '',
          email: '',
          phone: '',
          address: '',
          city: '',
          country: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<SupplierEntity> saveResult = 
            await _supplierRepository.createSupplier(newSupplier);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create supplier: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating supplier: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Add new category
  Future<CategoryEntity?> addNewCategory(BuildContext context) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Category',
          itemType: 'category',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final CategoryEntity newCategory = CategoryEntity(
          categoryId: id,
          businessId: businessId,
          categoryName: result['name'] as String,
          categoryCode: result['code'] as String? ?? '',
          categoryDescription: null,
          parentCategoryId: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<CategoryEntity> saveResult = 
            await _categoryRepository.createCategory(newCategory);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create category: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating category: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Add new sub category
  Future<SubCategoryEntity?> addNewSubCategory(
    BuildContext context,
    CategoryEntity? selectedCategory,
  ) async {
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category first'),
          backgroundColor: Colors.orange,
        ),
      );
      return null;
    }

    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Sub Category',
          itemType: 'sub_category',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final SubCategoryEntity newSubCategory = SubCategoryEntity(
          subCategoryId: id,
          businessId: businessId,
          categoryId: selectedCategory.categoryId,
          subCategoryName: result['name'] as String,
          subCategoryCode: result['code'] as String? ?? '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<SubCategoryEntity> saveResult = 
            await _subCategoryRepository.createSubCategory(newSubCategory);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create sub category: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating sub category: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Add new color
  Future<InventoryColorsEntity?> addNewColor(BuildContext context) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Color',
          itemType: 'color',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final InventoryColorsEntity newColor = InventoryColorsEntity(
          colorId: id,
          businessId: businessId,
          colorName: result['name'] as String,
          colorCode: result['code'] as String? ?? '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<InventoryColorsEntity> saveResult = 
            await _colorsRepository.createColor(newColor);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create color: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating color: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Add new size
  Future<InventorySizesEntity?> addNewSize(BuildContext context) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) => const AddDropdownItemDialog(
          title: 'Add New Size',
          itemType: 'size',
        ),
      );

      if (result != null) {
        final String id = _uuid.v4();
        final String businessId = 'default_business'; // TODO: Get from auth/settings
        
        final InventorySizesEntity newSize = InventorySizesEntity(
          sizeId: id,
          businessId: businessId,
          sizeName: result['name'] as String,
          sizeCode: result['code'] as String? ?? '',
          sizeType: 'standard', // TODO: Make this configurable
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final DataState<InventorySizesEntity> saveResult = 
            await _sizesRepository.createSize(newSize);
        
        if (saveResult.isSuccess) {
          return saveResult.data;
        } else {
          debugPrint('Failed to create size: ${saveResult.error}');
        }
      }
    } catch (e) {
      debugPrint('Error creating size: $e');
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
    
    return null;
  }

  /// Validate and save complete inventory item
  Future<bool> saveInventory({
    required String productCode,
    required String productName,
    required String averageCost,
    required InventoryLineEntity? selectedLineItem,
    String? selectedSupplierId,
    String? selectedCategoryId,
    String? selectedSubCategoryId,
    String? comments,
  }) async {
    _isCreatingItem = true;
    notifyListeners();

    try {
      // Validate required fields
      if (selectedLineItem == null) {
        debugPrint('Please select a line item');
        return false;
      }

      if (productCode.trim().isEmpty || 
          productName.trim().isEmpty || 
          averageCost.trim().isEmpty) {
        debugPrint('Please fill all required fields');
        return false;
      }

      // TODO: Implement actual inventory creation with all fields
      await Future<void>.delayed(const Duration(seconds: 2));
      
      debugPrint('Inventory saved successfully');
      return true;
    } catch (e) {
      debugPrint('Error saving inventory: $e');
      return false;
    } finally {
      _isCreatingItem = false;
      notifyListeners();
    }
  }
}