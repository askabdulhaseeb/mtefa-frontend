import 'package:drift/drift.dart';
import '../../enums/status_type.dart';
import 'business_table.dart';
import 'user_roles_table.dart';
import 'users_table.dart';

@DataClassName('BusinessUsersTableData')
class BusinessUsersTable extends Table {
  @override
  String get tableName => 'business_users';

  TextColumn get businessUserId => text().named('business_user_id')();
  TextColumn get businessId => text().named('business_id').references(BusinessTable, #businessId)();
  TextColumn get userId => text().named('user_id').references(Users, #id)();
  TextColumn get roleId => text().named('role_id').references(UserRolesTable, #roleId)();
  TextColumn get roleName => text().named('role_name')(); // Denormalized for quick access
  TextColumn get businessName => text().named('business_name').nullable()(); // Denormalized for quick access
  
  // Assignment Details
  TextColumn get assignedBranches => text().named('assigned_branches').nullable()(); // JSON array of branch IDs
  TextColumn get customPermissions => text().named('custom_permissions').nullable()(); // JSON array of additional permissions
  DateTimeColumn get employmentStartDate => dateTime().named('employment_start_date').nullable()();
  DateTimeColumn get employmentEndDate => dateTime().named('employment_end_date').nullable()();
  
  // Business Relationship
  BoolColumn get isPrimaryBusiness => boolean().named('is_primary_business').withDefault(const Constant<bool>(false))();
  BoolColumn get hasDirectDepositAccess => boolean().named('has_direct_deposit_access').withDefault(const Constant<bool>(false))();
  BoolColumn get canSwitchBranches => boolean().named('can_switch_branches').withDefault(const Constant<bool>(true))();
  
  // Salary/Commission Information
  RealColumn get hourlyRate => real().named('hourly_rate').nullable()();
  RealColumn get salaryAmount => real().named('salary_amount').nullable()();
  RealColumn get commissionRate => real().named('commission_rate').nullable()(); // Percentage
  TextColumn get paymentFrequency => text().named('payment_frequency').nullable()(); // weekly, biweekly, monthly
  
  // Access Control
  DateTimeColumn get lastLoginAt => dateTime().named('last_login_at').nullable()();
  IntColumn get loginCount => integer().named('login_count').withDefault(const Constant<int>(0))();
  BoolColumn get isActive => boolean().named('is_active').withDefault(const Constant<bool>(true))();
  DateTimeColumn get passwordExpiresAt => dateTime().named('password_expires_at').nullable()();
  
  // Status and audit fields
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().named('created_by').nullable()();
  TextColumn get updatedBy => text().named('updated_by').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();
  
  // Local sync fields
  TextColumn get syncStatus => text().named('sync_status').nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{businessUserId};
  
  @override
  List<String> get customConstraints => <String>[
    'UNIQUE(business_id, user_id)',
  ];
}