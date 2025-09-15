import 'package:provider/single_child_widget.dart';

import '../../core/providers/provider_registry.dart';

/// Main provider configuration for the application
/// Uses lazy loading pattern to optimize memory usage
/// 
/// IMPORTANT: Follow these patterns for ALL future providers:
/// 
/// 1. GLOBAL PROVIDERS (Always Available):
///    - Use for app-wide state (theme, locale, auth status)
///    - Should be minimal to reduce memory footprint
///    - Example: ThemeProvider, LocaleProvider, AuthStateProvider
/// 
/// 2. ROUTE-SPECIFIC PROVIDERS (Lazy Loaded):
///    - Created only when route is accessed
///    - Auto-disposed when route is popped
///    - Register in ProviderRegistry
///    - Example: LoginProvider, ProductProvider, CartProvider
/// 
/// 3. SCREEN-SPECIFIC PROVIDERS (Scoped):
///    - Created at screen level using ProviderScopeMixin
///    - Perfect for form state, temporary UI state
///    - Auto-disposed when screen is disposed
/// 
/// BEST PRACTICES:
/// - Always use lazy: true for ChangeNotifierProvider
/// - Use ProviderFactory methods for consistency
/// - Register route providers in ProviderRegistry
/// - Implement proper dispose() in all providers
/// - Clear sensitive data in dispose()
class MyProviders {
  /// Global providers that are always available
  /// Keep this list minimal for optimal memory usage
  static List<SingleChildWidget> get globalProviders {
    return [
      // Only add truly global providers here
      // Examples when needed:
      // ProviderFactory.createFromDI<ThemeProvider>(lazy: true),
      // ProviderFactory.createFromDI<LocaleProvider>(lazy: true),
      // ProviderFactory.createFromDI<AuthStateProvider>(lazy: true),
      
      // For now, we keep this empty as LoginProvider
      // will be loaded only when login screen is accessed
    ];
  }

  /// Get all providers (global + any additional setup)
  /// This is used in main.dart for initial setup
  static List<SingleChildWidget> get providers {
    return [
      ...globalProviders,
      ...ProviderRegistry.globalProviders,
    ];
  }

  /// Check if providers list is empty
  static bool get isEmpty => providers.isEmpty;

  /// Check if providers list has items
  static bool get isNotEmpty => providers.isNotEmpty;
}
