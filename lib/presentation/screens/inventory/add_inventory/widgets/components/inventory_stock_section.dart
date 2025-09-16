import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../widgets/core/custom_dropdown.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../providers/add_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Inventory management section for inventory form
class InventoryStockSection extends StatelessWidget {
  const InventoryStockSection({required this.provider, super.key});

  final AddInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return AddInventorySectionBgWidget(
      icon: Icons.inventory,
      title: 'Stock Management',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Stock Quantity and Minimum Stock Level
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool showInRow = constraints.maxWidth > 400;

              if (showInRow) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTextFormField(
                        controller: provider.stockQuantityController,
                        labelText: 'Stock Quantity *',
                        hint: '0',
                        prefixIcon: const Icon(Icons.inventory, size: 20),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Stock quantity is required';
                          }
                          final int? quantity = int.tryParse(value);
                          if (quantity == null || quantity < 0) {
                            return 'Enter a valid quantity';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextFormField(
                        controller: provider.minimumStockController,
                        labelText: 'Minimum Stock Level *',
                        hint: '0',
                        prefixIcon: const Icon(
                          Icons.warning_amber_outlined,
                          size: 20,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Minimum stock level is required';
                          }
                          final int? minStock = int.tryParse(value);
                          if (minStock == null || minStock < 0) {
                            return 'Enter a valid quantity';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    CustomTextFormField(
                      controller: provider.stockQuantityController,
                      labelText: 'Stock Quantity *',
                      hint: '0',
                      prefixIcon: const Icon(Icons.inventory, size: 20),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Stock quantity is required';
                        }
                        final int? quantity = int.tryParse(value);
                        if (quantity == null || quantity < 0) {
                          return 'Enter a valid quantity';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomTextFormField(
                      controller: provider.minimumStockController,
                      labelText: 'Minimum Stock Level *',
                      hint: '0',
                      prefixIcon: const Icon(
                        Icons.warning_amber_outlined,
                        size: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Minimum stock level is required';
                        }
                        final int? minStock = int.tryParse(value);
                        if (minStock == null || minStock < 0) {
                          return 'Enter a valid quantity';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 8),

          // Unit of Measurement
          CustomDropdown<String>(
            title: 'Unit of Measurement *',
            hint: 'Select unit',
            selectedItem: provider.selectedUnit,
            items: provider.unitOfMeasurements
                .map(
                  (String unit) => DropdownMenuItem<String>(
                    value: unit,
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.straighten, size: 16),
                        const SizedBox(width: 8),
                        Text(unit),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                provider.setUnit(value);
              }
            },
            validator: (bool? value) {
              // Unit is always selected (default: pieces)
              return null;
            },
          ),

          // Stock Status Indicator
          if (provider.stockQuantityController.text.isNotEmpty &&
              provider.minimumStockController.text.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getStockStatusColor(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getStockStatusColor(context).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    _getStockStatusIcon(),
                    color: _getStockStatusColor(context),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getStockStatusText(),
                    style: TextStyle(
                      color: _getStockStatusColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getStockStatusColor(BuildContext context) {
    final int stock = int.tryParse(provider.stockQuantityController.text) ?? 0;
    final int minStock =
        int.tryParse(provider.minimumStockController.text) ?? 0;

    if (stock == 0) {
      return Colors.red;
    } else if (stock <= minStock) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  IconData _getStockStatusIcon() {
    final int stock = int.tryParse(provider.stockQuantityController.text) ?? 0;
    final int minStock =
        int.tryParse(provider.minimumStockController.text) ?? 0;

    if (stock == 0) {
      return Icons.error_outline;
    } else if (stock <= minStock) {
      return Icons.warning_amber_outlined;
    } else {
      return Icons.check_circle_outline;
    }
  }

  String _getStockStatusText() {
    final int stock = int.tryParse(provider.stockQuantityController.text) ?? 0;
    final int minStock =
        int.tryParse(provider.minimumStockController.text) ?? 0;

    if (stock == 0) {
      return 'Out of Stock';
    } else if (stock <= minStock) {
      return 'Low Stock Warning';
    } else {
      return 'Stock Level OK';
    }
  }
}
