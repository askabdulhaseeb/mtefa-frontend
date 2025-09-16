import 'package:flutter/material.dart';

import '../providers/add_inventory_provider.dart';
import '../widgets/components/inventory_basic_info_section.dart';
import '../widgets/components/inventory_category_section.dart';
import '../widgets/components/inventory_stock_section.dart';
import '../widgets/components/inventory_pricing_section.dart';

/// Tablet view for add inventory screen
class AddInventoryTabletView extends StatelessWidget {
  const AddInventoryTabletView({
    required this.provider,
    super.key,
  });

  final AddInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Form(
      key: provider.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Basic Information
                InventoryBasicInfoSection(provider: provider),
                
                // Category & Brand in two columns
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: InventoryCategorySection(provider: provider),
                    ),
                  ],
                ),
                
                // Pricing and Inventory side by side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: InventoryPricingSection(provider: provider),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InventoryStockSection(provider: provider),
                    ),
                  ],
                ),
                
                // Bottom padding for better scrolling
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}