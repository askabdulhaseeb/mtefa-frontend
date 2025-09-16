import 'package:flutter/material.dart';

import '../../../../../widgets/popups/signup_popup.dart';

/// Reusable signup button component for auth screens
/// Shows signup popup when pressed
class SignupButton extends StatelessWidget {
  const SignupButton({
    this.text = 'Create test account',
    this.fontSize,
    super.key,
  });

  final String text;
  final double? fontSize;

  void _showSignupPopup(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const SignupPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return TextButton(
      onPressed: () => _showSignupPopup(context),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.primaryColor,
          decoration: TextDecoration.underline,
          fontSize: fontSize,
        ),
      ),
    );
  }
}