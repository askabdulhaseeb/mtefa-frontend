import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../providers/dashboard_provider.dart';
import '../components/dashboard_card.dart';

/// Management functions grid/list section for dashboard
class ManagementSection extends StatelessWidget {
  const ManagementSection({
    required this.provider,
    this.crossAxisCount,
    this.childAspectRatio = 1,
    this.isListView = false,
    super.key,
  });

  final DashboardProvider provider;
  final int? crossAxisCount;
  final double childAspectRatio;
  final bool isListView;

  @override
  Widget build(BuildContext context) {
    if (isListView) {
      return _buildListView(context);
    }
    
    return _buildGridView(context);
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount ?? 5,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: DoubleConstants.spacingM,
      crossAxisSpacing: DoubleConstants.spacingM,
      children: _buildManagementCards(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    final List<_ManagementItem> items = _getManagementItems();
    
    return Column(
      children: items.map((item) => _buildListTile(context, item)).toList(),
    );
  }

  Widget _buildListTile(BuildContext context, _ManagementItem item) {
    final ThemeData theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: DoubleConstants.spacingS),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            item.icon,
            color: item.color,
            size: 24,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: theme.hintColor,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => item.onTap(context),
      ),
    );
  }

  List<Widget> _buildManagementCards(BuildContext context) {
    final List<_ManagementItem> items = _getManagementItems();
    
    return items.map((item) => DashboardCard(
      title: item.title,
      icon: item.icon,
      color: item.color,
      subtitle: item.showSubtitle ? item.subtitle : null,
      badge: item.badge,
      onTap: () => item.onTap(context),
    )).toList();
  }

  List<_ManagementItem> _getManagementItems() {
    return <_ManagementItem>[
      _ManagementItem(
        title: 'Products',
        subtitle: '${provider.activeProducts} items',
        icon: Icons.shopping_bag,
        color: Colors.teal,
        showSubtitle: !isListView,
        onTap: _handleProducts,
      ),
      _ManagementItem(
        title: 'Inventory',
        subtitle: provider.lowStockItems > 0
            ? '${provider.lowStockItems} low stock'
            : 'All good',
        icon: Icons.inventory,
        color: Colors.indigo,
        badge: provider.lowStockItems > 0 ? '!' : null,
        onTap: _handleInventory,
      ),
      _ManagementItem(
        title: 'Customers',
        subtitle: '${provider.totalCustomers} registered',
        icon: Icons.people,
        color: Colors.cyan,
        showSubtitle: !isListView,
        onTap: _handleCustomers,
      ),
      _ManagementItem(
        title: 'Suppliers',
        subtitle: 'Manage suppliers',
        icon: Icons.local_shipping,
        color: Colors.brown,
        onTap: _handleSuppliers,
      ),
      _ManagementItem(
        title: 'Employees',
        subtitle: 'Staff management',
        icon: Icons.badge,
        color: Colors.deepPurple,
        onTap: _handleEmployees,
      ),
      if (!isListView) ...<_ManagementItem>[
        _ManagementItem(
          title: 'Brands',
          subtitle: 'Brand management',
          icon: Icons.branding_watermark,
          color: Colors.pink,
          onTap: _handleBrands,
        ),
        _ManagementItem(
          title: 'Categories',
          subtitle: 'Product categories',
          icon: Icons.category,
          color: Colors.amber,
          onTap: _handleCategories,
        ),
        _ManagementItem(
          title: 'Promotions',
          subtitle: 'Active offers',
          icon: Icons.local_offer,
          color: Colors.deepOrange,
          onTap: _handlePromotions,
        ),
        _ManagementItem(
          title: 'Payments',
          subtitle: 'Payment methods',
          icon: Icons.payment,
          color: Colors.green,
          onTap: _handlePayments,
        ),
        _ManagementItem(
          title: 'Settings',
          subtitle: 'App settings',
          icon: Icons.settings,
          color: Colors.blueGrey,
          onTap: _handleSettings,
        ),
      ] else ...<_ManagementItem>[
        _ManagementItem(
          title: 'Categories',
          subtitle: 'Product categories',
          icon: Icons.category,
          color: Colors.amber,
          onTap: _handleCategories,
        ),
        _ManagementItem(
          title: 'Promotions',
          subtitle: 'Active offers',
          icon: Icons.local_offer,
          color: Colors.deepOrange,
          onTap: _handlePromotions,
        ),
      ],
    ];
  }

  void _handleProducts(BuildContext context) {
    debugPrint('Navigate to Products');
    // TODO: Implement navigation
  }

  void _handleInventory(BuildContext context) {
    debugPrint('Navigate to Inventory');
    // TODO: Implement navigation
  }

  void _handleCustomers(BuildContext context) {
    debugPrint('Navigate to Customers');
    // TODO: Implement navigation
  }

  void _handleSuppliers(BuildContext context) {
    debugPrint('Navigate to Suppliers');
    // TODO: Implement navigation
  }

  void _handleEmployees(BuildContext context) {
    debugPrint('Navigate to Employees');
    // TODO: Implement navigation
  }

  void _handleBrands(BuildContext context) {
    debugPrint('Navigate to Brands');
    // TODO: Implement navigation
  }

  void _handleCategories(BuildContext context) {
    debugPrint('Navigate to Categories');
    // TODO: Implement navigation
  }

  void _handlePromotions(BuildContext context) {
    debugPrint('Navigate to Promotions');
    // TODO: Implement navigation
  }

  void _handlePayments(BuildContext context) {
    debugPrint('Navigate to Payments');
    // TODO: Implement navigation
  }

  void _handleSettings(BuildContext context) {
    debugPrint('Navigate to Settings');
    // TODO: Implement navigation
  }
}

/// Internal class for management items
class _ManagementItem {
  const _ManagementItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge,
    this.showSubtitle = true,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? badge;
  final bool showSubtitle;
  final void Function(BuildContext) onTap;
}