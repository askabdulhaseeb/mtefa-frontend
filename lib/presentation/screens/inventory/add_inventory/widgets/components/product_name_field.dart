import 'package:flutter/material.dart';

import '../../../../../widgets/core/enhanced_text_form_field.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Product name field with validation and character count
class ProductNameField extends StatelessWidget {
  const ProductNameField({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return EnhancedTextFormField(
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
    );
  }
}