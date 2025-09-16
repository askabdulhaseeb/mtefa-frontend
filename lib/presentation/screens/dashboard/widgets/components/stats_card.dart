import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/numbers.dart';

/// Widget for displaying statistics on the dashboard
class StatsCard extends StatelessWidget {
  const StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
    this.subtitle,
    this.color,
    this.trend,
    this.trendPercentage,
    this.isCurrency = false,
    this.onTap,
  });

  final String title;
  final dynamic value;
  final String? subtitle;
  final IconData icon;
  final Color? color;
  final TrendDirection? trend;
  final double? trendPercentage;
  final bool isCurrency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
        child: Container(
          padding: const EdgeInsets.all(DoubleConstants.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Icon container
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: cardColor,
                      size: 24,
                    ),
                  ),
                  // Trend indicator
                  if (trend != null && trendPercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getTrendColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            _getTrendIcon(),
                            size: 12,
                            color: _getTrendColor(),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${trendPercentage!.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: _getTrendColor(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: DoubleConstants.spacingM),
              // Title
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Value
              Text(
                _formatValue(value),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.headlineSmall?.color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Subtitle if present
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (isCurrency && value is num) {
      final NumberFormat formatter = NumberFormat.currency(
        symbol: '\$',
        decimalDigits: value % 1 == 0 ? 0 : 2,
      );
      return formatter.format(value);
    } else if (value is num) {
      final NumberFormat formatter = NumberFormat.compact();
      return formatter.format(value);
    }
    return value.toString();
  }

  IconData _getTrendIcon() {
    switch (trend) {
      case TrendDirection.up:
        return Icons.trending_up;
      case TrendDirection.down:
        return Icons.trending_down;
      case TrendDirection.neutral:
      case null:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor() {
    switch (trend) {
      case TrendDirection.up:
        return Colors.green;
      case TrendDirection.down:
        return Colors.red;
      case TrendDirection.neutral:
      case null:
        return Colors.grey;
    }
  }
}

/// Mini stats card for compact display
class MiniStatsCard extends StatelessWidget {
  const MiniStatsCard({
    required this.title,
    required this.value,
    super.key,
    this.icon,
    this.color,
    this.isCurrency = false,
  });

  final String title;
  final dynamic value;
  final IconData? icon;
  final Color? color;
  final bool isCurrency;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;
    
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingS),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _formatValue(value),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (icon != null)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: cardColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: cardColor,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (isCurrency && value is num) {
      final NumberFormat formatter = NumberFormat.currency(
        symbol: '\$',
        decimalDigits: value % 1 == 0 ? 0 : 2,
      );
      return formatter.format(value);
    } else if (value is num) {
      final NumberFormat formatter = NumberFormat.compact();
      return formatter.format(value);
    }
    return value.toString();
  }
}

enum TrendDirection {
  up,
  down,
  neutral,
}