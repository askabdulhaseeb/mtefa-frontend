import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../enhanced_section_card.dart';
import '../components/inventory_line_dropdown.dart';
import '../components/product_code_field.dart';
import '../components/product_name_field.dart';
import '../components/supplier_dropdown.dart';
import '../components/average_cost_field.dart';
import '../components/profit_visualization.dart';

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
                  InventoryLineDropdown(provider: provider),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Product Code with auto-generation toggle
                  ProductCodeField(provider: provider),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Product Name field
                  ProductNameField(provider: provider),

                  const SizedBox(height: DoubleConstants.spacingL),

                  // Conditional Supplier field
                  if (provider.shouldShowSupplier) ...<Widget>[
                    SupplierDropdown(provider: provider),
                    const SizedBox(height: DoubleConstants.spacingL),
                  ],

                  // Average Cost field with currency
                  AverageCostField(provider: provider),

                  // Profit margin visualization
                  if (provider.averageCostController.text.isNotEmpty &&
                      provider.priceController.text.isNotEmpty) ...<Widget>[
                    const SizedBox(height: DoubleConstants.spacingL),
                    ProfitVisualization(provider: provider),
                  ],
                ],
              ),
            );
          },
    );
  }
}
