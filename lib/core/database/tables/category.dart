import 'package:drift/drift.dart';

import '../../enums/placement_type.dart';
import '../../enums/status_type.dart';

class CategoryTable extends Table {
  TextColumn get categoryId => text()();
  TextColumn get businessId => text()();
  TextColumn get categoryCode => text()();
  TextColumn get categoryName => text()();
  TextColumn get categoryDescription => text().nullable()();
  TextColumn get parentCategoryId => text().nullable()();
  TextColumn get categoryImageUrl => text().nullable()();
  TextColumn get seoSlug => text().nullable()();
  TextColumn get metaTitle => text().nullable()();
  TextColumn get metaDescription => text().nullable()();
  TextColumn get codePlacement => textEnum<PlacementType>().withDefault(const Constant<String>('pre'))();
  IntColumn get sortOrder => integer().withDefault(const Constant<int>(0))();
  BoolColumn get isFeatured => boolean().withDefault(const Constant<bool>(false))();
  RealColumn get commissionRate => real().nullable()();
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{categoryId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, categoryCode},
        <Column<Object>>{businessId, seoSlug},
      ];
}