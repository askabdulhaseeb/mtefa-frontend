import 'package:flutter/material.dart';

/// Reusable section header component for dashboard sections
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.subtitle,
    this.action,
    this.isCompact = false,
    super.key,
  });

  /// Section title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Optional action widget (e.g., "View All" button)
  final Widget? action;

  /// Compact mode for mobile
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (isCompact) {
      return _buildCompactHeader(context, theme);
    }

    return _buildFullHeader(context, theme);
  }

  Widget _buildFullHeader(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }

  Widget _buildCompactHeader(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}