import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_validators.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../providers/add_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Basic information section for inventory form
class InventoryBasicInfoSection extends StatelessWidget {
  const InventoryBasicInfoSection({required this.provider, super.key});

  final AddInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return AddInventorySectionBgWidget(
      icon: Icons.info_outline,
      title: 'Basic Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Inventory Name
          CustomTextFormField(
            controller: provider.nameController,
            labelText: 'Inventory Name *',
            hint: 'Enter inventory name',
            prefixIcon: const Icon(Icons.shopping_bag_outlined, size: 20),
            validator: AppValidator.isEmpty,
            textInputAction: TextInputAction.next,
          ),

          // Inventory Code/SKU with auto-generate option
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  controller: provider.codeController,
                  labelText: 'Inventory Code (SKU) *',
                  hint: provider.autoGenerateCode
                      ? 'Auto-generated'
                      : 'Enter inventory code',
                  prefixIcon: const Icon(Icons.qr_code, size: 20),
                  readOnly: provider.autoGenerateCode,
                  validator: AppValidator.isEmpty,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: provider.autoGenerateCode,
                      onChanged: (bool? value) {
                        provider.toggleAutoGenerateCode(value ?? false);
                      },
                    ),
                    const Text('Auto-generate'),
                  ],
                ),
              ),
            ],
          ),

          // Description
          CustomTextFormField(
            controller: provider.descriptionController,
            labelText: 'Description',
            hint: 'Enter inventory description (optional)',
            prefixIcon: const Icon(Icons.description_outlined, size: 20),
            minLines: 3,
            maxLines: 5,
            textInputAction: TextInputAction.newline,
          ),
        ],
      ),
    );
  }
}
