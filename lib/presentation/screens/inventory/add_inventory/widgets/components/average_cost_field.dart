import 'package:flutter/material.dart';

import '../../../../../widgets/core/enhanced_text_form_field.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Average cost field with currency prefix
class AverageCostField extends StatelessWidget {
  const AverageCostField({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
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
}