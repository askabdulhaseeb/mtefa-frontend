import 'package:flutter/material.dart';

import '../../../../../widgets/core/enhanced_text_form_field.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Product code field with auto-generation toggle
class ProductCodeField extends StatelessWidget {
  const ProductCodeField({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
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
            _AutoGenerateToggle(provider: provider),
          ],
        ),
      ],
    );
  }
}

/// Auto-generate toggle widget
class _AutoGenerateToggle extends StatelessWidget {
  const _AutoGenerateToggle({
    required this.provider,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
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
}