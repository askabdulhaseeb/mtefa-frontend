import 'package:flutter/material.dart';

import '../../../../../core/constants/numbers.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../domain/entities/auth/user_entity.dart';
import '../../providers/login_provider.dart';
import '../../../../widgets/core/custom_elevated_button.dart';
import 'components/login_form_header.dart';
import 'components/login_form_fields.dart';
import 'components/login_remember_me_section.dart';
import 'components/login_error_message.dart';
import 'components/login_form_footer.dart';

/// Login form card widget for desktop and tablet views
class LoginFormCard extends StatelessWidget {
  const LoginFormCard({required this.provider, this.maxWidth = 480, super.key});

  final LoginProvider provider;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
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
                const LoginFormHeader(),
                const SizedBox(height: DoubleConstants.spacingXL),

                // Form Fields
                LoginFormFields(provider: provider),
                const SizedBox(height: DoubleConstants.spacingM),

                // Remember me & Forgot password
                LoginRememberMeSection(provider: provider),
                const SizedBox(height: DoubleConstants.spacingL),

                // Error message
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
                const SizedBox(height: DoubleConstants.spacingXL),

                // Footer
                const LoginFormFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
