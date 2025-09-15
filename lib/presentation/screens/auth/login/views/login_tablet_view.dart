import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/auth/user_entity.dart';
import '../../providers/login_provider.dart';
import '../../../../widgets/core/custom_elevated_button.dart';
import '../../../../widgets/core/custom_textformfield.dart';
import '../../../../widgets/core/password_textformfield.dart';

/// Tablet view for login screen
class LoginTabletView extends StatelessWidget {
  const LoginTabletView({
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
              Container(
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
                child: const Icon(
                  Icons.store,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingL),
              
              // App name
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
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingXL),
              
              // Login form card
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Card(
                  elevation: DoubleConstants.elevationM,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DoubleConstants.radiusXL),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DoubleConstants.spacingXL),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Form header
                          Text(
                            'Welcome Back',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: DoubleConstants.spacingS),
                          Text(
                            'Sign in to continue to your account',
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
                        ],
                      ),
                    ),
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
    );
  }
}