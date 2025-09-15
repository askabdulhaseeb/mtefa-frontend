import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/provider_factory.dart';
import '../providers/provider_registry.dart';

/// Base widget for screens that need scoped providers
/// Automatically handles provider lifecycle and disposal
class ProviderScopeWidget extends StatelessWidget {
  const ProviderScopeWidget({
    required this.child,
    this.routeName,
    this.customProviders = const [],
    super.key,
  });

  /// The child widget to wrap with providers
  final Widget child;

  /// Optional route name to load route-specific providers
  final String? routeName;

  /// Custom providers specific to this scope
  final List<SingleChildWidget> customProviders;

  @override
  Widget build(BuildContext context) {
    // Collect all providers for this scope
    final List<SingleChildWidget> allProviders = [];

    // Add route-specific providers if route name is provided
    if (routeName != null) {
      allProviders.addAll(ProviderRegistry.getProvidersForRoute(routeName!));
    }

    // Add custom providers
    allProviders.addAll(customProviders);

    // If no providers, return child directly
    if (allProviders.isEmpty) {
      return child;
    }

    // Wrap child with all providers
    return ProviderFactory.createMultiple(
      providers: allProviders,
      child: child,
    );
  }
}

/// Specialized scope for authentication screens
/// Provides login-related providers automatically
class AuthProviderScope extends StatelessWidget {
  const AuthProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/login',
      child: child,
    );
  }
}

/// Specialized scope for dashboard screens
/// Provides dashboard-related providers automatically
class DashboardProviderScope extends StatelessWidget {
  const DashboardProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/dashboard',
      child: child,
    );
  }
}

/// Specialized scope for product screens
/// Provides product-related providers automatically
class ProductProviderScope extends StatelessWidget {
  const ProductProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/products',
      child: child,
    );
  }
}

/// Specialized scope for inventory screens
/// Provides inventory-related providers automatically
class InventoryProviderScope extends StatelessWidget {
  const InventoryProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/inventory',
      child: child,
    );
  }
}

/// Specialized scope for sales screens
/// Provides sales-related providers automatically
class SalesProviderScope extends StatelessWidget {
  const SalesProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/sales',
      child: child,
    );
  }
}

/// Specialized scope for reports screens
/// Provides reports-related providers automatically
class ReportsProviderScope extends StatelessWidget {
  const ReportsProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/reports',
      child: child,
    );
  }
}

/// Specialized scope for settings screens
/// Provides settings-related providers automatically
class SettingsProviderScope extends StatelessWidget {
  const SettingsProviderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/settings',
      child: child,
    );
  }
}

/// Example usage in a screen:
/// 
/// ```dart
/// class LoginScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AuthProviderScope(
///       child: LoginScreenContent(),
///     );
///   }
/// }
/// ```
/// 
/// Or with custom providers:
/// 
/// ```dart
/// class CustomScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ProviderScopeWidget(
///       customProviders: [
///         ChangeNotifierProvider(
///           create: (_) => CustomProvider(),
///           lazy: true,
///         ),
///       ],
///       child: CustomScreenContent(),
///     );
///   }
/// }
/// ```