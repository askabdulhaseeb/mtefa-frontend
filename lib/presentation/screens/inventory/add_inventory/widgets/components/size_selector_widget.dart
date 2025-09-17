import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';

/// Multi-select size chips widget
class SizeSelectorWidget extends StatelessWidget {
  const SizeSelectorWidget({
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
          'Product Sizes',
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
          color: Colors.blue,
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
          label: Text(item),
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
}