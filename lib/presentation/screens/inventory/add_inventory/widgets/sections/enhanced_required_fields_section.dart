import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../../domain/entities/inventory/supplier_entity.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/enhanced_text_form_field.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../enhanced_section_card.dart';

/// Enhanced required fields section with improved UI/UX
class EnhancedRequiredFieldsSection extends StatelessWidget {
  const EnhancedRequiredFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Consumer<ComprehensiveInventoryProvider>(
      builder:
          (
            BuildContext context,
            ComprehensiveInventoryProvider provider,
            Widget? child,
          ) {
            return EnhancedSectionCard(
              icon: Icons.inventory_2_outlined,
              title: 'Essential Information',
              subtitle:
                  'Core product details required for inventory management',
              isRequired: true,
              iconColor: colorScheme.error,
              child: Column(
                children: <Widget>[
                  // Line Item Selection with visual enhancement
                  _buildLineItemSelector(context, provider),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Product Code with auto-generation toggle
                  _buildProductCodeField(context, provider),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Product Name field
                  EnhancedTextFormField(
                    controller: provider.productNameController,
                    label: 'Product Name',
                    hint: 'Enter a descriptive product name',
                    helperText: 'This name will appear on invoices and reports',
                    isRequired: true,
                    prefixIcon: const Icon(Icons.label_outline),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Product name is required';
                      }
                      if (value!.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                    showCharacterCount: true,
                    maxLength: 100,
                  ),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Conditional Supplier field
                  if (provider.shouldShowSupplier) ...<Widget>[
                    _buildSupplierSelector(context, provider),
                    const SizedBox(height: DoubleConstants.spacingL),
                  ],

                  // Average Cost field with currency
                  _buildCostField(context, provider),

                  // Profit margin visualization
                  if (provider.averageCostController.text.isNotEmpty &&
                      provider.priceController.text.isNotEmpty) ...<Widget>[
                    const SizedBox(height: DoubleConstants.spacingL),
                    _buildProfitVisualization(context, provider),
                  ],
                ],
              ),
            );
          },
    );
  }

  Widget _buildLineItemSelector(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
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

  Widget _buildProductCodeField(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: EnhancedTextFormField(
                controller: provider.productCodeController,
                label: 'Product Code',
                hint: provider.autoGenerateCode
                    ? 'Will be auto-generated'
                    : 'Enter unique code',
                helperText: provider.autoGenerateCode
                    ? 'Code will be generated on save'
                    : 'Unique identifier for this product',
                isRequired: true,
                readOnly: provider.autoGenerateCode,
                prefixIcon: const Icon(Icons.qr_code_2),
                validator: (String? value) {
                  if (!provider.autoGenerateCode && (value?.isEmpty ?? true)) {
                    return 'Product code is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            _buildAutoGenerateToggle(context, provider),
          ],
        ),
      ],
    );
  }

  Widget _buildAutoGenerateToggle(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Material(
      color: provider.autoGenerateCode
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () =>
            provider.toggleAutoGenerateCode(!provider.autoGenerateCode),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: <Widget>[
              Icon(
                provider.autoGenerateCode
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                size: 20,
                color: provider.autoGenerateCode
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Auto',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: provider.autoGenerateCode
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupplierSelector(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
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
          // onAddNew: provider.addNewSupplier(context),
          onAddNew: () async {
            return await provider.addNewSupplier(context);
          },
          addNewButtonText: 'Add New Supplier',
          addDialogTitle: 'Register Supplier',
        ),
      ],
    );
  }

  Widget _buildCostField(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
    return EnhancedTextFormField(
      controller: provider.averageCostController,
      label: 'Average Cost',
      hint: 'Enter cost per unit',
      helperText: 'Base cost before markup',
      isRequired: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      prefixText: provider.selectedCurrency,
      prefixIcon: const Icon(Icons.payments_outlined),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Cost is required for pricing calculations';
        }
        final double? cost = double.tryParse(value!);
        if (cost == null || cost < 0) {
          return 'Please enter a valid cost amount';
        }
        return null;
      },
    );
  }

  Widget _buildProfitVisualization(
    BuildContext context,
    ComprehensiveInventoryProvider provider,
  ) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.green.withAlpha(10),
            Colors.blue.withAlpha(10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.insights, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Profit Analysis',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Profit Margin',
                  '${provider.profitMargin.toStringAsFixed(1)}%',
                  Colors.green,
                  Icons.trending_up,
                  provider.profitMargin > 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  context,
                  'Markup',
                  '${provider.markupPercentage.toStringAsFixed(1)}%',
                  Colors.blue,
                  Icons.percent,
                  provider.markupPercentage > 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Profit health indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _getProfitHealthColor(provider.profitMargin).withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  _getProfitHealthIcon(provider.profitMargin),
                  size: 16,
                  color: _getProfitHealthColor(provider.profitMargin),
                ),
                const SizedBox(width: 8),
                Text(
                  _getProfitHealthText(provider.profitMargin),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getProfitHealthColor(provider.profitMargin),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
    bool isHighlighted,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(isHighlighted ? 30 : 15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(isHighlighted ? 100 : 50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: color.withAlpha(200),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProfitHealthColor(double margin) {
    if (margin >= 30) return Colors.green;
    if (margin >= 20) return Colors.blue;
    if (margin >= 10) return Colors.orange;
    return Colors.red;
  }

  IconData _getProfitHealthIcon(double margin) {
    if (margin >= 30) return Icons.sentiment_very_satisfied;
    if (margin >= 20) return Icons.sentiment_satisfied;
    if (margin >= 10) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  String _getProfitHealthText(double margin) {
    if (margin >= 30) return 'Excellent profit margin';
    if (margin >= 20) return 'Good profit margin';
    if (margin >= 10) return 'Fair profit margin';
    return 'Low profit margin - consider adjusting price';
  }
}
