import 'package:drift/drift.dart';

import '../../enums/location_type.dart';
import '../../enums/status_type.dart';

class InventoryLocations extends Table {
  TextColumn get locationId => text()();
  TextColumn get businessId => text()();
  TextColumn get branchId => text()();
  TextColumn get locationName => text()();
  TextColumn get locationCode => text()();
  TextColumn get locationType => textEnum<LocationType>()();
  TextColumn get parentLocationId => text().nullable()();
  TextColumn get aisle => text().nullable()();
  TextColumn get shelf => text().nullable()();
  TextColumn get bin => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get maxCapacity => integer().nullable()();
  IntColumn get currentCapacity => integer().withDefault(const Constant<int>(0))();
  BoolColumn get isSellableLocation => boolean().withDefault(const Constant<bool>(true))();
  BoolColumn get requiresCounting => boolean().withDefault(const Constant<bool>(true))();
  BoolColumn get temperatureControlled => boolean().withDefault(const Constant<bool>(false))();
  TextColumn get securityLevel => text().withDefault(const Constant<String>('standard'))(); // standard, high, restricted
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{locationId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{branchId, locationCode},
      ];
}