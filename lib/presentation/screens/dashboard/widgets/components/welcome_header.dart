import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/utils/greeting_utils.dart';

/// Reusable welcome header component for dashboard
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    this.isCompact = false,
    this.onRefresh,
    super.key,
  });

  /// Compact mode for mobile devices
  final bool isCompact;
  
  /// Optional refresh callback
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String greeting = GreetingUtils.getGreeting();

    if (isCompact) {
      return _buildCompactHeader(context, theme, greeting);
    }

    return _buildFullHeader(context, theme, greeting);
  }

  Widget _buildFullHeader(
    BuildContext context,
    ThemeData theme,
    String greeting,
  ) {
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            theme.primaryColor,
            theme.primaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(DoubleConstants.radiusL),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  greeting,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome to MTEFA POS Dashboard',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.dashboard,
              color: Colors.white,
              size: isCompact ? 32 : 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactHeader(
    BuildContext context,
    ThemeData theme,
    String greeting,
  ) {
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            theme.primaryColor,
            theme.primaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  greeting,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'MTEFA POS Dashboard',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (onRefresh != null)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: onRefresh,
              tooltip: 'Refresh Dashboard',
            ),
        ],
      ),
    );
  }
}