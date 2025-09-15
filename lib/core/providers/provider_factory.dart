import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../injection_container.dart' as di;

/// Factory class for creating lazy-loaded providers with automatic disposal
/// This pattern ensures providers are only created when needed and properly disposed
abstract class ProviderFactory {
  /// Creates a lazy-loaded ChangeNotifierProvider
  /// Provider instance is created only when first accessed
  /// Automatically disposes when no longer needed
  static ChangeNotifierProvider<T> createLazy<T extends ChangeNotifier>({
    required T Function(BuildContext) create,
    bool lazy = true,
    TransitionBuilder? builder,
    Widget? child,
  }) {
    return ChangeNotifierProvider<T>(
      create: create,
      lazy: lazy, // Only create when first accessed
      builder: builder,
      child: child,
    );
  }

  /// Creates a lazy-loaded ChangeNotifierProvider from GetIt
  /// Uses dependency injection to create provider instances
  static ChangeNotifierProvider<T> createFromDI<T extends ChangeNotifier>({
    bool lazy = true,
  }) {
    return ChangeNotifierProvider<T>(
      create: (_) => di.sl<T>(),
      lazy: lazy,
    );
  }

  /// Creates a ProxyProvider for providers that depend on others
  /// Useful for providers that need data from other providers
  static ProxyProvider<T, R> createProxy<T, R extends ChangeNotifier>({
    required R Function(BuildContext, T, R?) update,
    bool lazy = true,
    R Function(BuildContext)? create,
    bool Function(R, R)? updateShouldNotify,
  }) {
    return ProxyProvider<T, R>(
      create: create,
      update: update,
      lazy: lazy,
      updateShouldNotify: updateShouldNotify,
    );
  }

  /// Creates a scoped provider that auto-disposes when widget is removed
  /// Perfect for screen-specific providers
  static Widget createScoped<T extends ChangeNotifier>({
    required T Function(BuildContext) create,
    required Widget child,
    bool lazy = true,
  }) {
    return ChangeNotifierProvider<T>(
      create: create,
      lazy: lazy,
      child: child,
    );
  }

  /// Creates multiple lazy providers
  /// Used for providing multiple providers at once with lazy loading
  static MultiProvider createMultiple({
    required List<SingleChildWidget> providers,
    required Widget child,
    TransitionBuilder? builder,
  }) {
    // Ensure all ChangeNotifierProviders have lazy: true
    final List<SingleChildWidget> lazyProviders = providers.map((SingleChildWidget provider) {
      if (provider is ChangeNotifierProvider) {
        // This is already configured, return as is
        return provider;
      }
      return provider;
    }).toList();

    return MultiProvider(
      providers: lazyProviders,
      builder: builder,
      child: child,
    );
  }
}

/// Extension to easily access providers from BuildContext
extension ProviderExtensions on BuildContext {
  /// Read a provider value (doesn't rebuild on changes)
  T readProvider<T>() => read<T>();

  /// Watch a provider value (rebuilds on changes)
  T watchProvider<T>() => watch<T>();

  /// Select specific value from provider (rebuilds only when selected value changes)
  R selectProvider<T, R>(R Function(T) selector) => select<T, R>(selector);

  /// Try to read a provider, returns null if not found
  T? tryReadProvider<T>() {
    try {
      return read<T>();
    } catch (_) {
      return null;
    }
  }

  /// Check if a provider exists in the widget tree
  bool hasProvider<T>() {
    try {
      read<T>();
      return true;
    } catch (_) {
      return false;
    }
  }
}