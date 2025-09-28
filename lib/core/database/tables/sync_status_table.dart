import 'package:drift/drift.dart';

@DataClassName('SyncStatusTableData')
class SyncStatusTable extends Table {
  @override
  String get tableName => 'sync_status';

  TextColumn get syncId => text().named('sync_id')();
  TextColumn get businessId => text().named('business_id')();
  TextColumn get entityType => text().named('entity_type')(); // table name
  
  // Sync Timestamps
  DateTimeColumn get lastFullSync => dateTime().named('last_full_sync').nullable()();
  DateTimeColumn get lastIncrementalSync => dateTime().named('last_incremental_sync').nullable()();
  DateTimeColumn get lastSuccessfulSync => dateTime().named('last_successful_sync').nullable()();
  DateTimeColumn get nextScheduledSync => dateTime().named('next_scheduled_sync').nullable()();
  
  // Sync Configuration
  IntColumn get syncIntervalMinutes => integer().named('sync_interval_minutes').withDefault(const Constant<int>(15))();
  BoolColumn get autoSyncEnabled => boolean().named('auto_sync_enabled').withDefault(const Constant<bool>(true))();
  BoolColumn get syncOnlyOnWifi => boolean().named('sync_only_on_wifi').withDefault(const Constant<bool>(false))();
  
  // Sync Statistics
  IntColumn get totalRecordsToSync => integer().named('total_records_to_sync').withDefault(const Constant<int>(0))();
  IntColumn get recordsSynced => integer().named('records_synced').withDefault(const Constant<int>(0))();
  IntColumn get syncFailures => integer().named('sync_failures').withDefault(const Constant<int>(0))();
  IntColumn get consecutiveFailures => integer().named('consecutive_failures').withDefault(const Constant<int>(0))();
  
  // Current Sync Status
  TextColumn get currentStatus => text().named('current_status').withDefault(const Constant<String>('idle'))(); // idle, syncing, failed, success
  RealColumn get syncProgress => real().named('sync_progress').withDefault(const Constant<double>(0.0))(); // 0.0 to 1.0
  TextColumn get currentOperation => text().named('current_operation').nullable()(); // Current sync operation description
  
  // Error Information
  TextColumn get lastError => text().named('last_error').nullable()();
  DateTimeColumn get lastErrorAt => dateTime().named('last_error_at').nullable()();
  IntColumn get errorCode => integer().named('error_code').nullable()();
  
  // Performance Metrics
  IntColumn get lastSyncDurationMs => integer().named('last_sync_duration_ms').nullable()();
  IntColumn get averageSyncDurationMs => integer().named('average_sync_duration_ms').nullable()();
  RealColumn get avgRecordsPerSecond => real().named('avg_records_per_second').nullable()();
  
  // Network and Device Info
  TextColumn get lastSyncNetworkType => text().named('last_sync_network_type').nullable()(); // wifi, mobile, unknown
  TextColumn get deviceId => text().named('device_id').nullable()();
  TextColumn get appVersion => text().named('app_version').nullable()();
  
  // Audit
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{syncId};
  
  @override
  List<String> get customConstraints => <String>[
    'UNIQUE(business_id, entity_type)',
    'INDEX idx_sync_status_business ON sync_status(business_id)',
    'INDEX idx_sync_status_entity ON sync_status(entity_type)',
    'INDEX idx_sync_status_next_sync ON sync_status(next_scheduled_sync)',
    'INDEX idx_sync_status_current ON sync_status(current_status)',
    'INDEX idx_sync_status_auto_sync ON sync_status(auto_sync_enabled, next_scheduled_sync)',
  ];
}