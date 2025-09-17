import 'package:drift/drift.dart';

import '../../enums/status_type.dart';

class InventorySizes extends Table {
  TextColumn get sizeId => text()();
  TextColumn get businessId => text()();
  TextColumn get subCategoryId => text().nullable()();
  TextColumn get sizeName => text()(); // S, M, L or 32, 34, 36
  TextColumn get sizeCode => text()(); // SKU component
  TextColumn get sizeType => text()(); // clothing, shoes, generic, numeric
  TextColumn get sizeSystem => text().nullable()(); // US, EU, UK, etc.
  TextColumn get sizeMeasurements => text().nullable()(); // JSON detailed measurements
  IntColumn get sizeChartPosition => integer().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant<int>(0))();
  TextColumn get equivalentSizes => text().nullable()(); // JSON size conversions
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{sizeId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, subCategoryId, sizeCode},
      ];
}