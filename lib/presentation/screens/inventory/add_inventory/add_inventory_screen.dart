import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/core/my_scaffold.dart';
import '../../../widgets/core/responsive_widget.dart';
import 'providers/add_inventory_provider.dart';
import 'views/add_inventory_desktop_view.dart';
import 'views/add_inventory_mobile_view.dart';
import 'views/add_inventory_tablet_view.dart';

/// Add Inventory Screen with responsive design
class AddInventoryScreen extends StatelessWidget {
  const AddInventoryScreen({super.key});

  static const String routeName = '/add-inventory';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddInventoryProvider>(
      create: (_) => AddInventoryProvider(),
      child: const _AddInventoryContent(),
    );
  }
}

/// Inner content that has access to the provider
class _AddInventoryContent extends StatelessWidget {
  const _AddInventoryContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddInventoryProvider>(
      builder: (BuildContext context, AddInventoryProvider provider, Widget? child) {
        return MyScaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: true,
          safeArea: false,
          appBar: _buildAppBar(context, provider),
          body: ResponsiveWidget(
            mobile: AddInventoryMobileView(provider: provider),
            tablet: AddInventoryTabletView(provider: provider),
            desktop: AddInventoryDesktopView(provider: provider),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AddInventoryProvider provider) {
    final ThemeData theme = Theme.of(context);
    
    return AppBar(
      title: const Text('Add New Inventory'),
      backgroundColor: theme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Check if form has unsaved changes
          if (_hasUnsavedChanges(provider)) {
            _showExitConfirmation(context, provider);
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      actions: <Widget>[
        // Clear form button
        TextButton.icon(
          icon: const Icon(Icons.clear_all, color: Colors.white),
          label: const Text('Clear', style: TextStyle(color: Colors.white)),
          onPressed: provider.isSaving ? null : () {
            _showClearConfirmation(context, provider);
          },
        ),
        const SizedBox(width: 8),
        // Save button
        ElevatedButton.icon(
          icon: provider.isSaving 
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.save),
          label: Text(provider.isSaving ? 'Saving...' : 'Save Inventory'),
          style: ElevatedButton.styleFrom(
            foregroundColor: theme.primaryColor,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          onPressed: provider.isSaving ? null : () => _saveInventory(context, provider),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  /// Check if form has unsaved changes
  bool _hasUnsavedChanges(AddInventoryProvider provider) {
    return provider.nameController.text.isNotEmpty ||
           provider.descriptionController.text.isNotEmpty ||
           provider.costPriceController.text.isNotEmpty ||
           provider.sellingPriceController.text.isNotEmpty ||
           provider.stockQuantityController.text.isNotEmpty ||
           provider.minimumStockController.text.isNotEmpty ||
           provider.selectedCategory != null ||
           provider.selectedBrand != null;
  }

  /// Show exit confirmation dialog
  void _showExitConfirmation(BuildContext context, AddInventoryProvider provider) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unsaved Changes'),
          content: const Text('You have unsaved changes. Are you sure you want to leave?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Leave'),
            ),
          ],
        );
      },
    );
  }

  /// Show clear form confirmation dialog
  void _showClearConfirmation(BuildContext context, AddInventoryProvider provider) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Form'),
          content: const Text('Are you sure you want to clear all form data?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.clearForm();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  /// Save inventory
  Future<void> _saveInventory(BuildContext context, AddInventoryProvider provider) async {
    final bool success = await provider.saveInventory();
    
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inventory saved successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      
      // Navigate back or stay based on requirements
      Navigator.of(context).pop();
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save inventory. Please check all required fields.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}