import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Purchase Configuration section for inventory creation
class PurchaseConfigurationSection extends StatelessWidget {
  const PurchaseConfigurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (BuildContext context, ComprehensiveInventoryProvider provider, Widget? child) {
        return AddInventorySectionBgWidget(
          icon: Icons.shopping_cart,
          title: 'Purchase Configuration',
          child: Column(
            children: <Widget>[
              // Purchase Conv. Unit - Pack, Bottle, etc. (Visibility Depends on Category)
              if (provider.shouldShowPurchaseConvUnit) ...<Widget>[
                CustomDropdownWithAdd<String?>(
                  title: 'Purchase Conversion Unit',
                  hint: 'Select purchase unit',
                  items: provider.purchaseConvUnits.map((String unit) {
                    return DropdownMenuItem<String?>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  selectedItem: provider.selectedPurchaseConvUnit,
                  onChanged: provider.setPurchaseConvUnit,
                  onAddNew: () async {
                    // TODO: Implement add new purchase unit
                    return null;
                  },
                  addNewButtonText: 'Add Purchase Unit',
                  addDialogTitle: 'Add New Purchase Unit',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Purchase Conv. Factor - Units per pack (10 tablets/pack)
              CustomTextFormField(
                controller: provider.purchaseConvFactorController,
                labelText: 'Purchase Conversion Factor',
                hint: 'Enter units per pack (e.g., 10 tablets/pack)',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final double? factor = double.tryParse(value!);
                    if (factor == null || factor <= 0) {
                      return 'Enter a valid conversion factor';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Acquire Type - Purchased/Local/Outsourced (Visibility Depends on Line Item)
              if (provider.shouldShowAcquireType) ...<Widget>[
                CustomDropdownWithAdd<String?>(
                  title: 'Acquire Type',
                  hint: 'Select acquire type',
                  items: provider.acquireTypes.map((String type) {
                    return DropdownMenuItem<String?>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  selectedItem: provider.selectedAcquireType,
                  onChanged: provider.setAcquireType,
                  onAddNew: () async {
                    // TODO: Implement add new acquire type
                    return null;
                  },
                  addNewButtonText: 'Add Acquire Type',
                  addDialogTitle: 'Add New Acquire Type',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Purchase Type - Local/Import (Visibility Depends on Line Item)
              if (provider.shouldShowPurchaseType) ...<Widget>[
                CustomDropdownWithAdd<String?>(
                  title: 'Purchase Type',
                  hint: 'Select purchase type',
                  items: provider.purchaseTypes.map((String type) {
                    return DropdownMenuItem<String?>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  selectedItem: provider.selectedPurchaseType,
                  onChanged: provider.setPurchaseType,
                  onAddNew: () async {
                    // TODO: Implement add new purchase type
                    return null;
                  },
                  addNewButtonText: 'Add Purchase Type',
                  addDialogTitle: 'Add New Purchase Type',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Manufacturing - Manufactured/Outsourced (Visibility Depends on Line Item)
              if (provider.shouldShowManufacturing) ...<Widget>[
                CustomDropdownWithAdd<String?>(
                  title: 'Manufacturing',
                  hint: 'Select manufacturing type',
                  items: provider.manufacturingTypes.map((String type) {
                    return DropdownMenuItem<String?>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  selectedItem: provider.selectedManufacturing,
                  onChanged: provider.setManufacturing,
                  onAddNew: () async {
                    // TODO: Implement add new manufacturing type
                    return null;
                  },
                  addNewButtonText: 'Add Manufacturing Type',
                  addDialogTitle: 'Add New Manufacturing Type',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Show purchase calculation if conversion factor is provided
              if (provider.purchaseConvFactorController.text.isNotEmpty &&
                  provider.averageCostController.text.isNotEmpty) ...<Widget>[
                const SizedBox(height: DoubleConstants.spacingS),
                _buildPurchaseCalculation(provider),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Build purchase calculation widget
  Widget _buildPurchaseCalculation(ComprehensiveInventoryProvider provider) {
    final double unitCost =
        double.tryParse(provider.averageCostController.text) ?? 0;
    final double convFactor =
        double.tryParse(provider.purchaseConvFactorController.text) ?? 1;
    final double packCost = unitCost * convFactor;

    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.purple.withValues(alpha: 0.1),
            Colors.indigo.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calculate, color: Colors.purple.shade600, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Purchase Calculation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: DoubleConstants.spacingM),

          Row(
            children: <Widget>[
              Expanded(
                child: _buildCalculationCard(
                  'Unit Cost',
                  '${provider.selectedCurrency} ${unitCost.toStringAsFixed(2)}',
                  Colors.blue,
                  Icons.inventory,
                ),
              ),
              const SizedBox(width: DoubleConstants.spacingS),
              const Icon(Icons.close, size: 16, color: Colors.grey),
              const SizedBox(width: DoubleConstants.spacingS),
              Expanded(
                child: _buildCalculationCard(
                  'Conversion Factor',
                  '${convFactor.toStringAsFixed(0)} units/${provider.selectedPurchaseConvUnit ?? 'pack'}',
                  Colors.orange,
                  Icons.transform,
                ),
              ),
            ],
          ),

          const SizedBox(height: DoubleConstants.spacingS),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.arrow_downward, color: Colors.grey, size: 20),
            ],
          ),

          const SizedBox(height: DoubleConstants.spacingS),

          Center(
            child: _buildCalculationCard(
              'Pack Cost',
              '${provider.selectedCurrency} ${packCost.toStringAsFixed(2)}',
              Colors.green,
              Icons.shopping_bag,
            ),
          ),
        ],
      ),
    );
  }

  /// Build calculation card widget
  Widget _buildCalculationCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingS),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
