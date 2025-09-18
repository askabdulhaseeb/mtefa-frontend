import 'package:flutter/material.dart';

/// Generic dropdown widget with add functionality for inventory items
class InventoryDropdownWithAdd<T> extends StatelessWidget {
  const InventoryDropdownWithAdd({
    required this.label, required this.items, required this.value, required this.onChanged, required this.onAdd, required this.itemBuilder, super.key,
    this.hint,
    this.isEnabled = true,
    this.validator,
    this.icon,
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final VoidCallback onAdd;
  final String Function(T) itemBuilder;
  final String? hint;
  final bool isEnabled;
  final String? Function(T?)? validator;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButtonFormField<T>(
                initialValue: value,
                decoration: InputDecoration(
                  hintText: hint ?? 'Select $label',
                  prefixIcon: icon != null ? Icon(icon) : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  filled: true,
                  fillColor: isEnabled 
                      ? theme.colorScheme.surface 
                      : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                isExpanded: true,
                items: items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      itemBuilder(item),
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: isEnabled ? onChanged : null,
                validator: validator,
                dropdownColor: theme.colorScheme.surface,
                elevation: 8,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                menuMaxHeight: 300,
              ),
            ),
            const SizedBox(width: 8),
            // Add button
            Material(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: isEnabled ? onAdd : null,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: Icon(
                    Icons.add,
                    color: theme.colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!isEnabled)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Select parent item first',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

/// Specialized dropdown for inventory line items
class InventoryLineDropdown extends StatelessWidget {
  const InventoryLineDropdown({
    required this.items, required this.value, required this.onChanged, required this.onAdd, super.key,
    this.validator,
  });

  final List<dynamic> items; // InventoryLineEntity
  final dynamic value; // InventoryLineEntity?
  final ValueChanged<dynamic> onChanged;
  final VoidCallback onAdd;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return InventoryDropdownWithAdd<dynamic>(
      label: 'Line Item',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (dynamic item) => '${item.lineCode} - ${item.lineName}',
      hint: 'Select Line Item (Required)',
      icon: Icons.category_outlined,
      validator: validator,
    );
  }
}

/// Specialized dropdown for categories
class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    required this.items, required this.value, required this.onChanged, required this.onAdd, required this.isEnabled, super.key,
    this.validator,
  });

  final List<dynamic> items; // CategoryEntity
  final dynamic value; // CategoryEntity?
  final ValueChanged<dynamic> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return InventoryDropdownWithAdd<dynamic>(
      label: 'Category',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (dynamic item) => '${item.categoryCode} - ${item.categoryName}',
      hint: 'Select Category',
      icon: Icons.folder_outlined,
      isEnabled: isEnabled,
      validator: validator,
    );
  }
}

/// Specialized dropdown for subcategories
class SubCategoryDropdown extends StatelessWidget {
  const SubCategoryDropdown({
    required this.items, required this.value, required this.onChanged, required this.onAdd, required this.isEnabled, required this.isLoading, super.key,
    this.validator,
  });

  final List<dynamic> items; // SubCategoryEntity
  final dynamic value; // SubCategoryEntity?
  final ValueChanged<dynamic> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final bool isLoading;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Sub Category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        ],
      );
    }

    return InventoryDropdownWithAdd<dynamic>(
      label: 'Sub Category',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (dynamic item) => '${item.subCategoryCode} - ${item.subCategoryName}',
      hint: 'Select Sub Category',
      icon: Icons.subdirectory_arrow_right,
      isEnabled: isEnabled,
      validator: validator,
    );
  }
}

/// Specialized dropdown for suppliers
class SupplierDropdown extends StatelessWidget {
  const SupplierDropdown({
    required this.items, required this.value, required this.onChanged, required this.onAdd, required this.isEnabled, super.key,
    this.validator,
  });

  final List<dynamic> items; // SupplierEntity
  final dynamic value; // SupplierEntity?
  final ValueChanged<dynamic> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return InventoryDropdownWithAdd<dynamic>(
      label: 'Supplier',
      items: items,
      value: value,
      onChanged: onChanged,
      onAdd: onAdd,
      itemBuilder: (dynamic item) => '${item.supplierCode} - ${item.supplierName}',
      hint: 'Select Supplier',
      icon: Icons.business_outlined,
      isEnabled: isEnabled,
      validator: validator,
    );
  }
}

/// Multi-select dropdown for colors
class ColorMultiSelectDropdown extends StatelessWidget {
  const ColorMultiSelectDropdown({
    required this.items, required this.selectedItems, required this.onChanged, required this.onAdd, required this.isEnabled, super.key,
  });

  final List<dynamic> items; // List<InventoryColorsEntity>
  final List<dynamic> selectedItems; // List<InventoryColorsEntity>
  final ValueChanged<List<dynamic>> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Colors',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outline,
              ),
              onPressed: isEnabled ? onAdd : null,
              tooltip: 'Add New Color',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            color: isEnabled 
                ? theme.colorScheme.surface 
                : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          child: Column(
            children: <Widget>[
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No colors available. Click + to add.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                )
              else
                ...items.map((dynamic color) {
                  final bool isSelected = selectedItems.contains(color);
                  return CheckboxListTile(
                    title: Text(color.colorName),
                    subtitle: color.colorCode != null && color.colorCode!.isNotEmpty
                        ? Text(color.colorCode!)
                        : null,
                    value: isSelected,
                    onChanged: isEnabled
                        ? (bool? value) {
                            if (value == true) {
                              onChanged(<dynamic>[...selectedItems, color]);
                            } else {
                              onChanged(selectedItems.where((dynamic c) => c != color).toList());
                            }
                          }
                        : null,
                    secondary: color.hexColor != null
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _parseHexColor(color.hexColor),
                              border: Border.all(color: theme.colorScheme.outline),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          )
                        : null,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }

  Color? _parseHexColor(String? hexString) {
    if (hexString == null || hexString.isEmpty) return null;
    
    final String hex = hexString.replaceAll('#', '');
    if (hex.length != 6) return null;
    
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}

/// Multi-select dropdown for sizes
class SizeMultiSelectDropdown extends StatelessWidget {
  const SizeMultiSelectDropdown({
    required this.items, required this.selectedItems, required this.onChanged, required this.onAdd, required this.isEnabled, super.key,
  });

  final List<dynamic> items; // List<InventorySizesEntity>
  final List<dynamic> selectedItems; // List<InventorySizesEntity>
  final ValueChanged<List<dynamic>> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Sizes',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outline,
              ),
              onPressed: isEnabled ? onAdd : null,
              tooltip: 'Add New Size',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            color: isEnabled 
                ? theme.colorScheme.surface 
                : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No sizes available. Click + to add.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                )
              else
                ...items.map((dynamic size) {
                  final bool isSelected = selectedItems.contains(size);
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: FilterChip(
                      label: Text(size.sizeName),
                      selected: isSelected,
                      onSelected: isEnabled
                          ? (bool selected) {
                              if (selected) {
                                onChanged(<dynamic>[...selectedItems, size]);
                              } else {
                                onChanged(selectedItems.where((dynamic s) => s != size).toList());
                              }
                            }
                          : null,
                      showCheckmark: true,
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}