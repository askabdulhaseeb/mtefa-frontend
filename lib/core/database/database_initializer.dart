import 'package:flutter/foundation.dart';

import 'database_helper.dart';

/// Simple database initializer for basic Drift setup
class DatabaseInitializer {
  DatabaseInitializer._();
  static DatabaseInitializer? _instance;
  static DatabaseInitializer get instance =>
      _instance ??= DatabaseInitializer._();

  bool _isInitialized = false;

  /// Initialize the database
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      if (kDebugMode) {
        debugPrint('Initializing Drift database...');
      }

      // Initialize database helper
      await DatabaseHelper.instance.initialize();

      _isInitialized = true;

      if (kDebugMode) {
        debugPrint('Drift database initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to initialize database: $e');
      }
      rethrow;
    }
  }

  /// Check if database is initialized
  bool get isInitialized => _isInitialized;

  /// Close database connections
  Future<void> close() async {
    if (_isInitialized) {
      await DatabaseHelper.instance.close();
      _isInitialized = false;

      if (kDebugMode) {
        debugPrint('Database connections closed');
      }
    }
  }
}
