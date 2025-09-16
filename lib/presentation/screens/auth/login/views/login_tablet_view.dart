import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../providers/login_provider.dart';
import '../widgets/login_form_card.dart';

/// Tablet view for login screen
/// Optimized with modular components for better maintainability
class LoginTabletView extends StatelessWidget {
  const LoginTabletView({required this.provider, super.key});

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            theme.primaryColor.withValues(alpha: 0.1),
            theme.primaryColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DoubleConstants.spacingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo and branding
              _buildLogo(theme),
              const SizedBox(height: DoubleConstants.spacingL),

              // App name
              _buildAppTitle(theme),
              const SizedBox(height: DoubleConstants.spacingXL),

              // Login form card
              LoginFormCard(provider: provider, maxWidth: 500),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(ThemeData theme) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(DoubleConstants.radiusXL),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(Icons.store, size: 60, color: Colors.white),
    );
  }

  Widget _buildAppTitle(ThemeData theme) {
    return Column(
      children: <Widget>[
        Text(
          'MTEFA POS',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        Text(
          'Enterprise Point of Sale System',
          style: theme.textTheme.titleMedium?.copyWith(color: theme.hintColor),
        ),
      ],
    );
  }
}
