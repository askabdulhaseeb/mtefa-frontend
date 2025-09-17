import 'package:drift/drift.dart';

import '../../enums/status_type.dart';

class Suppliers extends Table {
  TextColumn get supplierId => text()();
  TextColumn get businessId => text()();
  TextColumn get supplierCode => text()();
  TextColumn get supplierName => text()();
  TextColumn get supplierType => text().nullable()(); // manufacturer, distributor, wholesaler
  TextColumn get contactPerson => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get taxNumber => text().nullable()();
  TextColumn get paymentTerms => text().nullable()(); // Net 30, COD, 2/10 Net 30
  RealColumn get creditLimit => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant<String>('PKR'))();
  IntColumn get leadTimeDays => integer().nullable()();
  RealColumn get minimumOrderAmount => real().nullable()();
  TextColumn get shippingMethods => text().nullable()(); // JSON array of shipping methods
  RealColumn get qualityRating => real().nullable()(); // 1.00 to 5.00
  RealColumn get deliveryRating => real().nullable()();
  RealColumn get priceRating => real().nullable()();
  BoolColumn get preferredSupplier => boolean().withDefault(const Constant<bool>(false))();
  DateTimeColumn get contractStartDate => dateTime().nullable()();
  DateTimeColumn get contractEndDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  // Local sync fields
  TextColumn get syncStatus => text().withDefault(const Constant<String>('pending'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{supplierId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{businessId, supplierCode},
      ];
}