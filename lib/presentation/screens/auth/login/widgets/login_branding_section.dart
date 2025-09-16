import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';

/// Branding section widget for login screens
class LoginBrandingSection extends StatelessWidget {
  const LoginBrandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DoubleConstants.spacingXL),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Use SingleChildScrollView to prevent overflow
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Logo
                        _buildLogo(),
                        const SizedBox(height: DoubleConstants.spacingL),

                        // Welcome text
                        _buildWelcomeText(theme),
                        const SizedBox(height: DoubleConstants.spacingM),

                        // Description
                        _buildDescription(theme),

                        const Spacer(),

                        // Features list
                        _buildFeatures(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DoubleConstants.radiusL),
      ),
      child: const Icon(Icons.store, size: 48, color: Colors.blue),
    );
  }

  Widget _buildWelcomeText(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Welcome to',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: DoubleConstants.spacingXS),
        Text(
          'MTEFA POS',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enterprise Point of Sale System',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        Text(
          'Manage your business with our comprehensive POS solution featuring multi-branch support, inventory management, and real-time analytics.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: <Widget>[
        _FeatureItem(
          icon: Icons.inventory_2,
          title: 'Inventory Management',
          description: 'Track stock levels across multiple locations',
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        _FeatureItem(
          icon: Icons.point_of_sale,
          title: 'Sales & Transactions',
          description: 'Process sales with multiple payment methods',
        ),
        const SizedBox(height: DoubleConstants.spacingS),
        _FeatureItem(
          icon: Icons.analytics,
          title: 'Real-time Analytics',
          description: 'Monitor business performance instantly',
        ),
      ],
    );
  }
}

/// Feature item widget for branding section
class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(DoubleConstants.spacingS),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: DoubleConstants.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
