import 'package:flutter/material.dart';

import '../../providers/comprehensive_inventory_provider.dart';

/// Profit analysis visualization widget
class ProfitVisualization extends StatelessWidget {
  const ProfitVisualization({
    required this.provider,
    super.key,
  });

  final ComprehensiveInventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.green.withAlpha(10),
            Colors.blue.withAlpha(10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(theme, colorScheme),
          const SizedBox(height: 12),
          _buildMetrics(provider),
          const SizedBox(height: 12),
          _buildHealthIndicator(provider),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: <Widget>[
        Icon(Icons.insights, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          'Profit Analysis',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildMetrics(ComprehensiveInventoryProvider provider) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _MetricCard(
            title: 'Profit Margin',
            value: '${provider.profitMargin.toStringAsFixed(1)}%',
            color: Colors.green,
            icon: Icons.trending_up,
            isHighlighted: provider.profitMargin > 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            title: 'Markup',
            value: '${provider.markupPercentage.toStringAsFixed(1)}%',
            color: Colors.blue,
            icon: Icons.percent,
            isHighlighted: provider.markupPercentage > 40,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthIndicator(ComprehensiveInventoryProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getProfitHealthColor(provider.profitMargin).withAlpha(20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            _getProfitHealthIcon(provider.profitMargin),
            size: 16,
            color: _getProfitHealthColor(provider.profitMargin),
          ),
          const SizedBox(width: 8),
          Text(
            _getProfitHealthText(provider.profitMargin),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _getProfitHealthColor(provider.profitMargin),
            ),
          ),
        ],
      ),
    );
  }

  Color _getProfitHealthColor(double margin) {
    if (margin >= 30) return Colors.green;
    if (margin >= 20) return Colors.blue;
    if (margin >= 10) return Colors.orange;
    return Colors.red;
  }

  IconData _getProfitHealthIcon(double margin) {
    if (margin >= 30) return Icons.sentiment_very_satisfied;
    if (margin >= 20) return Icons.sentiment_satisfied;
    if (margin >= 10) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  String _getProfitHealthText(double margin) {
    if (margin >= 30) return 'Excellent profit margin';
    if (margin >= 20) return 'Good profit margin';
    if (margin >= 10) return 'Fair profit margin';
    return 'Low profit margin - consider adjusting price';
  }
}

/// Individual metric card widget
class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.isHighlighted,
  });

  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(isHighlighted ? 30 : 15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(isHighlighted ? 100 : 50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: color.withAlpha(200),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}