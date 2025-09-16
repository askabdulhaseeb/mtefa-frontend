import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/providers/my_providers.dart';
import 'core/config/api_config.dart';
import 'core/database/database_initializer.dart';
import 'core/localization/app_localization.dart';
import 'injection_container.dart' as di;
import 'presentation/screens/auth/login/login_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/inventory/add_inventory/add_inventory_screen.dart';

/// Main entry point of the MTEFA POS application
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize dependency injection
    await di.init();

    // Initialize API configuration
    await ApiConfig.initialize(environment: 'development');

    // Initialize database
    await DatabaseInitializer.instance.initialize();

    if (kDebugMode) {
      debugPrint('Application initialization completed successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Failed to initialize application: $e');
    }
    // You might want to show an error dialog or handle this gracefully
  }

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.filePath,
      fallbackLocale: AppLocalization.defaultLocale,
      startLocale: AppLocalization.defaultLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build the app with optimized provider setup
    Widget app = MaterialApp(
      title: 'MTEFA - Make Trading Easy For All',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: DashboardScreen.routeName,
      routes: <String, WidgetBuilder>{
        LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
        DashboardScreen.routeName: (BuildContext context) =>
            const DashboardScreen(),
        AddInventoryScreen.routeName: (BuildContext context) =>
            const AddInventoryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );

    // Only wrap with MultiProvider if there are global providers
    if (MyProviders.isNotEmpty) {
      return MultiProvider(providers: MyProviders.providers, child: app);
    }

    // Return app directly if no global providers
    return app;
  }
}
