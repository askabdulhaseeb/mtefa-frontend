import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../providers/login_provider.dart';
import '../widgets/login_branding_section.dart';
import '../widgets/login_form_card.dart';

/// Desktop view for login screen
/// Optimized with modular components for better maintainability
class LoginDesktopView extends StatelessWidget {
  const LoginDesktopView({
    required this.provider,
    super.key,
  });

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            theme.primaryColor.withValues(alpha: 0.1),
            theme.primaryColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          // Left side - Branding section
          const Expanded(
            flex: 5,
            child: LoginBrandingSection(),
          ),
          
          // Right side - Login form
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DoubleConstants.spacingXXL),
                child: LoginFormCard(provider: provider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}