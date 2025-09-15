import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/auth/user_entity.dart';
import '../../providers/login_provider.dart';
import '../../../../widgets/core/custom_elevated_button.dart';
import '../../../../widgets/core/custom_textformfield.dart';
import '../../../../widgets/core/password_textformfield.dart';

/// Desktop view for login screen
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
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                image: const DecorationImage(
                  image: AssetImage('assets/images/login_bg.png'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(DoubleConstants.spacingXXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(DoubleConstants.radiusL),
                      ),
                      child: const Icon(
                        Icons.store,
                        size: 48,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: DoubleConstants.spacingXL),
                    
                    // Welcome text
                    Text(
                      'Welcome to',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: DoubleConstants.spacingS),
                    Text(
                      'MTEFA POS',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: DoubleConstants.spacingL),
                    
                    // Description
                    Text(
                      'Enterprise Point of Sale System',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: DoubleConstants.spacingM),
                    Text(
                      'Manage your business with our comprehensive POS solution featuring multi-branch support, inventory management, and real-time analytics.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Features list
                    _buildFeatureItem(
                      icon: Icons.inventory_2,
                      title: 'Inventory Management',
                      description: 'Track stock levels across multiple locations',
                    ),
                    const SizedBox(height: DoubleConstants.spacingM),
                    _buildFeatureItem(
                      icon: Icons.point_of_sale,
                      title: 'Sales & Transactions',
                      description: 'Process sales with multiple payment methods',
                    ),
                    const SizedBox(height: DoubleConstants.spacingM),
                    _buildFeatureItem(
                      icon: Icons.analytics,
                      title: 'Real-time Analytics',
                      description: 'Monitor business performance instantly',
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Right side - Login form
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DoubleConstants.spacingXXL),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Card(
                    elevation: DoubleConstants.elevationL,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DoubleConstants.radiusXL),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(DoubleConstants.spacingXL),
                      child: Form(
                        key: provider.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // Header
                            Text(
                              'Sign In',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: DoubleConstants.spacingS),
                            Text(
                              'Enter your credentials to access your account',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.hintColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: DoubleConstants.spacingXL),
                            
                            // Email field
                            CustomTextFormField(
                              controller: provider.emailController,
                              labelText: 'Email Address',
                              hint: 'john.doe@example.com',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(Icons.email_outlined),
                              autofillHints: const <String>[AutofillHints.email],
                              validator: (String? _) => provider.emailError,
                              onChanged: (String _) => provider.validateEmail(),
                            ),
                            
                            // Password field
                            PasswordTextFormField(
                              controller: provider.passwordController,
                              labelText: 'Password',
                              textInputAction: TextInputAction.done,
                              validator: (String? _) => provider.passwordError,
                              onFieldSubmitted: (String _) {
                                if (provider.canSubmit) {
                                  provider.login();
                                }
                              },
                            ),
                            
                            // Remember me & Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: provider.rememberMe,
                                      onChanged: (bool? _) => provider.toggleRememberMe(),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: provider.forgotPassword,
                                  child: const Text('Forgot password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: DoubleConstants.spacingL),
                            
                            // Error message
                            if (provider.loginState?.isFailed == true)
                              Container(
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
                                    Icon(
                                      Icons.error_outline,
                                      color: theme.colorScheme.error,
                                      size: 20,
                                    ),
                                    const SizedBox(width: DoubleConstants.spacingS),
                                    Expanded(
                                      child: Text(
                                        (provider.loginState as DataFailed<LoginResponseEntity>).error,
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                            // Login button
                            CustomElevatedButton(
                              title: 'Sign In',
                              isLoading: provider.isLoading,
                              isDisable: !provider.canSubmit,
                              onTap: provider.login,
                            ),
                            const SizedBox(height: DoubleConstants.spacingL),
                            
                            // Divider
                            Row(
                              children: <Widget>[
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: DoubleConstants.spacingM,
                                  ),
                                  child: Text(
                                    'OR',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: DoubleConstants.spacingL),
                            
                            // Biometric login
                            OutlinedButton.icon(
                              onPressed: provider.loginWithBiometrics,
                              icon: const Icon(Icons.fingerprint),
                              label: const Text('Login with Biometrics'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: DoubleConstants.spacingM,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
                                ),
                              ),
                            ),
                            const SizedBox(height: DoubleConstants.spacingXL),
                            
                            // Footer
                            Text(
                              '© 2024 MTEFA POS. All rights reserved.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.hintColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(DoubleConstants.spacingS),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(DoubleConstants.radiusM),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
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