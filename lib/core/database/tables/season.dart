import 'package:drift/drift.dart';

import '../../enums/status_type.dart';

class Season extends Table {
  TextColumn get seasonId => text()();
  TextColumn get businessId => text()();
  TextColumn get seasonName => text()();
  TextColumn get seasonCode => text()();
  TextColumn get seasonDescription => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get isCurrentSeason => boolean().withDefault(const Constant<bool>(false))();
  TextColumn get marketingThemes => text().nullable()(); // JSON array - colors, styles, themes
  TextColumn get targetDemographics => text().nullable()(); // JSON array
  RealColumn get seasonalMarkupPercentage => real().nullable()();
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{seasonId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, seasonCode},
      ];
}