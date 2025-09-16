import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/custom_dropdown_with_add.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Additional section for date and comments
class AdditionalSection extends StatelessWidget {
  const AdditionalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (context, provider, child) {
        return AddInventorySectionBgWidget(
          icon: Icons.more_horiz,
          title: 'Additional Information',
          child: Column(
            children: [
              // Date - Entry date
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: TextEditingController(
                        text: provider.selectedDate != null
                            ? '${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}'
                            : '',
                      ),
                      labelText: 'Date',
                      hint: 'Select entry date',
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: IconButton(
                      onPressed: () => _selectDate(context, provider),
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      tooltip: 'Select Date',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Life Type - Product lifecycle category (Visibility Depends on Category)
              if (provider.shouldShowLifeType) ...[
                CustomDropdownWithAdd<String>(
                  title: 'Life Type',
                  hint: 'Select life type',
                  items: provider.lifeTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  selectedItem: provider.selectedLifeType,
                  onChanged: provider.setLifeType,
                  onAddNew: () async {
                    // TODO: Implement add new life type
                    return null;
                  },
                  addNewButtonText: 'Add Life Type',
                  addDialogTitle: 'Add New Life Type',
                ),
                const SizedBox(height: DoubleConstants.spacingM),
              ],

              // Comments - Additional notes
              CustomTextFormField(
                controller: provider.commentsController,
                labelText: 'Comments',
                hint: 'Enter additional notes or comments',
                maxLines: 4,
                isExpanded: true,
                validator: (value) {
                  // Comments are optional, no validation required
                  return null;
                },
              ),

              // Show summary if key fields are filled
              if (_shouldShowSummary(provider)) ...[
                const SizedBox(height: DoubleConstants.spacingL),
                _buildSummaryCard(provider),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Select date function
  Future<void> _selectDate(BuildContext context, ComprehensiveInventoryProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != provider.selectedDate) {
      provider.setDate(picked);
    }
  }

  /// Check if summary should be shown
  bool _shouldShowSummary(ComprehensiveInventoryProvider provider) {
    return provider.productNameController.text.isNotEmpty &&
           provider.averageCostController.text.isNotEmpty &&
           provider.selectedLineItem != null;
  }

  /// Build summary card
  Widget _buildSummaryCard(ComprehensiveInventoryProvider provider) {
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.withValues(alpha: 0.1),
            Colors.cyan.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.teal.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.summarize,
                color: Colors.teal.shade600,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Product Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: DoubleConstants.spacingM),
          
          // Product basic info
          _buildSummaryRow('Product Name', provider.productNameController.text),
          _buildSummaryRow('Product Code', provider.productCodeController.text),
          _buildSummaryRow('Line Item', provider.selectedLineItem ?? ''),
          
          if (provider.selectedCategory != null)
            _buildSummaryRow('Category', provider.selectedCategory!),
          
          if (provider.selectedSupplier != null)
            _buildSummaryRow('Supplier', provider.selectedSupplier!),
          
          // Pricing info
          const Divider(height: 24),
          _buildSummaryRow(
            'Average Cost',
            '${provider.selectedCurrency ?? 'PKR'} ${provider.averageCostController.text}',
          ),
          
          if (provider.priceController.text.isNotEmpty)
            _buildSummaryRow(
              'Retail Price',
              '${provider.selectedCurrency ?? 'PKR'} ${provider.priceController.text}',
            ),
          
          // Profit calculations
          if (provider.priceController.text.isNotEmpty && 
              provider.averageCostController.text.isNotEmpty) ...[
            const SizedBox(height: DoubleConstants.spacingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetricChip(
                  'Margin: ${provider.profitMargin.toStringAsFixed(1)}%',
                  Colors.green,
                ),
                _buildMetricChip(
                  'Markup: ${provider.markupPercentage.toStringAsFixed(1)}%',
                  Colors.blue,
                ),
              ],
            ),
          ],
          
          // Variants info
          if (provider.selectedSizes.isNotEmpty || provider.selectedColors.isNotEmpty) ...[
            const Divider(height: 24),
            if (provider.selectedSizes.isNotEmpty)
              _buildSummaryRow('Sizes', provider.selectedSizes.join(', ')),
            if (provider.selectedColors.isNotEmpty)
              _buildSummaryRow('Colors', provider.selectedColors.join(', ')),
            if (provider.selectedSizes.isNotEmpty && provider.selectedColors.isNotEmpty)
              _buildSummaryRow(
                'Total Variants',
                '${provider.selectedSizes.length * provider.selectedColors.length}',
              ),
          ],
        ],
      ),
    );
  }

  /// Build summary row
  Widget _buildSummaryRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build metric chip
  Widget _buildMetricChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade700,
        ),
      ),
    );
  }
}