import 'package:flutter/material.dart';

import '../../../core/constants/numbers.dart';
import '../../../core/database/database.dart';
import '../core/custom_elevated_button.dart';
import '../core/custom_textformfield.dart';
import '../core/password_textformfield.dart';

/// Simple signup popup for local database testing
class SignupPopup extends StatefulWidget {
  const SignupPopup({super.key});

  @override
  State<SignupPopup> createState() => _SignupPopupState();
}

class _SignupPopupState extends State<SignupPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final AppDatabase database = AppDatabase();

      // Check if user already exists
      final List<LocalUser> existingUsers =
          await (database.select(database.users)
            ..where(($UsersTable u) =>
                u.email.equals(_emailController.text.trim().toLowerCase())))
              .get();

      if (existingUsers.isNotEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User with this email already exists!'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Create new user
      await database
          .into(database.users)
          .insert(
            UsersCompanion.insert(
              name: _nameController.text.trim(),
              email: _emailController.text.trim().toLowerCase(),
              password: _passwordController.text, // In real app, hash this!
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating account: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DoubleConstants.radiusL),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(DoubleConstants.spacingXL),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Header
              Text(
                'Create Account',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DoubleConstants.spacingS),
              Text(
                'Sign up for local testing',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DoubleConstants.spacingXL),

              // Name field
              CustomTextFormField(
                controller: _nameController,
                labelText: 'Full Name',
                hint: 'John Doe',
                prefixIcon: const Icon(Icons.person_outline),
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: DoubleConstants.spacingM),

              // Email field
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Email',
                hint: 'john@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: DoubleConstants.spacingM),

              // Password field
              PasswordTextFormField(
                controller: _passwordController,
                labelText: 'Password',
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _signup(),
              ),
              const SizedBox(height: DoubleConstants.spacingXL),

              // Buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: DoubleConstants.spacingM),
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      title: 'Sign Up',
                      isLoading: _isLoading,
                      onTap: _signup,
                    ),
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
