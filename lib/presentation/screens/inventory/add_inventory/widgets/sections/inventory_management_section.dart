import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../providers/comprehensive_inventory_provider.dart';
import '../add_inventory_section_bg_widget.dart';

/// Inventory Management section for stock level configuration
class InventoryManagementSection extends StatelessWidget {
  const InventoryManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComprehensiveInventoryProvider>(
      builder: (BuildContext context, ComprehensiveInventoryProvider provider, Widget? child) {
        return AddInventorySectionBgWidget(
          icon: Icons.inventory_2,
          title: 'Inventory Management',
          child: Column(
            children: <Widget>[
              // Minimum Level - Reorder point
              CustomTextFormField(
                controller: provider.minimumLevelController,
                labelText: 'Minimum Level',
                hint: 'Enter minimum stock level (reorder point)',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final int? minLevel = int.tryParse(value!);
                    if (minLevel == null || minLevel < 0) {
                      return 'Enter a valid minimum level';
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Optimal Level - Target stock level
              CustomTextFormField(
                controller: provider.optimalLevelController,
                labelText: 'Optimal Level',
                hint: 'Enter optimal stock level (target)',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final int? optimalLevel = int.tryParse(value!);
                    if (optimalLevel == null || optimalLevel < 0) {
                      return 'Enter a valid optimal level';
                    }
                    
                    // Check if optimal level is greater than minimum level
                    if (provider.minimumLevelController.text.isNotEmpty) {
                      final int? minLevel = int.tryParse(provider.minimumLevelController.text);
                      if (minLevel != null && optimalLevel < minLevel) {
                        return 'Optimal level should be greater than minimum level';
                      }
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: DoubleConstants.spacingM),

              // Maximum Level - Maximum stock limit
              CustomTextFormField(
                controller: provider.maximumLevelController,
                labelText: 'Maximum Level',
                hint: 'Enter maximum stock level (limit)',
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.isNotEmpty == true) {
                    final int? maxLevel = int.tryParse(value!);
                    if (maxLevel == null || maxLevel < 0) {
                      return 'Enter a valid maximum level';
                    }
                    
                    // Check if maximum level is greater than optimal level
                    if (provider.optimalLevelController.text.isNotEmpty) {
                      final int? optimalLevel = int.tryParse(provider.optimalLevelController.text);
                      if (optimalLevel != null && maxLevel < optimalLevel) {
                        return 'Maximum level should be greater than optimal level';
                      }
                    }
                    
                    // Check if maximum level is greater than minimum level
                    if (provider.minimumLevelController.text.isNotEmpty) {
                      final int? minLevel = int.tryParse(provider.minimumLevelController.text);
                      if (minLevel != null && maxLevel < minLevel) {
                        return 'Maximum level should be greater than minimum level';
                      }
                    }
                  }
                  return null;
                },
              ),

              // Show stock level visualization if values are entered
              if (_shouldShowVisualization(provider)) ...<Widget>[
                const SizedBox(height: DoubleConstants.spacingM),
                _buildStockLevelVisualization(provider),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Check if stock level visualization should be shown
  bool _shouldShowVisualization(ComprehensiveInventoryProvider provider) {
    return provider.minimumLevelController.text.isNotEmpty ||
           provider.optimalLevelController.text.isNotEmpty ||
           provider.maximumLevelController.text.isNotEmpty;
  }

  /// Build stock level visualization widget
  Widget _buildStockLevelVisualization(ComprehensiveInventoryProvider provider) {
    final int minLevel = int.tryParse(provider.minimumLevelController.text) ?? 0;
    final int optimalLevel = int.tryParse(provider.optimalLevelController.text) ?? 0;
    final int maxLevel = int.tryParse(provider.maximumLevelController.text) ?? 100;

    // Ensure we have valid levels for visualization
    final int displayMaxLevel = maxLevel > 0 ? maxLevel : 100;
    
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.blue.withValues(alpha: 0.1),
            Colors.green.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Stock Level Visualization',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: DoubleConstants.spacingM),
          
          // Stock level bar
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: <Widget>[
                // Background bar
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                
                // Minimum level indicator
                if (minLevel > 0)
                  Positioned(
                    left: (minLevel / displayMaxLevel) * 250, // Assuming 250px width
                    top: 0,
                    child: Container(
                      width: 2,
                      height: 40,
                      color: Colors.red,
                    ),
                  ),
                
                // Optimal level indicator
                if (optimalLevel > 0)
                  Positioned(
                    left: (optimalLevel / displayMaxLevel) * 250,
                    top: 0,
                    child: Container(
                      width: 2,
                      height: 40,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: DoubleConstants.spacingS),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (minLevel > 0)
                _buildLevelIndicator(
                  'Min: $minLevel',
                  Colors.red,
                  'Reorder Point',
                ),
              if (optimalLevel > 0)
                _buildLevelIndicator(
                  'Optimal: $optimalLevel',
                  Colors.green,
                  'Target Level',
                ),
              if (maxLevel > 0)
                _buildLevelIndicator(
                  'Max: $maxLevel',
                  Colors.blue,
                  'Maximum Limit',
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build level indicator for legend
  Widget _buildLevelIndicator(String title, Color color, String subtitle) {
    return Column(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}