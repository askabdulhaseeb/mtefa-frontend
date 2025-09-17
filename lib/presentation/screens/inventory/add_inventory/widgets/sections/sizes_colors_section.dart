import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';
import '../components/size_selector_widget.dart';
import '../components/color_selector_widget.dart';
import '../components/default_variant_selector.dart';
import '../components/variant_preview.dart';

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
                SizeSelectorWidget(
                  items: provider.sizes,
                  selectedItems: provider.selectedSizes,
                  onSelectionChanged: provider.setSizes,
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Product Colors - Check applicable colors (Visibility Depends on Category)
              if (provider.shouldShowColors) ...<Widget>[
                ColorSelectorWidget(
                  items: provider.colors,
                  selectedItems: provider.selectedColors,
                  onSelectionChanged: provider.setColors,
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Default Size & Color - Set defaults (Visibility Depends on Category)
              if (provider.shouldShowDefaultSizeColor) ...<Widget>[
                DefaultVariantSelector(provider: provider),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Show variant preview if both sizes and colors are selected
              if (provider.selectedSizes.isNotEmpty && provider.selectedColors.isNotEmpty) ...<Widget>[
                VariantPreview(provider: provider),
              ],
            ],
          ),
        );
      },
    );
  }
}