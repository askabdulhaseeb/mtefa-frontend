import 'package:flutter/material.dart';

import '../../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Supplier dropdown widget with visual enhancement
class SupplierDropdown extends StatelessWidget {
  const SupplierDropdown({
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
            Icon(Icons.business_outlined, size: 20, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Supplier',
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
        CustomDropdownWithAdd<SupplierEntity?>(
          title: '',
          hint: 'Select supplier',
          items: provider.suppliers.map((SupplierEntity supplier) {
            return DropdownMenuItem<SupplierEntity?>(
              value: supplier,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      supplier.supplierName[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(supplier.supplierName),
                ],
              ),
            );
          }).toList(),
          selectedItem: provider.selectedSupplier,
          onChanged: provider.setSupplier,
          onAddNew: () async {
            return await provider.addNewSupplier(context);
          },
          addNewButtonText: 'Add New Supplier',
          addDialogTitle: 'Register Supplier',
        ),
      ],
    );
  }
}