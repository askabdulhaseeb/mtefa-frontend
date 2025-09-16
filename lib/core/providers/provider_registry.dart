import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import '../../presentation/screens/auth/login/login_screen.dart';
import '../../presentation/screens/auth/providers/login_provider.dart';
import '../../presentation/screens/dashboard/providers/dashboard_provider.dart';
import 'provider_factory.dart';

/// Registry for managing route-specific providers
/// This ensures providers are only loaded when their routes are accessed
class ProviderRegistry {
  /// Map of route names to their required providers
  /// Providers will be lazy-loaded when route is accessed
  static final Map<String, List<SingleChildWidget> Function()> _routeProviders =
      <String, List<SingleChildWidget> Function()>{
        LoginScreen.routeName: () => <SingleChildWidget>[
          ProviderFactory.createFromDI<LoginProvider>(lazy: true),
        ],
        '/dashboard': () => <SingleChildWidget>[
          ProviderFactory.createFromDI<DashboardProvider>(lazy: true),
        ],
        '/products': () => <SingleChildWidget>[
          // Add product-specific providers here when created
          // Example:
          // ProviderFactory.createFromDI<ProductProvider>(lazy: true),
          // ProviderFactory.createFromDI<CategoryProvider>(lazy: true),
        ],
        '/inventory': () => <SingleChildWidget>[
          // Add inventory-specific providers here when created
          // Example:
          // ProviderFactory.createFromDI<InventoryProvider>(lazy: true),
          // ProviderFactory.createFromDI<StockProvider>(lazy: true),
        ],
        '/sales': () => <SingleChildWidget>[
          // Add sales-specific providers here when created
          // Example:
          // ProviderFactory.createFromDI<SalesProvider>(lazy: true),
          // ProviderFactory.createFromDI<CartProvider>(lazy: true),
        ],
        '/reports': () => <SingleChildWidget>[
          // Add reports-specific providers here when created
          // Example:
          // ProviderFactory.createFromDI<ReportsProvider>(lazy: true),
          // ProviderFactory.createFromDI<AnalyticsProvider>(lazy: true),
        ],
        '/settings': () => <SingleChildWidget>[
          // Add settings-specific providers here when created
          // Example:
          // ProviderFactory.createFromDI<SettingsProvider>(lazy: true),
          // ProviderFactory.createFromDI<PreferencesProvider>(lazy: true),
        ],
      };

  /// Global providers that should always be available
  /// These are core providers needed throughout the app
  static List<SingleChildWidget> get globalProviders => <SingleChildWidget>[
    // Add global providers here when needed
    // Example:
    // ProviderFactory.createFromDI<ThemeProvider>(lazy: true),
    // ProviderFactory.createFromDI<LocaleProvider>(lazy: true),
    // ProviderFactory.createFromDI<AuthStateProvider>(lazy: true),
  ];

  /// Get providers for a specific route
  static List<SingleChildWidget> getProvidersForRoute(String routeName) {
    final List<SingleChildWidget> Function()? providerFactory =
        _routeProviders[routeName];
    if (providerFactory != null) {
      return providerFactory();
    }
    return <SingleChildWidget>[];
  }

  /// Register a new route with its providers
  static void registerRoute(
    String routeName,
    List<SingleChildWidget> Function() providerFactory,
  ) {
    _routeProviders[routeName] = providerFactory;
  }

  /// Unregister a route (cleanup)
  static void unregisterRoute(String routeName) {
    _routeProviders.remove(routeName);
  }

  /// Check if a route has registered providers
  static bool hasProvidersForRoute(String routeName) {
    return _routeProviders.containsKey(routeName);
  }

  /// Get all registered routes
  static Set<String> get registeredRoutes => _routeProviders.keys.toSet();

  /// Create a provider scope for a specific route
  /// This wraps a widget with the necessary providers for that route
  static Widget createRouteScope({
    required String routeName,
    required Widget child,
  }) {
    final List<SingleChildWidget> providers = getProvidersForRoute(routeName);

    if (providers.isEmpty) {
      return child;
    }

    return ProviderFactory.createMultiple(providers: providers, child: child);
  }

  /// Create a provider scope with custom providers
  /// Useful for screens that need specific provider combinations
  static Widget createCustomScope({
    required List<SingleChildWidget> providers,
    required Widget child,
  }) {
    if (providers.isEmpty) {
      return child;
    }

    return ProviderFactory.createMultiple(providers: providers, child: child);
  }
}

/// Mixin for screens that need route-specific providers
/// Automatically wraps the screen with necessary providers
mixin ProviderScopeMixin<T extends StatefulWidget> on State<T> {
  /// Override this to specify the route name for provider loading
  String get routeName;

  /// Additional providers specific to this screen
  List<SingleChildWidget> get additionalProviders => <SingleChildWidget>[];

  @override
  Widget build(BuildContext context) {
    final List<SingleChildWidget> routeProviders =
        ProviderRegistry.getProvidersForRoute(routeName);
    final List<SingleChildWidget> allProviders = <SingleChildWidget>[
      ...routeProviders,
      ...additionalProviders,
    ];

    if (allProviders.isEmpty) {
      return buildScoped(context);
    }

    return ProviderFactory.createMultiple(
      providers: allProviders,
      child: Builder(builder: buildScoped),
    );
  }

  /// Build method for the actual screen content
  /// This is called after providers are set up
  Widget buildScoped(BuildContext context);
}
