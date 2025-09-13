import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API configuration class for managing environment-specific settings
class ApiConfig {
  ApiConfig._();
  static ApiConfig? _instance;

  late final String baseUrl;
  late final String apiVersion;
  late final Duration connectTimeout;
  late final Duration receiveTimeout;
  late final String environment;
  late final bool enableLogging;

  /// Singleton instance getter
  static ApiConfig get instance {
    _instance ??= ApiConfig._();
    return _instance!;
  }

  /// Initialize the API configuration from environment variables
  static Future<void> initialize({String environment = 'development'}) async {
    final ApiConfig instance = ApiConfig.instance;

    // Load environment file
    final String envFile = '.env.$environment';
    try {
      await dotenv.load(fileName: envFile);
    } catch (e) {
      // If specific environment file doesn't exist, try default .env
      await dotenv.load(fileName: '.env');
    }

    // Set configuration values
    instance.environment = environment;
    instance.baseUrl =
        dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
    instance.apiVersion = dotenv.env['API_VERSION'] ?? '1.0.0';

    // Parse timeout values
    final int connectTimeoutSeconds =
        int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '30') ?? 30;
    final int receiveTimeoutSeconds =
        int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '30') ?? 30;

    instance.connectTimeout = Duration(seconds: connectTimeoutSeconds);
    instance.receiveTimeout = Duration(seconds: receiveTimeoutSeconds);
    instance.enableLogging =
        dotenv.env['ENABLE_LOGGING']?.toLowerCase() == 'true';
  }

  /// Get full API URL for an endpoint
  String getEndpointUrl(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$baseUrl$endpoint';
    }
    return '$baseUrl/$endpoint';
  }

  /// Check if running in development mode
  bool get isDevelopment => environment == 'development';

  /// Check if running in staging mode
  bool get isStaging => environment == 'staging';

  /// Check if running in production mode
  bool get isProduction => environment == 'production';
}
