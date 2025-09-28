import 'package:flutter/material.dart';

import '../providers/comprehensive_inventory_provider.dart';
import '../widgets/form_progress_indicator.dart';
import '../widgets/sections/enhanced_required_fields_section.dart';
import '../widgets/sections/additional_section.dart';
import '../widgets/sections/basic_details_section.dart';
import '../widgets/sections/inventory_management_section.dart';
import '../widgets/sections/pricing_section.dart';
import '../widgets/sections/purchase_configuration_section.dart';
import '../widgets/sections/sizes_colors_section.dart';
import 'components/action_buttons.dart';
import 'components/floating_header.dart';
import 'components/form_layout.dart';
import 'components/inventory_header.dart';
import 'components/loading_state.dart';
import 'components/success_message.dart';

/// Enhanced desktop view with modern Material 3 design and component-based architecture
/// 
/// This view has been refactored from a 451-line monolithic implementation into
/// focused, reusable components following clean architecture principles.
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
    if (widget.provider.isLoading) {
      return const LoadingState();
    }

    return Stack(
      children: <Widget>[
        _buildMainContent(),
        _buildFloatingHeader(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Form(
      key: widget.provider.formKey,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // Header section with gradient
          const SliverToBoxAdapter(
            child: InventoryHeader(),
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
              child: FormLayout(
                leftColumnChildren: _getLeftColumnSections(),
                rightColumnChildren: _getRightColumnSections(),
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
                  child: ActionButtons(
                    isSaving: widget.provider.isSaving,
                    onSaveDraft: _handleSaveDraft,
                    onSaveAndContinue: () => _saveAndContinue(context),
                    onSaveAndClose: () => _saveAndClose(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingHeader() {
    return FloatingHeader(
      isVisible: _showFloatingHeader,
      onDuplicate: _handleDuplicate,
      onReset: _handleReset,
      onHelp: _handleHelp,
    );
  }

  List<Widget> _getLeftColumnSections() {
    return <Widget>[
      const EnhancedRequiredFieldsSection(),
      BasicDetailsSection(),
      SizesColorsSection(),
    ];
  }

  List<Widget> _getRightColumnSections() {
    return <Widget>[
      PricingSection(),
      PurchaseConfigurationSection(),
      InventoryManagementSection(),
      AdditionalSection(),
    ];
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

  // Action handlers
  void _handleSaveDraft() {
    // TODO: Implement save as draft functionality
    debugPrint('Save as draft functionality to be implemented');
  }

  void _handleDuplicate() {
    // TODO: Implement duplicate functionality
    debugPrint('Duplicate functionality to be implemented');
  }

  void _handleReset() {
    // TODO: Implement reset form functionality
    widget.provider.clearForm();
  }

  void _handleHelp() {
    // TODO: Implement help functionality
    debugPrint('Help functionality to be implemented');
  }

  Future<void> _saveAndContinue(BuildContext context) async {
    final bool success = await widget.provider.saveInventory();
    
    if (success && context.mounted) {
      SuccessMessage.show(context);
      // Clear form for next product
      widget.provider.clearForm();
    }
  }

  Future<void> _saveAndClose(BuildContext context) async {
    final bool success = await widget.provider.saveInventory();
    
    if (success && context.mounted) {
      SuccessMessage.show(context);
      // Navigate back
      Navigator.of(context).pop();
    }
  }
}