import 'package:flutter/material.dart';

import '../../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Inventory line item dropdown with visual enhancement
class InventoryLineDropdown extends StatelessWidget {
  const InventoryLineDropdown({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.category_outlined, size: 20, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Product Category',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '*',
              style: TextStyle(
                color: colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: provider.selectedLineItem == null
                  ? colorScheme.error.withAlpha(100)
                  : colorScheme.outline.withAlpha(100),
            ),
            color: colorScheme.surfaceContainerHighest.withAlpha(50),
          ),
          child: CustomDropdownWithAdd<InventoryLineEntity?>(
            title: '',
            hint: 'Select product category',
            items: provider.inventoryLines.map((InventoryLineEntity item) {
              return DropdownMenuItem<InventoryLineEntity?>(
                value: item,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(item.lineName),
                  ],
                ),
              );
            }).toList(),
            selectedItem: provider.selectedLineItem,
            onChanged: provider.setLineItem,
            onAddNew: () async => await provider.addNewLineItem(context),
            addNewButtonText: 'Create New Category',
            addDialogTitle: 'Add Product Category',
          ),
        ),
        if (provider.selectedLineItem == null) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            'Please select a product category',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}