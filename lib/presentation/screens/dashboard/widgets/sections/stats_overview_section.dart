import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../providers/dashboard_provider.dart';
import '../components/stats_card.dart';

/// Statistics overview section for dashboard
class StatsOverviewSection extends StatelessWidget {
  const StatsOverviewSection({
    required this.provider,
    required this.crossAxisCount,
    this.childAspectRatio = 1.5,
    this.isScrollable = false,
    super.key,
  });

  final DashboardProvider provider;
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    if (isScrollable) {
      return _buildScrollableStats(context);
    }
    
    return _buildGridStats(context);
  }

  Widget _buildGridStats(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: DoubleConstants.spacingM,
      crossAxisSpacing: DoubleConstants.spacingM,
      children: _buildStatCards(context),
    );
  }

  Widget _buildScrollableStats(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildCompactStatCards(context),
      ),
    );
  }

  List<Widget> _buildStatCards(BuildContext context) {
    return <Widget>[
      StatsCard(
        title: "Today's Sales",
        value: provider.todaySales,
        icon: Icons.attach_money,
        color: Colors.green,
        trend: TrendDirection.up,
        trendPercentage: 12.5,
        isCurrency: true,
        subtitle: 'vs yesterday',
        onTap: () => _handleSalesNavigation(context),
      ),
      StatsCard(
        title: "Month's Revenue",
        value: provider.monthSales,
        icon: Icons.trending_up,
        color: Colors.blue,
        trend: TrendDirection.up,
        trendPercentage: 8.3,
        isCurrency: true,
        subtitle: 'vs last month',
        onTap: () => _handleReportsNavigation(context),
      ),
      StatsCard(
        title: 'Transactions',
        value: provider.todayTransactions,
        icon: Icons.receipt,
        color: Colors.orange,
        trend: TrendDirection.neutral,
        trendPercentage: 0.0,
        subtitle: 'Today',
        onTap: () => _handleTransactionsNavigation(context),
      ),
      StatsCard(
        title: 'Pending Orders',
        value: provider.pendingOrders,
        icon: Icons.pending_actions,
        color: Colors.red,
        subtitle: 'Requires action',
        onTap: () => _handlePendingOrdersNavigation(context),
      ),
    ];
  }

  List<Widget> _buildCompactStatCards(BuildContext context) {
    return <Widget>[
      _buildCompactStatCard(
        context,
        title: "Today's Sales",
        value: '\$${provider.todaySales.toStringAsFixed(0)}',
        icon: Icons.attach_money,
        color: Colors.green,
      ),
      _buildCompactStatCard(
        context,
        title: 'Transactions',
        value: '${provider.todayTransactions}',
        icon: Icons.receipt,
        color: Colors.blue,
      ),
      _buildCompactStatCard(
        context,
        title: 'Pending',
        value: '${provider.pendingOrders}',
        icon: Icons.pending_actions,
        color: Colors.orange,
      ),
      _buildCompactStatCard(
        context,
        title: 'Low Stock',
        value: '${provider.lowStockItems}',
        icon: Icons.warning,
        color: Colors.red,
      ),
    ];
  }

  Widget _buildCompactStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: DoubleConstants.spacingS),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
        ),
        child: InkWell(
          onTap: () => _handleStatCardTap(context, title),
          borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
          child: Container(
            padding: const EdgeInsets.all(DoubleConstants.spacingS),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  color,
                  color.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(icon, color: Colors.white, size: 20),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleStatCardTap(BuildContext context, String title) {
    switch (title) {
      case "Today's Sales":
        _handleSalesNavigation(context);
      case 'Transactions':
        _handleTransactionsNavigation(context);
      case 'Pending':
        _handlePendingOrdersNavigation(context);
      case 'Low Stock':
        _handleInventoryNavigation(context);
    }
  }

  void _handleSalesNavigation(BuildContext context) {
    debugPrint('Navigate to Sales');
    // TODO: Implement navigation
  }

  void _handleReportsNavigation(BuildContext context) {
    debugPrint('Navigate to Reports');
    // TODO: Implement navigation
  }

  void _handleTransactionsNavigation(BuildContext context) {
    debugPrint('Navigate to Transactions');
    // TODO: Implement navigation
  }

  void _handlePendingOrdersNavigation(BuildContext context) {
    debugPrint('Navigate to Pending Orders');
    // TODO: Implement navigation
  }

  void _handleInventoryNavigation(BuildContext context) {
    debugPrint('Navigate to Inventory');
    // TODO: Implement navigation
  }
}