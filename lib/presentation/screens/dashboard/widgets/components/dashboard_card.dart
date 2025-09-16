import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';

/// Reusable dashboard card widget for displaying POS functions
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
    this.subtitle,
    this.color,
    this.iconColor,
    this.badge,
    this.isLoading = false,
    this.isDisabled = false,
    this.height,
    this.width,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final String? badge;
  final bool isLoading;
  final bool isDisabled;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;
    final Color cardIconColor = iconColor ?? Colors.white;

    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: isDisabled ? 1 : 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
        ),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
          child: Opacity(
            opacity: isDisabled ? 0.5 : 1.0,
            child: Container(
              padding: const EdgeInsets.all(DoubleConstants.spacingM),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    cardColor,
                    cardColor.withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  // Badge if present
                  if (badge != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Main content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(cardIconColor),
                                ),
                              )
                            : Icon(
                                icon,
                                size: 32,
                                color: cardIconColor,
                              ),
                      ),
                      const SizedBox(height: DoubleConstants.spacingS),
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          color: cardIconColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Subtitle if present
                      if (subtitle != null) ...<Widget>[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: cardIconColor.withValues(alpha: 0.9),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact version of dashboard card for smaller displays
class CompactDashboardCard extends StatelessWidget {
  const CompactDashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
    this.color,
    this.iconColor,
    this.badge,
    this.isDisabled = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final String? badge;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = color ?? theme.primaryColor;
    final Color cardIconColor = iconColor ?? Colors.white;

    return Card(
      elevation: isDisabled ? 1 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
      ),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
        child: Opacity(
          opacity: isDisabled ? 0.5 : 1.0,
          child: Container(
            padding: const EdgeInsets.all(DoubleConstants.spacingS),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DoubleConstants.radiusS),
              color: cardColor,
            ),
            child: Stack(
              children: <Widget>[
                // Badge
                if (badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                // Content
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 24,
                      color: cardIconColor,
                    ),
                    const SizedBox(width: DoubleConstants.spacingS),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: cardIconColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}