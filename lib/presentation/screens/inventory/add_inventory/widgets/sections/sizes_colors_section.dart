import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Sizes & Colors section for inventory creation (if Line Item configured)
class SizesColorsSection extends StatelessWidget {
  const SizesColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (BuildContext context, ComprehensiveInventoryProvider provider, Widget? child) {
        // Only show this section if sizes or colors are applicable
        if (!provider.shouldShowSizes && !provider.shouldShowColors) {
          return const SizedBox.shrink();
        }

        return AddInventorySectionBgWidget(
          icon: Icons.palette,
          title: 'Size & Color Configuration',
          child: Column(
            children: <Widget>[
              // Product Sizes - Check applicable sizes (Visibility Depends on Category)
              if (provider.shouldShowSizes) ...<Widget>[
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
                  items: provider.sizes,
                  selectedItems: provider.selectedSizes,
                  onSelectionChanged: provider.setSizes,
                  color: Colors.blue,
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Product Colors - Check applicable colors (Visibility Depends on Category)
              if (provider.shouldShowColors) ...<Widget>[
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
                  items: provider.colors,
                  selectedItems: provider.selectedColors,
                  onSelectionChanged: provider.setColors,
                  color: Colors.green,
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Default Size & Color - Set defaults (Visibility Depends on Category)
              if (provider.shouldShowDefaultSizeColor) ...<Widget>[
                Row(
                  children: <Widget>[
                    // Default Size
                    if (provider.selectedSizes.isNotEmpty) ...<Widget>[
                      Expanded(
                        child: CustomDropdownWithAdd<String>(
                          title: 'Default Size',
                          hint: 'Select default size',
                          items: provider.selectedSizes.map((String size) {
                            return DropdownMenuItem<String>(
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
                        ),
                      ),
                    ],

                    if (provider.selectedSizes.isNotEmpty && provider.selectedColors.isNotEmpty)
                      const SizedBox(width: DoubleConstants.spacingM),

                    // Default Color
                    if (provider.selectedColors.isNotEmpty) ...<Widget>[
                      Expanded(
                        child: CustomDropdownWithAdd<String>(
                          title: 'Default Color',
                          hint: 'Select default color',
                          items: provider.selectedColors.map((String color) {
                            return DropdownMenuItem<String>(
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
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Show variant preview if both sizes and colors are selected
              if (provider.selectedSizes.isNotEmpty && provider.selectedColors.isNotEmpty) ...<Widget>[
                _buildVariantPreview(provider),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Build multi-select chips widget
  Widget _buildMultiSelectChips({
    required BuildContext context,
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onSelectionChanged,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DoubleConstants.spacingS),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items.map((String item) {
          final bool isSelected = selectedItems.contains(item);
          return FilterChip(
            label: Text(
              item,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontSize: 12,
              ),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              final List<String> newSelection = List.from(selectedItems);
              if (selected) {
                newSelection.add(item);
              } else {
                newSelection.remove(item);
              }
              onSelectionChanged(newSelection);
            },
            selectedColor: color,
            checkmarkColor: Colors.white,
            backgroundColor: Colors.grey.shade100,
            side: BorderSide(color: color.withValues(alpha: 0.5)),
          );
        }).toList(),
      ),
    );
  }

  /// Build variant preview widget
  Widget _buildVariantPreview(ComprehensiveInventoryProvider provider) {
    final int totalVariants = provider.selectedSizes.length * provider.selectedColors.length;
    
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.indigo.withValues(alpha: 0.1),
            Colors.purple.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.grid_view,
                color: Colors.indigo.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Variant Preview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: DoubleConstants.spacingS),
          
          Text(
            'Total Variants: $totalVariants',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade700,
            ),
          ),
          
          const SizedBox(height: DoubleConstants.spacingS),
          
          // Show a few example variants
          Text(
            'Examples:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: DoubleConstants.spacingXS),
          
          ...provider.selectedSizes.take(2).expand((String size) {
            return provider.selectedColors.take(3).map((String color) {
              final bool isDefault = size == provider.selectedDefaultSize && 
                                   color == provider.selectedDefaultColor;
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getColorFromName(color),
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$size - $color',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isDefault ? FontWeight.bold : FontWeight.normal,
                        color: isDefault ? Colors.indigo.shade700 : Colors.grey.shade700,
                      ),
                    ),
                    if (isDefault) ...<Widget>[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber.shade600,
                      ),
                    ],
                  ],
                ),
              );
            });
          }),
          
          if (totalVariants > 6) ...<Widget>[
            Text(
              '... and ${totalVariants - 6} more variants',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Get color from color name (simple mapping)
  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      case 'navy': return Colors.indigo;
      case 'grey': case 'gray': return Colors.grey;
      case 'brown': return Colors.brown;
      case 'pink': return Colors.pink;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      default: return Colors.grey.shade400;
    }
  }
}