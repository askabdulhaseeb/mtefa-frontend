import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';
import 'signup_button.dart';

/// Reusable footer component for authentication forms
/// Displays copyright text and signup option for testing
class LoginFormFooter extends StatelessWidget {
  const LoginFormFooter({
    this.text = '© 2024 MTEFA POS. All rights reserved.',
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Column(
      children: <Widget>[
        // Signup button for testing
        const SignupButton(),
        const SizedBox(height: DoubleConstants.spacingS),
        
        // Copyright text
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}