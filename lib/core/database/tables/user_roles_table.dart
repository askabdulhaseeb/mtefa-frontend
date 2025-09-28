import 'package:drift/drift.dart';
import '../../enums/status_type.dart';
import '../../enums/user_role.dart';
import 'business_table.dart';

@DataClassName('UserRolesTableData')
class UserRolesTable extends Table {
  @override
  String get tableName => 'user_roles';

  TextColumn get roleId => text().named('role_id')();
  TextColumn get businessId => text().named('business_id').references(BusinessTable, #businessId)();
  TextColumn get roleName => text().named('role_name')();
  TextColumn get roleCode => text().named('role_code').nullable()();
  TextColumn get roleType => textEnum<UserRole>().named('role_type').withDefault(const Constant<String>('cashier'))();
  TextColumn get description => text().nullable()();
  
  // Permissions Configuration
  TextColumn get permissions => text().nullable()(); // JSON array of permission strings
  BoolColumn get isSystemRole => boolean().named('is_system_role').withDefault(const Constant<bool>(false))();
  BoolColumn get isCustomizable => boolean().named('is_customizable').withDefault(const Constant<bool>(true))();
  
  // Hierarchy
  IntColumn get hierarchyLevel => integer().named('hierarchy_level').withDefault(const Constant<int>(1))();
  TextColumn get parentRoleId => text().named('parent_role_id').nullable()();
  
  // Access Control
  BoolColumn get canViewAllTransactions => boolean().named('can_view_all_transactions').withDefault(const Constant<bool>(false))();
  BoolColumn get canModifyPrices => boolean().named('can_modify_prices').withDefault(const Constant<bool>(false))();
  BoolColumn get canProcessReturns => boolean().named('can_process_returns').withDefault(const Constant<bool>(false))();
  BoolColumn get canManageUsers => boolean().named('can_manage_users').withDefault(const Constant<bool>(false))();
  BoolColumn get canAccessReports => boolean().named('can_access_reports').withDefault(const Constant<bool>(false))();
  BoolColumn get canManageInventory => boolean().named('can_manage_inventory').withDefault(const Constant<bool>(false))();
  
  // Monetary Limits
  RealColumn get discountLimit => real().named('discount_limit').nullable()(); // Max discount percentage
  RealColumn get transactionLimit => real().named('transaction_limit').nullable()(); // Max transaction amount
  RealColumn get refundLimit => real().named('refund_limit').nullable()(); // Max refund amount
  
  // Status and audit fields
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().named('created_by').nullable()();
  TextColumn get updatedBy => text().named('updated_by').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();
  
  // Local sync fields
  TextColumn get syncStatus => text().named('sync_status').nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{roleId};
  
  @override
  List<String> get customConstraints => <String>[
    'UNIQUE(business_id, role_code)',
  ];
}