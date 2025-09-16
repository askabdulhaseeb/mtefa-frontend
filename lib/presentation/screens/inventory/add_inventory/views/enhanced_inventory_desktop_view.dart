import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../providers/comprehensive_inventory_provider.dart';
import '../widgets/form_progress_indicator.dart';
import '../widgets/sections/enhanced_required_fields_section.dart';
import '../widgets/sections/additional_section.dart';
import '../widgets/sections/basic_details_section.dart';
import '../widgets/sections/inventory_management_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/purchase_configuration_section.dart';
import '../widgets/sections/sizes_colors_section.dart';

/// Enhanced desktop view with modern Material 3 design
class EnhancedInventoryDesktopView extends StatefulWidget {
  const EnhancedInventoryDesktopView({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  State<EnhancedInventoryDesktopView> createState() => _EnhancedInventoryDesktopViewState();
}

class _EnhancedInventoryDesktopViewState extends State<EnhancedInventoryDesktopView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final bool shouldShow = _scrollController.offset > 100;
    if (shouldShow != _showFloatingHeader) {
      setState(() {
        _showFloatingHeader = shouldShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    if (widget.provider.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              color: colorScheme.primary,
              strokeWidth: 3,
            ),
            const SizedBox(height: 16),
            Text(
              'Preparing inventory form...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: <Widget>[
        // Main content
        Form(
          key: widget.provider.formKey,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              // Header section with gradient
              SliverToBoxAdapter(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        colorScheme.primaryContainer.withAlpha(50),
                        colorScheme.secondaryContainer.withAlpha(30),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Add New Product',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Fill in the product details to add it to your inventory',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Progress indicator
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
                      child: FormProgressIndicator(
                        sections: _getFormSections(),
                        completedSections: _getCompletedSections(),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Main form content
              SliverPadding(
                padding: const EdgeInsets.all(32),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Left Column - Primary Information
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: <Widget>[
                                // Enhanced Required Fields Section
                                const EnhancedRequiredFieldsSection(),
                                const SizedBox(height: DoubleConstants.spacingL),
                                
                                // Basic Details Section (to be enhanced)
                                BasicDetailsSection(),
                                const SizedBox(height: DoubleConstants.spacingL),
                                
                                // Sizes & Colors Section (to be enhanced)
                                SizesColorsSection(),
                              ],
                            ),
                          ),
                          const SizedBox(width: DoubleConstants.spacingXL),
                          
                          // Right Column - Secondary Information
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: <Widget>[
                                // Pricing Section (to be enhanced)
                                PricingSection(),
                                const SizedBox(height: DoubleConstants.spacingL),
                                
                                // Purchase Configuration Section (to be enhanced)
                                PurchaseConfigurationSection(),
                                const SizedBox(height: DoubleConstants.spacingL),
                                
                                // Inventory Management Section (to be enhanced)
                                InventoryManagementSection(),
                                const SizedBox(height: DoubleConstants.spacingL),
                                
                                // Additional Information Section (to be enhanced)
                                AdditionalSection(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Bottom action buttons
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      child: _buildActionButtons(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Floating header when scrolled
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: _showFloatingHeader ? 0 : -80,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colorScheme.shadow.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'New Product',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      _buildQuickActions(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Save as Draft button
        OutlinedButton.icon(
          onPressed: widget.provider.isSaving ? null : () {
            // TODO: Implement save as draft
          },
          icon: const Icon(Icons.save_alt),
          label: const Text('Save as Draft'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Save and Continue button
        FilledButton.icon(
          onPressed: widget.provider.isSaving ? null : () => _saveAndContinue(context),
          icon: widget.provider.isSaving
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                  ),
                )
              : const Icon(Icons.check),
          label: Text(widget.provider.isSaving ? 'Saving...' : 'Save & Continue'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Save and Close button
        FilledButton.icon(
          onPressed: widget.provider.isSaving ? null : () => _saveAndClose(context),
          icon: const Icon(Icons.save),
          label: const Text('Save & Close'),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            // TODO: Implement duplicate
          },
          icon: const Icon(Icons.copy),
          tooltip: 'Duplicate',
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement reset
          },
          icon: const Icon(Icons.refresh),
          tooltip: 'Reset Form',
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement help
          },
          icon: const Icon(Icons.help_outline),
          tooltip: 'Help',
        ),
      ],
    );
  }

  List<FormSection> _getFormSections() {
    return const <FormSection>[
      FormSection(id: 'required', title: 'Required', icon: Icons.star),
      FormSection(id: 'basic', title: 'Basic', icon: Icons.info),
      FormSection(id: 'pricing', title: 'Pricing', icon: Icons.attach_money),
      FormSection(id: 'sizes', title: 'Variants', icon: Icons.palette),
      FormSection(id: 'purchase', title: 'Purchase', icon: Icons.shopping_cart),
      FormSection(id: 'inventory', title: 'Stock', icon: Icons.inventory),
      FormSection(id: 'additional', title: 'Additional', icon: Icons.more_horiz),
    ];
  }

  Set<String> _getCompletedSections() {
    final Set<String> completed = <String>{};
    final ComprehensiveInventoryProvider provider = widget.provider;
    
    // Check required section
    if (provider.selectedLineItem != null &&
        provider.productNameController.text.isNotEmpty &&
        provider.averageCostController.text.isNotEmpty &&
        (provider.autoGenerateCode || provider.productCodeController.text.isNotEmpty)) {
      completed.add('required');
    }
    
    // Check basic section
    if (provider.selectedCategory != null) {
      completed.add('basic');
    }
    
    // Check pricing section
    if (provider.priceController.text.isNotEmpty) {
      completed.add('pricing');
    }
    
    // Add more section checks as needed
    
    return completed;
  }

  Future<void> _saveAndContinue(BuildContext context) async {
    final bool success = await widget.provider.saveInventory();
    
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: <Widget>[
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Product saved successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Clear form for next product
      widget.provider.clearForm();
    }
  }

  Future<void> _saveAndClose(BuildContext context) async {
    final bool success = await widget.provider.saveInventory();
    
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: <Widget>[
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Product saved successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Navigate back
      Navigator.of(context).pop();
    }
  }
}