import 'package:drift/drift.dart';

import '../../enums/placement_type.dart';
import '../../enums/status_type.dart';

class SubCategory extends Table {
  TextColumn get subCategoryId => text()();
  TextColumn get categoryId => text()();
  TextColumn get businessId => text()();
  TextColumn get subCategoryCode => text()();
  TextColumn get subCategoryName => text()();
  TextColumn get subCategoryDescription => text().nullable()();
  TextColumn get codePlacement => textEnum<PlacementType>().withDefault(const Constant<String>('pre'))();
  IntColumn get counter => integer().nullable()(); // Auto-incremented within category
  IntColumn get sortOrder => integer().withDefault(const Constant<int>(0))();
  TextColumn get subCategoryImageUrl => text().nullable()();
  TextColumn get sizeChartUrl => text().nullable()(); // For clothing categories
  TextColumn get careInstructions => text().nullable()(); // For applicable items
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{subCategoryId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{categoryId, subCategoryCode},
      ];
}