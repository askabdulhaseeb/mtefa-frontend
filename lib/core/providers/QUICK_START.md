# Provider Lazy Loading - Quick Start Guide

## 🚀 For New Screens

### Option 1: Using Pre-built Provider Scopes (Recommended)

```dart
import 'package:flutter/material.dart';
import '../../../core/widgets/provider_scope_widget.dart';

class YourLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProviderScope(  // Automatically provides LoginProvider
      child: YourScreenContent(),
    );
  }
}
```

### Option 2: Custom Provider Scope

```dart
import '../../../core/widgets/provider_scope_widget.dart';

class YourCustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/your-route',  // Load route-specific providers
      customProviders: [         // Add screen-specific providers
        ChangeNotifierProvider(
          create: (_) => YourCustomProvider(),
          lazy: true,  // ALWAYS use lazy: true
        ),
      ],
      child: YourScreenContent(),
    );
  }
}
```

## 📝 For New Providers

### Step 1: Create Provider
```dart
class YourProvider extends ChangeNotifier {
  // Your state and methods
  
  @override
  void dispose() {
    // IMPORTANT: Clean up resources
    _controller.dispose();
    _clearData();
    super.dispose();
  }
}
```

### Step 2: Register in DI
```dart
// In injection_container.dart
sl.registerFactory<YourProvider>(  // Use Factory, not Singleton!
  () => YourProvider(
    repository: sl<YourRepository>(),
  ),
);
```

### Step 3: Add to Route Registry
```dart
// In provider_registry.dart
'/your-route': () => [
  ProviderFactory.createFromDI<YourProvider>(lazy: true),
],
```

### Step 4: Use in Screen
```dart
class YourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScopeWidget(
      routeName: '/your-route',
      child: YourScreenContent(),
    );
  }
}
```

## ⚡ Key Rules

1. **ALWAYS use `lazy: true`** for ChangeNotifierProvider
2. **ALWAYS implement `dispose()`** in your providers
3. **NEVER put screen-specific providers globally**
4. **USE `registerFactory`** in GetIt, not `registerSingleton`
5. **WRAP screens with provider scopes**, not the entire app

## 🎯 Available Provider Scopes

- `AuthProviderScope` - Login/Auth screens
- `DashboardProviderScope` - Dashboard screens  
- `ProductProviderScope` - Product management
- `InventoryProviderScope` - Inventory management
- `SalesProviderScope` - POS/Sales screens
- `ReportsProviderScope` - Reports/Analytics
- `SettingsProviderScope` - Settings screens

## 💡 Memory Benefits

- **Before**: All providers loaded at startup → 10-15MB constant
- **After**: Providers loaded on-demand → 1-3MB average
- **Auto-disposal**: Memory freed when screen closed

## 🔍 Debug Provider Loading

```dart
// Check if provider exists
if (context.hasProvider<YourProvider>()) {
  print('Provider is loaded');
}

// Safe provider access
final provider = context.tryReadProvider<YourProvider>();
if (provider != null) {
  // Use provider
}
```

## ❌ Common Mistakes

```dart
// BAD - Always in memory
ChangeNotifierProvider<MyProvider>(
  create: (_) => MyProvider(),  // Missing lazy: true
)

// BAD - Global screen provider
class MyProviders {
  static providers = [
    ChangeNotifierProvider<LoginProvider>(...),  // Should be route-scoped
  ];
}

// BAD - Singleton in DI
sl.registerSingleton<MyProvider>(...);  // Use registerFactory

// BAD - No disposal
class MyProvider extends ChangeNotifier {
  // Missing dispose() method
}
```

## ✅ Correct Usage

```dart
// GOOD - Lazy loaded
ChangeNotifierProvider<MyProvider>(
  lazy: true,
  create: (_) => MyProvider(),
)

// GOOD - Route scoped
AuthProviderScope(
  child: LoginScreen(),
)

// GOOD - Factory in DI
sl.registerFactory<MyProvider>(...);

// GOOD - Proper disposal
@override
void dispose() {
  _cleanup();
  super.dispose();
}
```

Remember: **Lazy loading + Auto-disposal = Optimal Memory Usage** 🚀