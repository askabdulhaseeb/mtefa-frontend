import 'package:flutter/material.dart';

import '../../../../../../domain/entities/inventory/brand_entity.dart';
import '../../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../widgets/core/custom_dropdown.dart';
import '../../providers/add_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Category and brand selection section
class InventoryCategorySection extends StatelessWidget {
  const InventoryCategorySection({
    required this.provider,
    super.key,
  });

  final AddInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return AddInventorySectionBgWidget(
      icon: Icons.category,
      title: 'Category & Brand',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Category Dropdown
          CustomDropdown<CategoryEntity>(
            title: 'Category *',
            hint: 'Select inventory category',
            selectedItem: provider.selectedCategory,
            items: provider.categories
                .map((CategoryEntity category) => DropdownMenuItem<CategoryEntity>(
                      value: category,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.category_outlined, size: 16),
                          const SizedBox(width: 8),
                          Text(category.categoryName),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (CategoryEntity? value) {
              provider.setCategory(value);
            },
            validator: (bool? value) {
              if (provider.selectedCategory == null) {
                return 'Please select a category';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          
          // Brand Dropdown
          CustomDropdown<BrandEntity>(
            title: 'Brand *',
            hint: 'Select inventory brand',
            selectedItem: provider.selectedBrand,
            items: provider.brands
                .map((BrandEntity brand) => DropdownMenuItem<BrandEntity>(
                      value: brand,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.branding_watermark_outlined, size: 16),
                          const SizedBox(width: 8),
                          Text(brand.name),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (BrandEntity? value) {
              provider.setBrand(value);
            },
            validator: (bool? value) {
              if (provider.selectedBrand == null) {
                return 'Please select a brand';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}