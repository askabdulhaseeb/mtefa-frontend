import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../components/dashboard_card.dart';

/// Reports and analytics section for dashboard
class ReportsSection extends StatelessWidget {
  const ReportsSection({
    required this.crossAxisCount,
    this.childAspectRatio = 1,
    this.useCompactCards = false,
    super.key,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final bool useCompactCards;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: DoubleConstants.spacingM,
      crossAxisSpacing: DoubleConstants.spacingM,
      children: _buildReportCards(context),
    );
  }

  List<Widget> _buildReportCards(BuildContext context) {
    final List<_ReportItem> reports = _getReportItems();
    
    if (useCompactCards) {
      return reports.map((item) => CompactDashboardCard(
        title: item.title,
        icon: item.icon,
        color: item.color,
        onTap: () => item.onTap(context),
      )).toList();
    }
    
    return reports.map((item) => DashboardCard(
      title: item.title,
      icon: item.icon,
      color: item.color,
      onTap: () => item.onTap(context),
    )).toList();
  }

  List<_ReportItem> _getReportItems() {
    return <_ReportItem>[
      _ReportItem(
        title: 'Sales Report',
        icon: Icons.analytics,
        color: Colors.blue,
        onTap: _handleSalesReport,
      ),
      _ReportItem(
        title: 'Inventory Report',
        icon: Icons.assessment,
        color: Colors.green,
        onTap: _handleInventoryReport,
      ),
      _ReportItem(
        title: 'Financial Report',
        icon: Icons.account_balance,
        color: Colors.purple,
        onTap: _handleFinancialReport,
      ),
      _ReportItem(
        title: 'Customer Analytics',
        icon: Icons.insights,
        color: Colors.orange,
        onTap: _handleCustomerAnalytics,
      ),
      if (!useCompactCards)
        _ReportItem(
          title: 'Export Data',
          icon: Icons.download,
          color: Colors.teal,
          onTap: _handleExportData,
        ),
    ];
  }

  void _handleSalesReport(BuildContext context) {
    debugPrint('Navigate to Sales Report');
    // TODO: Implement navigation
  }

  void _handleInventoryReport(BuildContext context) {
    debugPrint('Navigate to Inventory Report');
    // TODO: Implement navigation
  }

  void _handleFinancialReport(BuildContext context) {
    debugPrint('Navigate to Financial Report');
    // TODO: Implement navigation
  }

  void _handleCustomerAnalytics(BuildContext context) {
    debugPrint('Navigate to Customer Analytics');
    // TODO: Implement navigation
  }

  void _handleExportData(BuildContext context) {
    debugPrint('Export Data');
    // TODO: Implement export functionality
  }
}

/// Internal class for report items
class _ReportItem {
  const _ReportItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final void Function(BuildContext) onTap;
}