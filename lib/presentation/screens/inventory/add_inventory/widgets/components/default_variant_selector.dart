import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';

/// Default size and color selector widget
class DefaultVariantSelector extends StatelessWidget {
  const DefaultVariantSelector({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Default Size
        if (provider.selectedSizes.isNotEmpty) ...<Widget>[
          Expanded(
            child: _DefaultSizeDropdown(provider: provider),
          ),
        ],

        if (provider.selectedSizes.isNotEmpty && provider.selectedColors.isNotEmpty)
          const SizedBox(width: DoubleConstants.spacingM),

        // Default Color
        if (provider.selectedColors.isNotEmpty) ...<Widget>[
          Expanded(
            child: _DefaultColorDropdown(provider: provider),
          ),
        ],
      ],
    );
  }
}

/// Default size dropdown widget
class _DefaultSizeDropdown extends StatelessWidget {
  const _DefaultSizeDropdown({
    required this.provider,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWithAdd<String?>(
      title: 'Default Size',
      hint: 'Select default size',
      items: provider.selectedSizes.map((String size) {
        return DropdownMenuItem<String?>(
          value: size,
          child: Text(size),
        );
      }).toList(),
      selectedItem: provider.selectedDefaultSize,
      onChanged: provider.setDefaultSize,
      onAddNew: () async {
        // For default size, we don't add new - only select from existing
        return null;
      },
      addNewButtonText: 'N/A',
      addDialogTitle: 'Select from Available Sizes',
    );
  }
}

/// Default color dropdown widget
class _DefaultColorDropdown extends StatelessWidget {
  const _DefaultColorDropdown({
    required this.provider,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWithAdd<String?>(
      title: 'Default Color',
      hint: 'Select default color',
      items: provider.selectedColors.map((String color) {
        return DropdownMenuItem<String?>(
          value: color,
          child: Row(
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _getColorFromName(color),
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(color),
            ],
          ),
        );
      }).toList(),
      selectedItem: provider.selectedDefaultColor,
      onChanged: provider.setDefaultColor,
      onAddNew: () async {
        // For default color, we don't add new - only select from existing
        return null;
      },
      addNewButtonText: 'N/A',
      addDialogTitle: 'Select from Available Colors',
    );
  }

  /// Get color from name (simplified implementation)
  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'brown':
        return Colors.brown;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.grey.shade400;
    }
  }
}