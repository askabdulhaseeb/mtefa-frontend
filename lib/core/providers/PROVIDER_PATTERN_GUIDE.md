# Provider Lazy Loading Pattern Guide

## 🎯 Overview

This guide documents the lazy loading and auto-disposal pattern implemented for optimal memory management in the MTEFA Flutter application. This pattern ensures providers are only loaded when needed and properly disposed when no longer required.

## 📋 Quick Reference

### ✅ DO's - Best Practices

```dart
// GOOD - Lazy loading with auto-disposal
ChangeNotifierProvider<MyProvider>(
  lazy: true,  // Only create when first accessed
  create: (context) => MyProvider(),
)

// GOOD - Scoped provider for specific screen
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProviderScope(
      child: MyScreenContent(),
    );
  }
}

// GOOD - Proper disposal in provider
class MyProvider extends ChangeNotifier {
  @override
  void dispose() {
    // Clean up controllers and sensitive data
    _controller.dispose();
    _clearSensitiveData();
    super.dispose();
  }
}
```

### ❌ DON'Ts - Anti-patterns

```dart
// BAD - Always in memory
ChangeNotifierProvider<MyProvider>(
  lazy: false,  // Or omitting lazy parameter
  create: (context) => MyProvider(),
)

// BAD - Global provider for screen-specific state
class MyProviders {
  static providers = [
    ChangeNotifierProvider<ScreenSpecificProvider>(
      create: (_) => ScreenSpecificProvider(),  // Should be scoped
    ),
  ];
}

// BAD - Not cleaning up in dispose
class MyProvider extends ChangeNotifier {
  @override
  void dispose() {
    // Missing cleanup
    super.dispose();
  }
}
```

## 🏗️ Architecture Components

### 1. Provider Factory (`provider_factory.dart`)
- Central factory for creating lazy-loaded providers
- Ensures consistent configuration across the app
- Methods:
  - `createLazy<T>()` - Creates lazy ChangeNotifierProvider
  - `createFromDI<T>()` - Creates from dependency injection
  - `createScoped<T>()` - Creates scoped provider
  - `createProxy<T,R>()` - Creates dependent providers

### 2. Provider Registry (`provider_registry.dart`)
- Maps routes to their required providers
- Manages provider lifecycle per route
- Enables route-based lazy loading
- Methods:
  - `getProvidersForRoute()` - Get providers for specific route
  - `registerRoute()` - Register new route with providers
  - `createRouteScope()` - Create provider scope for route

### 3. Provider Scope Widgets (`provider_scope_widget.dart`)
- Wrapper widgets for automatic provider management
- Pre-configured scopes for different features
- Available scopes:
  - `AuthProviderScope` - Login/authentication screens
  - `DashboardProviderScope` - Dashboard screens
  - `ProductProviderScope` - Product management
  - `InventoryProviderScope` - Inventory management
  - `SalesProviderScope` - Sales/POS screens
  - `ReportsProviderScope` - Reports/analytics
  - `SettingsProviderScope` - Settings screens

## 📱 Implementation Patterns

### Pattern 1: Global Providers (Minimal)
Used for app-wide state that's always needed.

```dart
// In my_providers.dart
static List<SingleChildWidget> get globalProviders {
  return [
    // Only truly global state
    ProviderFactory.createFromDI<ThemeProvider>(lazy: true),
    ProviderFactory.createFromDI<AuthStateProvider>(lazy: true),
  ];
}
```

### Pattern 2: Route-Specific Providers
Loaded when route is accessed, disposed when popped.

```dart
// In provider_registry.dart
static final Map<String, List<SingleChildWidget> Function()> _routeProviders = {
  '/login': () => [
    ProviderFactory.createFromDI<LoginProvider>(lazy: true),
  ],
  '/products': () => [
    ProviderFactory.createFromDI<ProductProvider>(lazy: true),
    ProviderFactory.createFromDI<CategoryProvider>(lazy: true),
  ],
};

// In your screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProviderScope(
      child: LoginScreenContent(),
    );
  }
}
```

### Pattern 3: Screen-Specific Providers
Created at screen level, perfect for temporary state.

```dart
class MyCustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      customProviders: [
        ProviderFactory.createLazy<FormStateProvider>(
          create: (_) => FormStateProvider(),
        ),
      ],
      child: MyCustomScreenContent(),
    );
  }
}
```

### Pattern 4: Using ProviderScopeMixin
For stateful widgets that need providers.

```dart
class MyStatefulScreen extends StatefulWidget {
  @override
  _MyStatefulScreenState createState() => _MyStatefulScreenState();
}

class _MyStatefulScreenState extends State<MyStatefulScreen> 
    with ProviderScopeMixin {
  
  @override
  String get routeName => '/my-route';
  
  @override
  List<SingleChildWidget> get additionalProviders => [
    ProviderFactory.createLazy<CustomProvider>(
      create: (_) => CustomProvider(),
    ),
  ];
  
  @override
  Widget buildScoped(BuildContext context) {
    // Your screen content here
    return Scaffold(
      // ...
    );
  }
}
```

## 🔄 Provider Lifecycle

### Creation Flow
1. Screen/Route accessed
2. ProviderScope checks registry
3. Providers created lazily on first access
4. Provider instance cached in widget tree

### Disposal Flow
1. Screen/Route popped
2. ProviderScope disposed
3. Provider's dispose() called
4. Memory freed automatically

## 💡 Best Practices

### 1. Memory Management
- Always implement dispose() in providers
- Clear sensitive data in dispose()
- Dispose controllers and subscriptions
- Use weak references for callbacks

### 2. Provider Organization
- Global: Theme, Locale, Auth Status
- Route: Feature-specific providers
- Screen: Form state, UI state
- Never make screen-specific state global

### 3. Dependency Injection
- Register as factory in GetIt for multiple instances
- Register as lazy singleton for shared instances
- Use ProxyProvider for dependent providers

### 4. Testing
- Mock providers in tests
- Test disposal cleanup
- Verify lazy loading behavior
- Test memory leaks with integration tests

## 📊 Memory Impact

### Before Optimization
- All providers loaded at app start
- Remain in memory throughout app lifecycle
- LoginProvider: ~2MB always in memory
- Total provider memory: ~10-15MB constant

### After Optimization
- Providers loaded only when needed
- Auto-disposed when not in use
- LoginProvider: 2MB only during login
- Total provider memory: 1-3MB average

## 🚀 Adding New Providers

### Step 1: Create Provider Class
```dart
class MyNewProvider extends ChangeNotifier {
  // State and methods
  
  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }
}
```

### Step 2: Register in Dependency Injection
```dart
// In injection_container.dart
sl.registerFactory<MyNewProvider>(
  () => MyNewProvider(
    repository: sl<MyRepository>(),
  ),
);
```

### Step 3: Add to Provider Registry
```dart
// In provider_registry.dart
'/my-route': () => [
  ProviderFactory.createFromDI<MyNewProvider>(lazy: true),
],
```

### Step 4: Use in Screen
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/my-route',
      child: MyScreenContent(),
    );
  }
}
```

## 🔍 Debugging

### Check Provider Status
```dart
// Check if provider exists
if (context.hasProvider<MyProvider>()) {
  // Provider is available
}

// Try to read provider safely
final provider = context.tryReadProvider<MyProvider>();
if (provider != null) {
  // Use provider
}
```

### Monitor Memory Usage
- Use Flutter DevTools Memory tab
- Check provider instances in memory
- Verify disposal with breakpoints
- Monitor memory graphs during navigation

## 📝 Checklist for New Features

- [ ] Provider implements proper dispose()
- [ ] Registered as factory in GetIt (not singleton)
- [ ] Added to provider registry with lazy: true
- [ ] Screen uses appropriate provider scope
- [ ] Tested provider lifecycle (creation/disposal)
- [ ] Verified memory is freed on disposal
- [ ] Documentation updated if needed

## 🎓 Key Takeaways

1. **Lazy Loading**: Providers created only when accessed
2. **Auto-Disposal**: Automatic cleanup when scope disposed
3. **Route-Based**: Providers tied to navigation lifecycle
4. **Memory Efficient**: Minimal memory footprint
5. **Maintainable**: Clear patterns for all scenarios

Remember: The goal is to keep memory usage minimal while maintaining a clean, maintainable architecture. Always prefer scoped providers over global ones unless absolutely necessary.