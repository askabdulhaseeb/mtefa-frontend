# Drift (SQLite) Setup Guide for MTEFA POS System

This guide explains the Drift (SQLite) implementation for the MTEFA POS system following Clean Architecture principles.

## 📁 Project Structure

```
lib/
├── core/
│   ├── database/
│   │   ├── database_helper.dart          # Database connection & raw SQL
│   │   ├── database_initializer.dart     # Database setup & lifecycle
│   │   ├── tables/                       # Drift table definitions
│   │   │   ├── user_table.dart
│   │   │   ├── business_table.dart
│   │   │   ├── inventory_table.dart
│   │   │   ├── category_table.dart
│   │   │   ├── subcategory_table.dart
│   │   │   ├── cashier_session_table.dart
│   │   │   ├── cash_movement_table.dart
│   │   │   ├── sale_table.dart
│   │   │   └── sale_item_table.dart
│   │   └── dao/                          # Data Access Objects (optional)
│   │       ├── user_dao.dart
│   │       └── inventory_dao.dart
│   └── entities/
│       └── pagination_info.dart
└── data/
    └── sources/
        └── local/
            └── local_database_service.dart # Service layer for database operations
```

## 🚀 Quick Start

### 1. Initialize Database in main.dart

```dart
import 'package:flutter/material.dart';
import 'core/database/database_initializer.dart';
import 'core/config/api_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize API configuration
  await ApiConfig.initialize(environment: 'development');
  
  // Initialize database
  await DatabaseInitializer.instance.initialize();
  
  runApp(MyApp());
}
```

### 2. Use in Your Services

```dart
import 'package:get_it/get_it.dart';
import '../core/database/local_database_service.dart';

class InventoryRepository {
  final LocalDatabaseService _localDb = GetIt.instance<LocalDatabaseService>();
  
  Future<void> createProduct(Product product) async {
    await _localDb.insertInventoryLine(
      id: product.id,
      sku: product.sku,
      name: product.name,
      unitPrice: product.price,
      quantity: product.quantity,
    );
  }
  
  Future<List<Product>> searchProducts(String query) async {
    final result = await _localDb.searchInventoryLines(search: query);
    return result['items'].map((item) => Product.fromMap(item)).toList();
  }
}
```

## 📋 Database Schema

### Core Tables

#### Users
- `id` (TEXT PRIMARY KEY) - UUID
- `email` (TEXT UNIQUE) - User email
- `full_name` (TEXT) - User's full name
- `role` (TEXT) - USER, BUSINESS_OWNER, ADMIN, SUPER_ADMIN
- `status` (TEXT) - ACTIVE, INACTIVE, SUSPENDED
- `email_verified` (BOOLEAN) - Email verification status
- Standard timestamps

#### Businesses
- `business_id` (TEXT PRIMARY KEY) - UUID
- `bku_id` (TEXT UNIQUE) - Business unique identifier
- `name` (TEXT) - Business name
- `industry` (TEXT) - Business type
- `status` (TEXT) - ACTIVE, INACTIVE, SUSPENDED
- `verification_status` (TEXT) - PENDING, VERIFIED, REJECTED
- Standard timestamps

#### Inventory Lines
- `id` (TEXT PRIMARY KEY) - UUID
- `sku` (TEXT UNIQUE) - Stock keeping unit
- `name` (TEXT) - Product name
- `quantity` (INTEGER) - Current stock quantity
- `unit_price` (REAL) - Selling price
- `cost_price` (REAL) - Cost price
- `min_stock_level` (INTEGER) - Low stock alert level
- Standard timestamps

#### Categories & Subcategories
- Hierarchical structure: InventoryLine → Categories → Subcategories
- Each level has display ordering and metadata support

#### Cashier Sessions
- `session_id` (TEXT PRIMARY KEY) - UUID
- `session_number` (TEXT UNIQUE) - Human-readable identifier
- `cashier_id` (TEXT FK) - Reference to user
- `business_id` (TEXT FK) - Reference to business
- Opening/closing cash amounts and reconciliation
- Standard timestamps

#### Sales & Sale Items
- Sales with payment method support (cash, card, mobile, mixed)
- Line-item details with tax and discount calculations
- Profit tracking per item

## 🔧 Key Features

### 1. Pagination Support
```dart
final result = await localDb.searchInventoryLines(
  search: 'coffee',
  page: 1,
  limit: 20,
);

final items = result['items'];
final paginationInfo = PaginationInfo.fromJson(result['pagination']);
```

### 2. Advanced Search
```dart
final result = await localDb.searchInventoryLines(
  search: 'coffee',        // Search in name, SKU, description
  status: 'active',        // Filter by status
  lowStock: true,          // Show only low stock items
);
```

### 3. Database Statistics
```dart
final stats = await DatabaseInitializer.instance.getDatabaseInfo();
print('Total inventory items: ${stats['totalInventoryItems']}');
print('Database size: ${stats['databaseSizeFormatted']}');
```

### 4. Transaction Support
```dart
// Raw SQL transactions are supported through DatabaseHelper
await DatabaseHelper.instance.rawExecute('BEGIN TRANSACTION');
try {
  // Multiple operations
  await localDb.insertSale(...);
  await localDb.insertSaleItem(...);
  await localDb.updateInventoryQuantity(...);
  
  await DatabaseHelper.instance.rawExecute('COMMIT');
} catch (e) {
  await DatabaseHelper.instance.rawExecute('ROLLBACK');
  rethrow;
}
```

## 🎯 Usage Examples

### Cashier Session Management
```dart
// Start session
await localDb.insertCashierSession(
  id: 'session_123',
  sessionNumber: 'CS-2024-001-001',
  registerId: 'register_1',
  cashierId: 'user_456',
  businessId: 'business_789',
  openingCashAmount: 500.0,
);

// Get active session
final session = await localDb.getActiveSessionForCashier('user_456');

// Close session
await localDb.closeCashierSession(
  sessionId: 'session_123',
  closingCashAmount: 750.0,
  expectedCashAmount: 745.0,
  reconciliationStatus: 'over',
);
```

### Sales Processing
```dart
// Create sale
await localDb.insertSale(
  id: 'sale_123',
  saleNumber: 'S001-20241231',
  sessionId: 'session_123',
  cashierId: 'user_456',
  subtotal: 100.0,
  taxAmount: 8.5,
  totalAmount: 108.5,
  paymentMethod: 'cash',
  cashAmount: 108.5,
);

// Add sale items
await localDb.insertSaleItem(
  id: 'item_123',
  saleId: 'sale_123',
  inventoryLineId: 'product_456',
  productSku: 'COFFEE-001',
  productName: 'Coffee',
  quantity: 2,
  unitPrice: 50.0,
  lineSubtotal: 100.0,
  lineTotal: 108.5,
);

// Update inventory
await localDb.updateInventoryQuantity('product_456', newQuantity);
```

### Inventory Management
```dart
// Add product
await localDb.insertInventoryLine(
  id: 'product_123',
  sku: 'COFFEE-001',
  name: 'Premium Coffee',
  quantity: 100,
  unitPrice: 50.0,
  costPrice: 30.0,
  minStockLevel: 10,
);

// Search products
final result = await localDb.searchInventoryLines(
  search: 'coffee',
  page: 1,
  limit: 10,
);

// Get low stock items
final lowStock = await localDb.searchInventoryLines(
  lowStock: true,
  limit: 50,
);
```

## 🛠 Maintenance & Utilities

### Database Maintenance
```dart
// Perform maintenance (vacuum, optimize)
await DatabaseInitializer.instance.performMaintenance();

// Get database info
final info = await DatabaseInitializer.instance.getDatabaseInfo();

// Clear all data (for testing)
await DatabaseInitializer.instance.clearAllData();

// Delete database completely
await DatabaseInitializer.instance.deleteDatabase();
```

### Development & Testing
```dart
// In tests or development
await DatabaseInitializer.instance.deleteDatabase();
await DatabaseInitializer.instance.initialize();
```

## 🔍 Performance Optimizations

1. **Indexes**: Automatically created for frequently queried fields
2. **WAL Mode**: Enabled for better concurrent access
3. **Pagination**: All list queries support pagination
4. **Optimized Queries**: Efficient search with multiple filters
5. **Connection Pooling**: Single connection reused across app

## 🚨 Important Notes

1. **Clean Architecture**: Database layer is separated from business logic
2. **Type Safety**: All operations use typed parameters
3. **Error Handling**: Comprehensive error handling throughout
4. **Performance**: Optimized for mobile device constraints
5. **Offline Support**: Full offline functionality with sync capabilities
6. **Security**: No sensitive data stored without encryption
7. **Testing**: Easy to mock and test with dependency injection

## 🔄 Migration Strategy

For future schema changes:
1. Update table definitions
2. Increment schema version in `DatabaseInitializer`
3. Add migration logic in `createTables()` method
4. Test migration thoroughly

## 📱 Integration with Clean Architecture

```
Presentation Layer (UI)
    ↓
Business Logic Layer (UseCases/Providers)
    ↓
Data Layer (Repositories)
    ↓
Local Data Source (LocalDatabaseService)
    ↓
Database Helper (Raw SQLite)
```

This setup ensures:
- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Easy to mock and test each layer
- **Maintainability**: Clear structure for future changes
- **Performance**: Optimized for mobile constraints
- **Offline-First**: Full offline functionality with sync capabilities

The database is now ready for your Flutter POS application with comprehensive offline support and clean architecture principles!