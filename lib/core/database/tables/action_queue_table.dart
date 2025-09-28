import 'package:drift/drift.dart';
import '../../enums/audit_action.dart';

@DataClassName('ActionQueueTableData')
class ActionQueueTable extends Table {
  @override
  String get tableName => 'action_queue';

  TextColumn get actionId => text().named('action_id')();
  TextColumn get businessId => text().named('business_id')();
  TextColumn get userId => text().named('user_id').nullable()();
  TextColumn get systemId => text().named('system_id').nullable()();
  
  // Action Details
  TextColumn get actionType => textEnum<AuditAction>().named('action_type')();
  TextColumn get entityType => text().named('entity_type')(); // table name
  TextColumn get entityId => text().named('entity_id')(); // record ID
  TextColumn get actionData => text().named('action_data')(); // JSON payload
  TextColumn get changeDetails => text().named('change_details').nullable()(); // JSON diff
  
  // Sync Status
  TextColumn get syncStatus => text().named('sync_status').withDefault(const Constant<String>('pending'))();
  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().named('synced_at').nullable()();
  IntColumn get retryCount => integer().named('retry_count').withDefault(const Constant<int>(0))();
  IntColumn get maxRetries => integer().named('max_retries').withDefault(const Constant<int>(3))();
  
  // Error Handling
  TextColumn get lastError => text().named('last_error').nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().named('last_attempt_at').nullable()();
  DateTimeColumn get nextRetryAt => dateTime().named('next_retry_at').nullable()();
  
  // Priority and Context
  IntColumn get priority => integer().withDefault(const Constant<int>(1))(); // 1=high, 5=low
  TextColumn get batchId => text().named('batch_id').nullable()(); // For grouping related actions
  BoolColumn get requiresOnline => boolean().named('requires_online').withDefault(const Constant<bool>(true))();
  
  // Metadata
  TextColumn get metadata => text().nullable()(); // Additional JSON context
  TextColumn get deviceInfo => text().named('device_info').nullable()(); // Device that created the action

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{actionId};
  
  @override
  List<String> get customConstraints => <String>[
    'INDEX idx_action_queue_business ON action_queue(business_id)',
    'INDEX idx_action_queue_sync_status ON action_queue(sync_status)',
    'INDEX idx_action_queue_created ON action_queue(created_at)',
    'INDEX idx_action_queue_priority ON action_queue(priority, created_at)',
    'INDEX idx_action_queue_entity ON action_queue(entity_type, entity_id)',
    'INDEX idx_action_queue_retry ON action_queue(next_retry_at, retry_count)',
  ];
}