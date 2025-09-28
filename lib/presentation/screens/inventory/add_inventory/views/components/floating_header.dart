import 'package:flutter/material.dart';

import 'quick_actions.dart';

/// Floating header that appears when scrolling down
class FloatingHeader extends StatelessWidget {
  const FloatingHeader({
    required this.isVisible,
    super.key,
    this.title = 'New Product',
    this.height = 80,
    this.onDuplicate,
    this.onReset,
    this.onHelp,
  });

  final bool isVisible;
  final String title;
  final double height;
  final VoidCallback? onDuplicate;
  final VoidCallback? onReset;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: isVisible ? 0 : -height,
      left: 0,
      right: 0,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  QuickActions(
                    onDuplicate: onDuplicate,
                    onReset: onReset,
                    onHelp: onHelp,
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