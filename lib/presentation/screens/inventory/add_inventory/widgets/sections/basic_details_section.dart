import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Basic details section for inventory creation (optional fields)
class BasicDetailsSection extends StatelessWidget {
  const BasicDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (BuildContext context, ComprehensiveInventoryProvider provider, Widget? child) {
        return AddInventorySectionBgWidget(
          icon: Icons.info_outline,
          title: 'Basic Details',
          child: Column(
            children: <Widget>[
              // Category - Product classification (Visibility Depends on Line Item)
              if (provider.shouldShowCategory) ...<Widget>[
                CustomDropdownWithAdd<CategoryEntity?>(
                  title: 'Category',
                  hint: 'Select category',
                  items: provider.categories.map((CategoryEntity category) {
                    return DropdownMenuItem<CategoryEntity?>(
                      value: category,
                      child: Text(category.categoryName),
                    );
                  }).toList(),
                  selectedItem: provider.selectedCategory,
                  onChanged: provider.setCategory,
                  onAddNew: () => provider.addNewCategory(context),
                  addNewButtonText: 'Add Category',
                  addDialogTitle: 'Add New Category',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Sub Category - Product classification (Visibility Depends on Category)
              if (provider.shouldShowSubCategory) ...<Widget>[
                CustomDropdownWithAdd<SubCategoryEntity?>(
                  title: 'Sub Category',
                  hint: 'Select sub category',
                  items: provider.subCategories.map((SubCategoryEntity subCategory) {
                    return DropdownMenuItem<SubCategoryEntity?>(
                      value: subCategory,
                      child: Text(subCategory.subCategoryName),
                    );
                  }).toList(),
                  selectedItem: provider.selectedSubCategory,
                  onChanged: provider.setSubCategory,
                  onAddNew: () => provider.addNewSubCategory(context),
                  addNewButtonText: 'Add Sub Category',
                  addDialogTitle: 'Add New Sub Category',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Product Group - Grouping for reports
              CustomDropdownWithAdd<String>(
                title: 'Product Group',
                hint: 'Select product group',
                items: provider.productGroups.map((String group) {
                  return DropdownMenuItem<String>(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                selectedItem: provider.selectedProductGroup,
                onChanged: provider.setProductGroup,
                onAddNew: () => provider.addNewProductGroup(context),
                addNewButtonText: 'Add Product Group',
                addDialogTitle: 'Add New Product Group',
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Age Group - Target demographic (Visibility Depends on Category)
              if (provider.shouldShowAgeGroup) ...<Widget>[
                CustomDropdownWithAdd<String>(
                  title: 'Age Group',
                  hint: 'Select age group',
                  items: provider.ageGroups.map((String ageGroup) {
                    return DropdownMenuItem<String>(
                      value: ageGroup,
                      child: Text(ageGroup),
                    );
                  }).toList(),
                  selectedItem: provider.selectedAgeGroup,
                  onChanged: provider.setAgeGroup,
                  onAddNew: () => provider.addNewAgeGroup(context),
                  addNewButtonText: 'Add Age Group',
                  addDialogTitle: 'Add New Age Group',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Packaging Type - How product is packaged
              CustomDropdownWithAdd<String>(
                title: 'Packaging Type',
                hint: 'Select packaging type',
                items: provider.packagingTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                selectedItem: provider.selectedPackagingType,
                onChanged: provider.setPackagingType,
                onAddNew: () => provider.addNewPackagingType(context),
                addNewButtonText: 'Add Packaging Type',
                addDialogTitle: 'Add New Packaging Type',
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Product Gender - Male/Female/Unisex
              CustomDropdownWithAdd<String>(
                title: 'Product Gender',
                hint: 'Select product gender',
                items: provider.productGenders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                selectedItem: provider.selectedProductGender,
                onChanged: provider.setProductGender,
                onAddNew: () => provider.addNewProductGender(context),
                addNewButtonText: 'Add Gender Option',
                addDialogTitle: 'Add New Gender Option',
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Shop Quality - Quality grade/level
              CustomTextFormField(
                controller: provider.shopQualityController,
                labelText: 'Shop Quality',
                hint: 'Enter shop quality rating',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final double? quality = double.tryParse(value!);
                    if (quality == null || quality < 0 || quality > 100) {
                      return 'Enter a valid quality rating (0-100)';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Store Quality - Quantity in the store
              CustomTextFormField(
                controller: provider.storeQualityController,
                labelText: 'Store Quality',
                hint: 'Enter store quantity',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final double? quantity = double.tryParse(value!);
                    if (quantity == null || quantity < 0) {
                      return 'Enter a valid quantity';
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}