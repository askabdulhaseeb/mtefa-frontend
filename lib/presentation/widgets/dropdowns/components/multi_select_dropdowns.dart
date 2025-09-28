import 'package:flutter/material.dart';

import '../../../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../../../domain/entities/inventory/inventory_sizes_entity.dart';

/// Multi-select dropdown for colors with checkbox list and color preview
class ColorMultiSelectDropdown extends StatelessWidget {
  const ColorMultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.onAdd,
    required this.isEnabled,
    super.key,
  });

  final List<InventoryColorsEntity> items;
  final List<InventoryColorsEntity> selectedItems;
  final ValueChanged<List<InventoryColorsEntity>> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(theme),
        const SizedBox(height: 8),
        _buildColorContainer(theme),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Colors',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
          onPressed: isEnabled ? onAdd : null,
          tooltip: 'Add New Color',
        ),
      ],
    );
  }

  Widget _buildColorContainer(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
        color: isEnabled 
            ? theme.colorScheme.surface 
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      child: Column(
        children: <Widget>[
          if (items.isEmpty)
            _buildEmptyState(theme)
          else
            ...items.map((InventoryColorsEntity color) {
              final bool isSelected = selectedItems.contains(color);
              return _buildColorItem(color, isSelected, theme);
            }),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'No colors available. Click + to add.',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
    );
  }

  Widget _buildColorItem(InventoryColorsEntity color, bool isSelected, ThemeData theme) {
    return CheckboxListTile(
      title: Text(color.colorName),
      subtitle: color.colorCode.isNotEmpty
          ? Text(color.colorCode)
          : null,
      value: isSelected,
      onChanged: isEnabled
          ? (bool? value) {
              if (value == true) {
                onChanged(<InventoryColorsEntity>[...selectedItems, color]);
              } else {
                onChanged(selectedItems.where((InventoryColorsEntity c) => c != color).toList());
              }
            }
          : null,
      secondary: _buildColorPreview(color, theme),
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget? _buildColorPreview(InventoryColorsEntity color, ThemeData theme) {
    final Color? colorValue = _parseHexColor(color.hexColor);
    if (colorValue == null) return null;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: colorValue,
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Color? _parseHexColor(String? hexString) {
    if (hexString == null || hexString.isEmpty) return null;
    
    final String hex = hexString.replaceAll('#', '');
    if (hex.length != 6) return null;
    
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return null;
    }
  }
}

/// Multi-select dropdown for sizes with filter chips
class SizeMultiSelectDropdown extends StatelessWidget {
  const SizeMultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.onAdd,
    required this.isEnabled,
    super.key,
  });

  final List<InventorySizesEntity> items;
  final List<InventorySizesEntity> selectedItems;
  final ValueChanged<List<InventorySizesEntity>> onChanged;
  final VoidCallback onAdd;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(theme),
        const SizedBox(height: 8),
        _buildSizeContainer(theme),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Sizes',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: isEnabled ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
          onPressed: isEnabled ? onAdd : null,
          tooltip: 'Add New Size',
        ),
      ],
    );
  }

  Widget _buildSizeContainer(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
        color: isEnabled 
            ? theme.colorScheme.surface 
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            if (items.isEmpty)
              _buildEmptyState(theme)
            else
              ...items.map((InventorySizesEntity size) {
                final bool isSelected = selectedItems.contains(size);
                return _buildSizeChip(size, isSelected, theme);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'No sizes available. Click + to add.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSizeChip(InventorySizesEntity size, bool isSelected, ThemeData theme) {
    return FilterChip(
      label: Text(size.sizeName),
      selected: isSelected,
      onSelected: isEnabled
          ? (bool selected) {
              if (selected) {
                onChanged(<InventorySizesEntity>[...selectedItems, size]);
              } else {
                onChanged(selectedItems.where((InventorySizesEntity s) => s != size).toList());
              }
            }
          : null,
      showCheckmark: true,
    );
  }
}