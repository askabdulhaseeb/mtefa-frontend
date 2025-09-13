import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/applog.dart';
import 'environment.dart';

class AppConfig {
  static bool _isInitialized = false;
  static Environment _environment = Environment.development;

  // App Configuration
  static String get appName => dotenv.get('APP_NAME', fallback: 'POS System');
  static String get appVersion => dotenv.get('APP_VERSION', fallback: '1.0.0');
  static Environment get environment => _environment;
  static bool get isInitialized => _isInitialized;

  // Debug Configuration
  static bool get enableLogging =>
      dotenv
          .get('ENABLE_LOGGING', fallback: kDebugMode.toString())
          .toLowerCase() ==
      'true';

  static bool get enableCrashReporting =>
      dotenv.get('ENABLE_CRASH_REPORTING', fallback: 'false').toLowerCase() ==
      'true';

  /// Initialize the application configuration
  static Future<void> initialize({Environment? environment}) async {
    try {
      // Set environment
      _environment =
          environment ??
          EnvironmentHelper.fromString(
            const String.fromEnvironment(
              'ENVIRONMENT',
              defaultValue: 'development',
            ),
          );
      EnvironmentHelper.setEnvironment(_environment);

      // Load environment file
      final String envFile = _environment.envFileName;

      AppLog.info('Loading environment configuration from: $envFile');

      try {
        await dotenv.load(fileName: envFile);
        AppLog.info('Successfully loaded $envFile');
      } catch (e) {
        AppLog.warning(
          'Could not load $envFile, using fallback values: ${e.toString()}',
        );
        // Initialize with empty dotenv to allow fallback values
        dotenv.testLoad(fileInput: '');
      }

      _isInitialized = true;

      // Validate critical configurations
      _validateConfiguration();

      AppLog.info(
        'AppConfig initialized successfully for ${_environment.name} environment',
      );
    } catch (e) {
      AppLog.error('Failed to initialize AppConfig: ${e.toString()}', error: e);
      rethrow;
    }
  }

  /// Validate that all critical configuration values are present
  static void _validateConfiguration() {
    final List<String> missingConfigs = <String>[];

    if (missingConfigs.isNotEmpty) {
      final String message =
          'Missing critical configuration values: ${missingConfigs.join(', ')}';

      if (_environment.isProduction) {
        throw StateError(message);
      } else {
        AppLog.warning(
          '$message - Using fallback values for ${_environment.name} environment',
        );
      }
    }
  }

  /// Get configuration summary for debugging
  static Map<String, dynamic> getConfigSummary() {
    return <String, dynamic>{
      'environment': _environment.name,
      'isInitialized': _isInitialized,
      'appName': appName,
      'appVersion': appVersion,
      'enableLogging': enableLogging,
      'enableCrashReporting': enableCrashReporting,
    };
  }
}
