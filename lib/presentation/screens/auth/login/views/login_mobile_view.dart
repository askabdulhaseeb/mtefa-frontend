import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/auth/user_entity.dart';
import '../../providers/login_provider.dart';
import '../../../../widgets/core/custom_elevated_button.dart';
import '../widgets/components/login_form_fields.dart';
import '../widgets/components/login_remember_me_section.dart';
import '../widgets/components/login_error_message.dart';
import '../widgets/components/signup_button.dart';

/// Mobile view for login screen
class LoginMobileView extends StatelessWidget {
  const LoginMobileView({required this.provider, super.key});

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
            minHeight:
                size.height -
                MediaQuery.paddingOf(context).top -
                MediaQuery.paddingOf(context).bottom -
                (DoubleConstants.spacingL * 2),
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
                child: const Icon(Icons.store, size: 48, color: Colors.white),
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

                    // Form Fields (using reusable component)
                    LoginFormFields(provider: provider),

                    // Remember me & Forgot password (using reusable component)
                    LoginRememberMeSection(provider: provider),
                    const SizedBox(height: DoubleConstants.spacingL),

                    // Error message (using reusable component)
                    if (provider.loginState?.isFailed == true)
                      LoginErrorMessage(
                        errorMessage: (provider.loginState as DataFailed<LoginResponseEntity>).error,
                      ),

                    // Login button
                    CustomElevatedButton(
                      title: 'Sign In',
                      isLoading: provider.isLoading,
                      isDisable: !provider.canSubmit,
                      onTap: provider.login,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DoubleConstants.spacingXL),

              // Footer with signup option
              Column(
                children: <Widget>[
                  // Signup button for testing
                  const SignupButton(fontSize: 12),
                  const SizedBox(height: DoubleConstants.spacingXS),
                  
                  // Copyright text
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
            ],
          ),
        ),
      ),
    );
  }
}
