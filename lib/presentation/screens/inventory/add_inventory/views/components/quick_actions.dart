import 'package:flutter/material.dart';

/// Quick action buttons for duplicate, reset, and help functionality
class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    this.onDuplicate,
    this.onReset,
    this.onHelp,
  });

  final VoidCallback? onDuplicate;
  final VoidCallback? onReset;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: onDuplicate,
          icon: const Icon(Icons.copy),
          tooltip: 'Duplicate',
        ),
        IconButton(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          tooltip: 'Reset Form',
        ),
        IconButton(
          onPressed: onHelp,
          icon: const Icon(Icons.help_outline),
          tooltip: 'Help',
        ),
      ],
    );
  }
}