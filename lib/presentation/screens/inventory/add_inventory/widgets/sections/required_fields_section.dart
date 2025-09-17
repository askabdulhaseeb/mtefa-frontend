import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../../domain/entities/inventory/supplier_entity.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Required fields section for inventory creation
class RequiredFieldsSection extends StatelessWidget {
  const RequiredFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (BuildContext context, ComprehensiveInventoryProvider provider, Widget? child) {
        return AddInventorySectionBgWidget(
          icon: Icons.star,
          title: 'Required Information',
          child: Column(
            children: <Widget>[
              // Line Item - Select from dropdown
              CustomDropdownWithAdd<InventoryLineEntity?>(
                title: 'Line Item *',
                hint: 'Select line item',
                items: provider.inventoryLines.map((InventoryLineEntity item) {
                  return DropdownMenuItem<InventoryLineEntity?>(
                    value: item,
                    child: Text(item.lineName),
                  );
                }).toList(),
                selectedItem: provider.selectedLineItem,
                onChanged: provider.setLineItem,
                onAddNew: () => provider.addNewLineItem(context),
                addNewButtonText: 'Add Line Item',
                addDialogTitle: 'Add New Line Item',
              ),
              
              const SizedBox(height: DoubleConstants.spacingM),

              // Product Code - Auto-generated via template (F2) or manual entry
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextFormField(
                      controller: provider.productCodeController,
                      labelText: 'Product Code *',
                      hint: 'Enter product code',
                      readOnly: provider.autoGenerateCode,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Product code is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: 'Auto-generate code',
                    child: Checkbox(
                      value: provider.autoGenerateCode,
                      onChanged: (bool? value) => provider.toggleAutoGenerateCode(value ?? false),
                    ),
                  ),
                  const Text('Auto'),
                ],
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Product Name - Item name
              CustomTextFormField(
                controller: provider.productNameController,
                labelText: 'Product Name *',
                hint: 'Enter product name',
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Product name is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Supplier - Select from dropdown (Visibility Depends on Line Item)
              if (provider.shouldShowSupplier) ...<Widget>[
                CustomDropdownWithAdd<SupplierEntity?>(
                  title: 'Supplier *',
                  hint: 'Select supplier',
                  items: provider.suppliers.map((SupplierEntity supplier) {
                    return DropdownMenuItem<SupplierEntity?>(
                      value: supplier,
                      child: Text(supplier.supplierName),
                    );
                  }).toList(),
                  selectedItem: provider.selectedSupplier,
                  onChanged: provider.setSupplier,
                  onAddNew: () => provider.addNewSupplier(context),
                  addNewButtonText: 'Add Supplier',
                  addDialogTitle: 'Add New Supplier',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Average Cost - Cost price per unit
              CustomTextFormField(
                controller: provider.averageCostController,
                labelText: 'Average Cost *',
                hint: 'Enter average cost',
                keyboardType: TextInputType.number,
                prefixText: provider.selectedCurrency ?? 'PKR',
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Average cost is required';
                  }
                  final double? cost = double.tryParse(value!);
                  if (cost == null || cost < 0) {
                    return 'Enter a valid cost';
                  }
                  return null;
                },
              ),

              // Show profit calculations if both cost and price are entered
              if (provider.averageCostController.text.isNotEmpty && 
                  provider.priceController.text.isNotEmpty) ...<Widget>[
                const SizedBox(height: DoubleConstants.spacingS),
                Container(
                  padding: const EdgeInsets.all(DoubleConstants.spacingS),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Profit Margin',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${provider.profitMargin.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey.shade300,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Markup',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${provider.markupPercentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}