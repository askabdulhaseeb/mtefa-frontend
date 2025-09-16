import 'package:flutter/material.dart';

/// Reusable footer component for authentication forms
/// Displays copyright text with consistent styling
class LoginFormFooter extends StatelessWidget {
  const LoginFormFooter({
    this.text = '© 2024 MTEFA POS. All rights reserved.',
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
      textAlign: TextAlign.center,
    );
  }
}