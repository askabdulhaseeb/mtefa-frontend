import 'package:flutter/material.dart';

import '../providers/add_inventory_provider.dart';
import '../widgets/components/inventory_basic_info_section.dart';
import '../widgets/components/inventory_category_section.dart';
import '../widgets/components/inventory_stock_section.dart';
import '../widgets/components/inventory_pricing_section.dart';

/// Mobile view for add inventory screen
class AddInventoryMobileView extends StatelessWidget {
  const AddInventoryMobileView({
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Basic Information
            InventoryBasicInfoSection(provider: provider),
            
            // Category & Brand
            InventoryCategorySection(provider: provider),
            
            // Pricing Information
            InventoryPricingSection(provider: provider),
            
            // Inventory Management
            InventoryStockSection(provider: provider),
            
            // Bottom padding for better scrolling
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}