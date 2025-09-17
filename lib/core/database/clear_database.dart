import 'package:flutter/foundation.dart';
import 'database.dart';

/// Utility class to clear all inventory-related tables
class DatabaseClearer {
  DatabaseClearer(this.database);
  
  final AppDatabase database;

  /// Clear all inventory dropdown tables to remove any hardcoded seed data
  Future<void> clearAllInventoryTables() async {
    try {
      if (kDebugMode) {
        debugPrint('Clearing all inventory tables...');
      }

      // Clear in order to respect foreign key constraints
      await database.delete(database.inventoryVariants).go();
      await database.delete(database.inventoryLocations).go();
      await database.delete(database.inventorySizes).go();
      await database.delete(database.inventoryColors).go();
      await database.delete(database.season).go();
      await database.delete(database.subCategory).go();
      await database.delete(database.categoryTable).go();
      await database.delete(database.suppliers).go();
      await database.delete(database.inventoryLine).go();

      if (kDebugMode) {
        debugPrint('All inventory tables cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error clearing inventory tables: $e');
      }
      rethrow;
    }
  }

  /// Clear a specific table
  Future<void> clearTable(String tableName) async {
    try {
      switch (tableName.toLowerCase()) {
        case 'inventory_line':
          await database.delete(database.inventoryLine).go();
          break;
        case 'category':
          await database.delete(database.categoryTable).go();
          break;
        case 'sub_category':
          await database.delete(database.subCategory).go();
          break;
        case 'suppliers':
          await database.delete(database.suppliers).go();
          break;
        case 'colors':
          await database.delete(database.inventoryColors).go();
          break;
        case 'sizes':
          await database.delete(database.inventorySizes).go();
          break;
        case 'season':
          await database.delete(database.season).go();
          break;
        case 'locations':
          await database.delete(database.inventoryLocations).go();
          break;
        default:
          throw ArgumentError('Unknown table: $tableName');
      }
      
      if (kDebugMode) {
        debugPrint('Table $tableName cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error clearing table $tableName: $e');
      }
      rethrow;
    }
  }

  /// Get count of records in each table for debugging
  Future<Map<String, int>> getTableCounts() async {
    try {
      final Map<String, int> counts = <String, int>{};
      
      counts['inventory_line'] = (await database.select(database.inventoryLine).get()).length;
      counts['category'] = (await database.select(database.categoryTable).get()).length;
      counts['sub_category'] = (await database.select(database.subCategory).get()).length;
      counts['suppliers'] = (await database.select(database.suppliers).get()).length;
      counts['colors'] = (await database.select(database.inventoryColors).get()).length;
      counts['sizes'] = (await database.select(database.inventorySizes).get()).length;
      counts['season'] = (await database.select(database.season).get()).length;
      counts['locations'] = (await database.select(database.inventoryLocations).get()).length;
      
      return counts;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error getting table counts: $e');
      }
      rethrow;
    }
  }
}