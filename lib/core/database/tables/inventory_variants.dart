import 'package:drift/drift.dart';

import '../../enums/status_type.dart';

class InventoryVariants extends Table {
  TextColumn get variantId => text()();
  TextColumn get inventoryId => text()();
  TextColumn get businessId => text()();
  TextColumn get colorId => text().nullable()();
  TextColumn get sizeId => text().nullable()();
  // Variant Identification
  TextColumn get variantSku => text()();
  TextColumn get variantBarcode => text().nullable()();
  TextColumn get variantName => text()(); // Generated: "Product Name - Red - Large"
  TextColumn get variantCode => text()(); // Short variant identifier
  // Pricing Adjustments
  RealColumn get costPriceAdjustment => real().withDefault(const Constant<double>(0.00))();
  RealColumn get priceAdjustment => real().withDefault(const Constant<double>(0.00))();
  RealColumn get finalCostPrice => real().nullable()(); // Generated field
  RealColumn get finalRetailPrice => real().nullable()(); // Generated field
  // Variant-Specific Information
  TextColumn get variantDescription => text().nullable()();
  TextColumn get variantSpecifications => text().nullable()(); // JSON
  TextColumn get variantImages => text().nullable()(); // JSON array of variant-specific images
  RealColumn get weightAdjustment => real().withDefault(const Constant<double>(0.000))();
  TextColumn get dimensionAdjustments => text().nullable()(); // JSON L/W/H adjustments
  // Inventory Settings
  IntColumn get minimumStockLevel => integer().withDefault(const Constant<int>(0))();
  IntColumn get reorderLevel => integer().withDefault(const Constant<int>(0))();
  IntColumn get maximumStockLevel => integer().nullable()();
  // Availability
  BoolColumn get isDefaultVariant => boolean().withDefault(const Constant<bool>(false))();
  BoolColumn get isAvailableOnline => boolean().withDefault(const Constant<bool>(true))();
  BoolColumn get isAvailableInStore => boolean().withDefault(const Constant<bool>(true))();
  DateTimeColumn get availabilityDate => dateTime().nullable()(); // When variant becomes available
  DateTimeColumn get discontinueDate => dateTime().nullable()(); // When to stop selling
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{variantId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{variantSku},
        <Column<Object>>{variantBarcode},
        <Column<Object>>{inventoryId, colorId, sizeId},
      ];
}