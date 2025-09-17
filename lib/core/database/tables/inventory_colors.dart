import 'package:drift/drift.dart';

import '../../enums/status_type.dart';

class InventoryColors extends Table {
  TextColumn get colorId => text()();
  TextColumn get businessId => text()();
  TextColumn get colorName => text()();
  TextColumn get colorCode => text()(); // SKU code component
  TextColumn get hexColor => text().nullable()(); // #FFFFFF format
  TextColumn get rgbColor => text().nullable()(); // rgb(255,255,255) format
  TextColumn get pantoneCode => text().nullable()(); // Pantone color matching
  TextColumn get supplierColorCode => text().nullable()(); // Vendor's color reference
  TextColumn get colorFamily => text().nullable()(); // Red, Blue, Green, etc.
  BoolColumn get isSeasonal => boolean().withDefault(const Constant<bool>(false))();
  TextColumn get seasonIds => text().nullable()(); // JSON array of applicable season IDs
  IntColumn get displayOrder => integer().withDefault(const Constant<int>(0))();
  TextColumn get colorImageUrl => text().nullable()(); // Sample color swatch image
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{colorId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, colorCode},
      ];
}