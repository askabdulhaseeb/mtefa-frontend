import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/localization/app_localization.dart';
import 'core/config/api_config.dart';
import 'core/database/database_initializer.dart';

/// Main entry point of the MTEFA POS application
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
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
    return MaterialApp(
      title: 'MTEFA - Make Trading Easy For All',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(),
    );
  }
}
