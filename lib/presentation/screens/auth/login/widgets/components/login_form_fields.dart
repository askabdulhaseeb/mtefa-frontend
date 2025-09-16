import 'package:flutter/material.dart';

import '../../../../../../core/constants/numbers.dart';
import '../../../providers/login_provider.dart';
import '../../../../../widgets/core/custom_textformfield.dart';
import '../../../../../widgets/core/password_textformfield.dart';

/// Login form fields component containing email and password inputs
/// Focused widget for handling user credential input
class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    required this.provider,
    super.key,
  });

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        const SizedBox(height: DoubleConstants.spacingM),
        
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
      ],
    );
  }
}