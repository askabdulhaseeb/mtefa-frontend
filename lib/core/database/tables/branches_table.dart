import 'package:drift/drift.dart';
import '../../enums/status_type.dart';
import '../../enums/branch_type.dart';
import 'business_table.dart';

@DataClassName('BranchesTableData')
class BranchesTable extends Table {
  @override
  String get tableName => 'branches';

  TextColumn get branchId => text().named('branch_id')();
  TextColumn get businessId => text().named('business_id').references(BusinessTable, #businessId)();
  TextColumn get branchName => text().named('branch_name')();
  TextColumn get branchCode => text().named('branch_code').nullable()();
  TextColumn get branchType => textEnum<BranchType>().named('branch_type').withDefault(const Constant<String>('physical'))();
  
  // Location Information
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get postalCode => text().named('postal_code').nullable()();
  TextColumn get country => text().nullable()();
  
  // Contact Information
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get managerName => text().named('manager_name').nullable()();
  TextColumn get managerPhone => text().named('manager_phone').nullable()();
  
  // Operating Information
  TextColumn get timezone => text().withDefault(const Constant<String>('Asia/Karachi'))();
  TextColumn get currency => text().withDefault(const Constant<String>('PKR'))();
  TextColumn get openingHours => text().named('opening_hours').nullable()(); // JSON format
  BoolColumn get isActive => boolean().named('is_active').withDefault(const Constant<bool>(true))();
  BoolColumn get allowsOnlineOrders => boolean().named('allows_online_orders').withDefault(const Constant<bool>(false))();
  
  // Configuration
  IntColumn get maxCashRegisters => integer().named('max_cash_registers').withDefault(const Constant<int>(3))();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  
  // Status and audit fields
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().named('created_by').nullable()();
  TextColumn get updatedBy => text().named('updated_by').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();
  
  // Local sync fields
  TextColumn get syncStatus => text().named('sync_status').nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{branchId};
  
  @override
  List<String> get customConstraints => <String>[
    'UNIQUE(business_id, branch_code)',
  ];
}