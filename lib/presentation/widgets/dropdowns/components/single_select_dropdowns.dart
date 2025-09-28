import 'package:flutter/material.dart';

import '../../../../domain/entities/inventory/category_entity.dart';
import '../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../domain/entities/inventory/supplier_entity.dart';
import 'base_dropdown_with_add.dart';
import 'loading_dropdown.dart';

/// Specialized dropdown for inventory line items
class InventoryLineDropdown extends StatelessWidget {
  const InventoryLineDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onAdd,
    super.key,
    this.validator,
  });

  final List<InventoryLineEntity> items;
  final InventoryLineEntity? value;
  final ValueChanged<InventoryLineEntity?> onChanged;
  final VoidCallback onAdd;
  final String? Function(InventoryLineEntity?)? validator;

  @override
  Widget build(BuildContext context) {
    return BaseDropdownWithAdd<InventoryLineEntity>(
      label: 'Line Item',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (InventoryLineEntity item) => '${item.lineCode} - ${item.lineName}',
      hint: 'Select Line Item (Required)',
      icon: Icons.category_outlined,
      validator: validator,
      addButtonTooltip: 'Add new line item',
    );
  }
}

/// Specialized dropdown for categories
class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onAdd,
    required this.isEnabled,
    super.key,
    this.validator,
  });

  final List<CategoryEntity> items;
  final CategoryEntity? value;
  final ValueChanged<CategoryEntity?> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final String? Function(CategoryEntity?)? validator;

  @override
  Widget build(BuildContext context) {
    return BaseDropdownWithAdd<CategoryEntity>(
      label: 'Category',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (CategoryEntity item) => '${item.categoryCode} - ${item.categoryName}',
      hint: 'Select Category',
      icon: Icons.folder_outlined,
      isEnabled: isEnabled,
      validator: validator,
      addButtonTooltip: 'Add new category',
    );
  }
}

/// Specialized dropdown for subcategories with loading state
class SubCategoryDropdown extends StatelessWidget {
  const SubCategoryDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onAdd,
    required this.isEnabled,
    required this.isLoading,
    super.key,
    this.validator,
  });

  final List<SubCategoryEntity> items;
  final SubCategoryEntity? value;
  final ValueChanged<SubCategoryEntity?> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final bool isLoading;
  final String? Function(SubCategoryEntity?)? validator;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingDropdown(label: 'Sub Category');
    }

    return BaseDropdownWithAdd<SubCategoryEntity>(
      label: 'Sub Category',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (SubCategoryEntity item) => '${item.subCategoryCode} - ${item.subCategoryName}',
      hint: 'Select Sub Category',
      icon: Icons.subdirectory_arrow_right,
      isEnabled: isEnabled,
      validator: validator,
      addButtonTooltip: 'Add new sub category',
    );
  }
}

/// Specialized dropdown for suppliers
class SupplierDropdown extends StatelessWidget {
  const SupplierDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.onAdd,
    required this.isEnabled,
    super.key,
    this.validator,
  });

  final List<SupplierEntity> items;
  final SupplierEntity? value;
  final ValueChanged<SupplierEntity?> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final String? Function(SupplierEntity?)? validator;

  @override
  Widget build(BuildContext context) {
    return BaseDropdownWithAdd<SupplierEntity>(
      label: 'Supplier',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (SupplierEntity item) => '${item.supplierCode} - ${item.supplierName}',
      hint: 'Select Supplier',
      icon: Icons.business_outlined,
      isEnabled: isEnabled,
      validator: validator,
      addButtonTooltip: 'Add new supplier',
    );
  }
}