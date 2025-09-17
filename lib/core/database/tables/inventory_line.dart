import 'package:drift/drift.dart';

import '../../enums/placement_type.dart';
import '../../enums/status_type.dart';

class InventoryLine extends Table {
  TextColumn get inventoryLineId => text()();
  TextColumn get businessId => text()();
  TextColumn get lineCode => text()();
  TextColumn get lineName => text()();
  TextColumn get lineDescription => text().nullable()();
  TextColumn get linePlacement => textEnum<PlacementType>().withDefault(const Constant<String>('pre'))();
  TextColumn get parentLineId => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant<int>(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant<bool>(true))();
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{inventoryLineId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, lineCode},
      ];
}