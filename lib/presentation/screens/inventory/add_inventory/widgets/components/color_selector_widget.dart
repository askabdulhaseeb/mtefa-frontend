import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';

/// Multi-select color chips widget
class ColorSelectorWidget extends StatelessWidget {
  const ColorSelectorWidget({
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    super.key,
  });

  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Product Colors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        _buildMultiSelectChips(
          context: context,
          items: items,
          selectedItems: selectedItems,
          onSelectionChanged: onSelectionChanged,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildMultiSelectChips({
    required BuildContext context,
    required List<String> items,
    required List<String> selectedItems,
    required ValueChanged<List<String>> onSelectionChanged,
    required Color color,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((String item) {
        final bool isSelected = selectedItems.contains(item);
        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getColorFromName(item),
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 6),
              Text(item),
            ],
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            final List<String> newSelection = List<String>.from(selectedItems);
            if (selected) {
              newSelection.add(item);
            } else {
              newSelection.remove(item);
            }
            onSelectionChanged(newSelection);
          },
          selectedColor: color.withAlpha(50),
          checkmarkColor: color,
          side: BorderSide(
            color: isSelected ? color : Colors.grey.shade400,
            width: 1.5,
          ),
        );
      }).toList(),
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