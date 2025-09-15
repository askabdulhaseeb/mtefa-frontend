import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/auth/user_entity.dart';
import '../../providers/login_provider.dart';
import '../../../../widgets/core/custom_elevated_button.dart';
import '../../../../widgets/core/custom_textformfield.dart';
import '../../../../widgets/core/password_textformfield.dart';

/// Mobile view for login screen
class LoginMobileView extends StatelessWidget {
  const LoginMobileView({
    required this.provider,
    super.key,
  });

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(DoubleConstants.spacingL),
        child: Container(
          constraints: BoxConstraints(
            minHeight: size.height - MediaQuery.paddingOf(context).top - MediaQuery.paddingOf(context).bottom - (DoubleConstants.spacingL * 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(DoubleConstants.radiusL),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.store,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingL),
              
              // App name
              Text(
                'MTEFA POS',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingS),
              Text(
                'Point of Sale System',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingXL),
              
              // Login form
              Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Form header
                    Text(
                      'Sign In',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: DoubleConstants.spacingS),
                    Text(
                      'Enter your credentials',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: DoubleConstants.spacingL),
                    
                    // Email field
                    CustomTextFormField(
                      controller: provider.emailController,
                      labelText: 'Email',
                      hint: 'john.doe@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined, size: 20),
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
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: provider.rememberMe,
                                onChanged: (bool? _) => provider.toggleRememberMe(),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: DoubleConstants.spacingS),
                            const Text(
                              'Remember me',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: provider.forgotPassword,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DoubleConstants.spacingS,
                            ),
                          ),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(fontSize: 14),
                          ),
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
                              size: 18,
                            ),
                            const SizedBox(width: DoubleConstants.spacingS),
                            Expanded(
                              child: Text(
                                (provider.loginState as DataFailed<LoginResponseEntity>).error,
                                style: TextStyle(
                                  color: theme.colorScheme.error,
                                  fontSize: 12,
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
                    const SizedBox(height: DoubleConstants.spacingM),
                    
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
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: DoubleConstants.spacingM),
                    
                    // Biometric login
                    OutlinedButton.icon(
                      onPressed: provider.loginWithBiometrics,
                      icon: const Icon(Icons.fingerprint, size: 20),
                      label: const Text(
                        'Login with Biometrics',
                        style: TextStyle(fontSize: 14),
                      ),
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
              const SizedBox(height: DoubleConstants.spacingXL),
              
              // Footer
              Text(
                '© 2024 MTEFA POS',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                  fontSize: 11,
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