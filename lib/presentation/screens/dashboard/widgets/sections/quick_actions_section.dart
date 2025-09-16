import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../providers/dashboard_provider.dart';
import '../components/dashboard_card.dart';

/// Quick actions grid section for dashboard
class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({
    required this.provider,
    required this.crossAxisCount,
    this.childAspectRatio = 1,
    super.key,
  });

  final DashboardProvider provider;
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: DoubleConstants.spacingM,
      crossAxisSpacing: DoubleConstants.spacingM,
      children: _buildQuickActionCards(context),
    );
  }

  List<Widget> _buildQuickActionCards(BuildContext context) {
    return <Widget>[
      DashboardCard(
        title: 'New Sale',
        icon: Icons.point_of_sale,
        color: Colors.green,
        onTap: () => _handleNewSale(context),
      ),
      DashboardCard(
        title: 'Quick Sale',
        icon: Icons.flash_on,
        color: Colors.orange,
        onTap: () => _handleQuickSale(context),
      ),
      DashboardCard(
        title: 'Refund',
        icon: Icons.replay,
        color: Colors.red,
        onTap: () => _handleRefund(context),
      ),
      DashboardCard(
        title: 'Add Product',
        icon: Icons.add_box,
        color: Colors.blue,
        onTap: () => _handleAddProduct(context),
      ),
      DashboardCard(
        title: 'Stock In',
        icon: Icons.inventory_2,
        color: Colors.purple,
        badge: provider.lowStockItems > 0 ? '${provider.lowStockItems}' : null,
        onTap: () => _handleStockIn(context),
      ),
    ];
  }

  void _handleNewSale(BuildContext context) {
    debugPrint('Navigate to New Sale');
    // TODO: Implement navigation
  }

  void _handleQuickSale(BuildContext context) {
    debugPrint('Navigate to Quick Sale');
    // TODO: Implement navigation
  }

  void _handleRefund(BuildContext context) {
    debugPrint('Navigate to Refund');
    // TODO: Implement navigation
  }

  void _handleAddProduct(BuildContext context) {
    debugPrint('Navigate to Add Product');
    // TODO: Implement navigation
  }

  void _handleStockIn(BuildContext context) {
    debugPrint('Navigate to Stock In');
    // TODO: Implement navigation
  }
}