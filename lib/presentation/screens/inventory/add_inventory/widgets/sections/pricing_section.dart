import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Pricing & Sales section for inventory creation
class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (context, provider, child) {
        return AddInventorySectionBgWidget(
          icon: Icons.attach_money,
          title: 'Pricing & Sales',
          child: Column(
            children: [
              // Price - Retail price (leave empty for flexible pricing)
              CustomTextFormField(
                controller: provider.priceController,
                labelText: 'Price',
                hint: 'Enter retail price (optional for flexible pricing)',
                keyboardType: TextInputType.number,
                prefixText: provider.selectedCurrency ?? 'PKR',
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final double? price = double.tryParse(value!);
                    if (price == null || price < 0) {
                      return 'Enter a valid price';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // VAT - Tax percentage
              CustomTextFormField(
                controller: provider.vatController,
                labelText: 'VAT (%)',
                hint: 'Enter VAT percentage',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final double? vat = double.tryParse(value!);
                    if (vat == null || vat < 0 || vat > 100) {
                      return 'Enter a valid VAT percentage (0-100)';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // User Price - Allow flexible pricing at POS
              CustomTextFormField(
                controller: provider.userPriceController,
                labelText: 'User Price',
                hint: 'Enter user-defined price',
                keyboardType: TextInputType.number,
                prefixText: provider.selectedCurrency ?? 'PKR',
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final double? userPrice = double.tryParse(value!);
                    if (userPrice == null || userPrice < 0) {
                      return 'Enter a valid user price';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Product ID - Alternative identifier
              CustomTextFormField(
                controller: provider.productIdController,
                labelText: 'Product ID',
                hint: 'Enter alternative product identifier',
                validator: (value) {
                  // Optional field, no validation required
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Select Currency - If multi-currency
              CustomDropdownWithAdd<String>(
                title: 'Currency',
                hint: 'Select currency',
                items: provider.currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                selectedItem: provider.selectedCurrency,
                onChanged: provider.setCurrency,
                onAddNew: () async {
                  // TODO: Implement add new currency
                  return null;
                },
                addNewButtonText: 'Add Currency',
                addDialogTitle: 'Add New Currency',
              ),

              // Show price calculations if cost and price are available
              if (provider.averageCostController.text.isNotEmpty && 
                  provider.priceController.text.isNotEmpty) ...[
                const SizedBox(height: DoubleConstants.spacingM),
                Container(
                  padding: const EdgeInsets.all(DoubleConstants.spacingM),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withValues(alpha: 0.1),
                        Colors.blue.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Profit Analysis',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: DoubleConstants.spacingS),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricCard(
                              'Profit Margin',
                              '${provider.profitMargin.toStringAsFixed(2)}%',
                              Colors.green,
                              Icons.trending_up,
                            ),
                          ),
                          const SizedBox(width: DoubleConstants.spacingS),
                          Expanded(
                            child: _buildMetricCard(
                              'Markup',
                              '${provider.markupPercentage.toStringAsFixed(2)}%',
                              Colors.blue,
                              Icons.analytics,
                            ),
                          ),
                        ],
                      ),
                      if (provider.vatController.text.isNotEmpty) ...[
                        const SizedBox(height: DoubleConstants.spacingS),
                        _buildVATCalculation(provider),
                      ],
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

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingS),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVATCalculation(ComprehensiveInventoryProvider provider) {
    final double basePrice = double.tryParse(provider.priceController.text) ?? 0;
    final double vatRate = double.tryParse(provider.vatController.text) ?? 0;
    final double vatAmount = basePrice * (vatRate / 100);
    final double finalPrice = basePrice + vatAmount;

    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingS),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VAT Calculation',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DoubleConstants.spacingXS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Base Price:'),
              Text('${provider.selectedCurrency ?? 'PKR'} ${basePrice.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('VAT (${vatRate.toStringAsFixed(1)}%):'),
              Text('${provider.selectedCurrency ?? 'PKR'} ${vatAmount.toStringAsFixed(2)}'),
            ],
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Final Price:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${provider.selectedCurrency ?? 'PKR'} ${finalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}