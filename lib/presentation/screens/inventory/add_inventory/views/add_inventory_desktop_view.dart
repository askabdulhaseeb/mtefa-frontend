import 'package:flutter/material.dart';

import '../providers/add_inventory_provider.dart';
import '../widgets/components/inventory_basic_info_section.dart';
import '../widgets/components/inventory_category_section.dart';
import '../widgets/components/inventory_stock_section.dart';
import '../widgets/components/inventory_pricing_section.dart';

/// Desktop view for add inventory screen
class AddInventoryDesktopView extends StatelessWidget {
  const AddInventoryDesktopView({
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
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Left Column
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      // Category & Brand Section
                      InventoryCategorySection(provider: provider),
                      const SizedBox(height: 24),
                      
                      // Quick Actions Card
                      _buildQuickActionsCard(context),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                
                // Right Column
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      // Basic Information
                      InventoryBasicInfoSection(provider: provider),
                      
                      // Pricing Information
                      InventoryPricingSection(provider: provider),
                      
                      // Inventory Management
                      InventoryStockSection(provider: provider),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildQuickActionsCard(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.flash_on,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Save as Draft
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Save as Draft'),
              subtitle: const Text('Save without publishing'),
              onTap: () {
                debugPrint('Save as draft');
              },
            ),
            const Divider(),
            
            // Duplicate Inventory
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: const Text('Duplicate Inventory'),
              subtitle: const Text('Create a copy of this inventory'),
              onTap: () {
                debugPrint('Duplicate inventory');
              },
            ),
            const Divider(),
            
            // Import from CSV
            ListTile(
              leading: const Icon(Icons.upload_file_outlined),
              title: const Text('Import from CSV'),
              subtitle: const Text('Bulk import inventories'),
              onTap: () {
                debugPrint('Import from CSV');
              },
            ),
          ],
        ),
      ),
    );
  }
}