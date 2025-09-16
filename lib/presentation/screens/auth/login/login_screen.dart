import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/widgets/provider_scope_widget.dart';
import '../../../../domain/entities/auth/user_entity.dart';
import '../providers/login_provider.dart';
import '../../../widgets/core/my_scaffold.dart';
import '../../../widgets/core/responsive_widget.dart';
import 'views/login_desktop_view.dart';
import 'views/login_mobile_view.dart';
import 'views/login_tablet_view.dart';

/// Login screen with responsive design
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Check for saved credentials on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSavedCredentials();
    });
  }

  Future<void> _checkSavedCredentials() async {
    // TODO: Implement auto-login with saved credentials
  }

  @override
  Widget build(BuildContext context) {
    return AuthProviderScope(
      child: Consumer<LoginProvider>(
        builder:
            (BuildContext context, LoginProvider loginProvider, Widget? child) {
              // Listen for successful login
              _handleLoginState(loginProvider.loginState);

              return MyScaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                resizeToAvoidBottomInset: true,
                safeArea: false,
                body: ResponsiveWidget(
                  mobile: LoginMobileView(provider: loginProvider),
                  tablet: LoginTabletView(provider: loginProvider),
                  desktop: LoginDesktopView(provider: loginProvider),
                ),
              );
            },
      ),
    );
  }

  void _handleLoginState(DataState<LoginResponseEntity>? state) {
    if (state == null) return;

    if (state.isSuccess) {
      // Navigate to home/dashboard after successful login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // TODO: Navigate to appropriate screen based on user role
        Navigator.of(context).pushReplacementNamed('/dashboard');
      });
    }
  }
}
