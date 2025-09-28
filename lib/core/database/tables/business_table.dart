import 'package:drift/drift.dart';
import '../../enums/status_type.dart';

@DataClassName('BusinessTableData')
class BusinessTable extends Table {
  @override
  String get tableName => 'business';

  TextColumn get businessId => text().named('business_id')();
  TextColumn get businessName => text().named('business_name')();
  TextColumn get businessCode => text().named('business_code').nullable()();
  TextColumn get businessType => text().named('business_type').nullable()();
  TextColumn get taxNumber => text().named('tax_number').nullable()();
  TextColumn get registrationNumber => text().named('registration_number').nullable()();
  
  // Contact Information
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get website => text().nullable()();
  
  // Address Information
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get postalCode => text().named('postal_code').nullable()();
  TextColumn get country => text().nullable()();
  
  // Business Configuration
  TextColumn get defaultCurrency => text().named('default_currency').withDefault(const Constant<String>('PKR'))();
  TextColumn get defaultTimezone => text().named('default_timezone').withDefault(const Constant<String>('Asia/Karachi'))();
  TextColumn get businessLogo => text().named('business_logo').nullable()();
  BoolColumn get isActive => boolean().named('is_active').withDefault(const Constant<bool>(true))();
  
  // Subscription and limits
  IntColumn get maxBranches => integer().named('max_branches').withDefault(const Constant<int>(1))();
  IntColumn get maxUsers => integer().named('max_users').withDefault(const Constant<int>(5))();
  DateTimeColumn get subscriptionExpiresAt => dateTime().named('subscription_expires_at').nullable()();
  
  // Status and audit fields
  TextColumn get status => textEnum<StatusType>().withDefault(const Constant<String>('active'))();
  TextColumn get createdBy => text().named('created_by').nullable()();
  TextColumn get updatedBy => text().named('updated_by').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();
  
  // Local sync fields
  TextColumn get syncStatus => text().named('sync_status').nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{businessId};
  
  @override
  List<String> get customConstraints => <String>[
    'UNIQUE(business_code)',
  ];
}