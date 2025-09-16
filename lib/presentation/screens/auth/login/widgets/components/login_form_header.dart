import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';

/// Reusable header component for authentication forms
/// Displays title and subtitle text with consistent styling
class LoginFormHeader extends StatelessWidget {
  const LoginFormHeader({
    this.title = 'Sign In',
    this.subtitle = 'Enter your credentials to access your account',
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}