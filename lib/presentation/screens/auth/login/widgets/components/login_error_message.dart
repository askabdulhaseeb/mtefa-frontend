import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';

/// Reusable error message component for forms
/// Displays error text with consistent styling and icon
class LoginErrorMessage extends StatelessWidget {
  const LoginErrorMessage({
    required this.errorMessage,
    super.key,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      margin: const EdgeInsets.only(bottom: DoubleConstants.spacingM),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 20),
          const SizedBox(width: DoubleConstants.spacingS),
          Expanded(
            child: Text(
              errorMessage,
              style: TextStyle(color: theme.colorScheme.error, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}