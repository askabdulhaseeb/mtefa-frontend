import 'package:flutter/material.dart';

import '../../providers/comprehensive_inventory_provider.dart';

/// Variant preview widget showing size/color combinations
class VariantPreview extends StatelessWidget {
  const VariantPreview({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final int totalVariants = provider.selectedSizes.length * provider.selectedColors.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.preview, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Variant Preview',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$totalVariants variants',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (totalVariants <= 12)
            _buildVariantGrid()
          else
            _buildVariantSummary(totalVariants),
        ],
      ),
    );
  }

  Widget _buildVariantGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: provider.selectedSizes.expand((String size) {
        return provider.selectedColors.map((String color) {
          return Chip(
            label: Text('$size - $color'),
            backgroundColor: _getColorFromName(color).withAlpha(30),
            side: BorderSide(color: _getColorFromName(color)),
          );
        });
      }).toList(),
    );
  }

  Widget _buildVariantSummary(int totalVariants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Too many variants to display individually.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            _buildSummaryItem('Sizes', provider.selectedSizes.length.toString()),
            const SizedBox(width: 16),
            _buildSummaryItem('Colors', provider.selectedColors.length.toString()),
            const SizedBox(width: 16),
            _buildSummaryItem('Total', totalVariants.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
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