import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../providers/comprehensive_inventory_provider.dart';
import '../widgets/sections/additional_section.dart';
import '../widgets/sections/basic_details_section.dart';
import '../widgets/sections/inventory_management_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/purchase_configuration_section.dart';
import '../widgets/sections/required_fields_section.dart';
import '../widgets/sections/sizes_colors_section.dart';

/// Comprehensive mobile view for add inventory screen
class ComprehensiveInventoryMobileView extends StatelessWidget {
  const ComprehensiveInventoryMobileView({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

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
            // Required Fields Section
            RequiredFieldsSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Basic Details Section
            BasicDetailsSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Pricing & Sales Section
            PricingSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Sizes & Colors Section
            SizesColorsSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Purchase Configuration Section
            PurchaseConfigurationSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Inventory Management Section
            InventoryManagementSection(),
            const SizedBox(height: DoubleConstants.spacingL),
            
            // Additional Information Section
            AdditionalSection(),
            
            // Bottom padding for floating action button
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}