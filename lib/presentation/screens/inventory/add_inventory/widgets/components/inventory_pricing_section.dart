import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../widgets/core/custom_textformfield.dart';
import '../../providers/add_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Pricing information section for inventory form
class InventoryPricingSection extends StatelessWidget {
  const InventoryPricingSection({
    required this.provider,
    super.key,
  });

  final AddInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return AddInventorySectionBgWidget(
      icon: Icons.monetization_on,
      title: 'Pricing Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            
            // Cost and Selling Price in a row (responsive)
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool showInRow = constraints.maxWidth > 400;
                
                if (showInRow) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomTextFormField(
                          controller: provider.costPriceController,
                          labelText: 'Cost Price (PKR) *',
                          hint: '0.00',
                          prefixText: 'PKR',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Cost price is required';
                            }
                            final double? price = double.tryParse(value);
                            if (price == null || price < 0) {
                              return 'Enter a valid price';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          controller: provider.sellingPriceController,
                          labelText: 'Selling Price (PKR) *',
                          hint: '0.00',
                          prefixText: 'PKR',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Selling price is required';
                            }
                            final double? price = double.tryParse(value);
                            if (price == null || price < 0) {
                              return 'Enter a valid price';
                            }
                            final double? costPrice = double.tryParse(provider.costPriceController.text);
                            if (costPrice != null && price < costPrice) {
                              return 'Selling price should be >= cost price';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      CustomTextFormField(
                        controller: provider.costPriceController,
                        labelText: 'Cost Price (PKR) *',
                        hint: '0.00',
                        prefixText: 'PKR',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Cost price is required';
                          }
                          final double? price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Enter a valid price';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      CustomTextFormField(
                        controller: provider.sellingPriceController,
                        labelText: 'Selling Price (PKR) *',
                        hint: '0.00',
                        prefixText: 'PKR',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Selling price is required';
                          }
                          final double? price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Enter a valid price';
                          }
                          final double? costPrice = double.tryParse(provider.costPriceController.text);
                          if (costPrice != null && price < costPrice) {
                            return 'Selling price should be >= cost price';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  );
                }
              },
            ),
            
            // Profit Margin and Markup Display
            if (provider.costPriceController.text.isNotEmpty && 
                provider.sellingPriceController.text.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Profit Margin',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${provider.profitMargin.toStringAsFixed(2)}%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: provider.profitMargin > 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.dividerColor,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Markup',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${provider.markupPercentage.toStringAsFixed(2)}%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: provider.markupPercentage > 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}