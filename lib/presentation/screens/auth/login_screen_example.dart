import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../core/providers/provider_registry.dart';
import '../../../core/widgets/provider_scope_widget.dart';
import 'providers/login_provider.dart';

/// Example implementation of LoginScreen with lazy-loaded provider
/// This demonstrates the optimized provider pattern
/// 
/// IMPORTANT: This is how ALL screens should be implemented:
/// 1. Wrap screen with appropriate ProviderScope
/// 2. Provider is created only when screen is accessed
/// 3. Provider is disposed when screen is popped
/// 4. No global memory footprint for screen-specific state
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    // AuthProviderScope automatically provides LoginProvider
    // Provider is created lazily when first accessed
    // Provider is disposed when screen is removed from widget tree
    return const AuthProviderScope(
      child: LoginScreenContent(),
    );
  }
}

/// The actual login screen content
/// Separated from provider setup for clarity
class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the lazily-loaded LoginProvider
    // Provider is created here on first access if not already created
    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: loginProvider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email field
              TextFormField(
                controller: loginProvider.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: loginProvider.emailError,
                ),
                onChanged: (_) => loginProvider.validateEmail(),
              ),
              const SizedBox(height: 16),
              
              // Password field
              TextFormField(
                controller: loginProvider.passwordController,
                obscureText: !loginProvider.isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: loginProvider.passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      loginProvider.isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: loginProvider.togglePasswordVisibility,
                  ),
                ),
                onChanged: (_) => loginProvider.validatePassword(),
              ),
              const SizedBox(height: 16),
              
              // Remember me checkbox
              Row(
                children: [
                  Checkbox(
                    value: loginProvider.rememberMe,
                    onChanged: (_) => loginProvider.toggleRememberMe(),
                  ),
                  const Text('Remember me'),
                ],
              ),
              const SizedBox(height: 24),
              
              // Login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loginProvider.canSubmit
                      ? () async {
                          await loginProvider.login();
                          // Handle navigation after successful login
                          if (loginProvider.loginState?.isSuccess == true) {
                            // Navigate to dashboard
                            // Navigator.pushReplacementNamed(context, '/dashboard');
                          }
                        }
                      : null,
                  child: loginProvider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
              
              // Forgot password link
              TextButton(
                onPressed: loginProvider.forgotPassword,
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Alternative implementation using ProviderScopeMixin for StatefulWidget
/// Use this pattern when you need StatefulWidget features
class LoginScreenStateful extends StatefulWidget {
  const LoginScreenStateful({super.key});

  @override
  State<LoginScreenStateful> createState() => _LoginScreenStatefulState();
}

class _LoginScreenStatefulState extends State<LoginScreenStateful>
    with ProviderScopeMixin {
  
  @override
  String get routeName => '/login';

  @override
  List<SingleChildWidget> get additionalProviders => [];

  @override
  void initState() {
    super.initState();
    // Any initialization logic here
  }

  @override
  void dispose() {
    // Additional cleanup if needed
    // Provider disposal is handled automatically by ProviderScopeMixin
    super.dispose();
  }

  @override
  Widget buildScoped(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Text('Login State: ${loginProvider.isLoading ? "Loading..." : "Ready"}'),
      ),
    );
  }
}

/// Example of using custom providers for a screen
/// This shows how to add screen-specific providers beyond route providers
class LoginScreenWithCustomProviders extends StatelessWidget {
  const LoginScreenWithCustomProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/login',  // Gets LoginProvider from registry
      customProviders: [
        // Add any additional providers specific to this screen
        // These will also be lazy-loaded and auto-disposed
        // Example:
        // ChangeNotifierProvider(
        //   create: (_) => BiometricProvider(),
        //   lazy: true,
        // ),
      ],
      child: const LoginScreenContent(),
    );
  }
}

/// Memory Optimization Benefits:
/// 
/// Before (Global Provider):
/// - LoginProvider created at app start
/// - Remains in memory even when user is logged in
/// - Controllers and state persist unnecessarily
/// - Memory usage: ~2MB constant
/// 
/// After (Lazy Loading):
/// - LoginProvider created only when login screen accessed
/// - Disposed immediately when login complete or canceled
/// - Controllers and state cleaned up automatically
/// - Memory usage: 2MB only during login process
/// 
/// This pattern scales to hundreds of screens without memory issues