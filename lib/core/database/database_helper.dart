import 'package:get_it/get_it.dart';

import 'database.dart';

/// Simple database helper for basic Drift initialization
class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper? _instance;
  static DatabaseHelper get instance => _instance ??= DatabaseHelper._();

  AppDatabase? _database;

  /// Initialize the database
  Future<void> initialize() async {
    _database = AppDatabase();

    // Register database instance
    if (!GetIt.instance.isRegistered<AppDatabase>()) {
      GetIt.instance.registerSingleton<AppDatabase>(_database!);
    }
  }

  /// Get database instance
  AppDatabase get database => _database!;

  /// Close database connection
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      _instance = null;
    }
  }
}
