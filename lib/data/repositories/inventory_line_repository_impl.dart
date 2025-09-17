import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/status_type.dart';
import '../../core/enums/placement_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/inventory_line_entity.dart';
import '../../domain/repositories/inventory_line_repository.dart';

class InventoryLineRepositoryImpl implements InventoryLineRepository {
  InventoryLineRepositoryImpl({required this.database});

  final AppDatabase database;

  @override
  Future<DataState<List<InventoryLineEntity>>> getAllInventoryLines() async {
    try {
      final List<InventoryLineData> lines = await database.select(database.inventoryLine).get();
      final List<InventoryLineEntity> entities = lines.map(_toEntity).toList();
      return DataSuccess<List<InventoryLineEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventoryLineEntity>>(
        error: 'Failed to get inventory lines: ${e.toString()}',
        errorCode: 'GET_LINES_FAILED',
      );
    }
  }

  @override
  Future<DataState<InventoryLineEntity?>> getInventoryLineById(String lineId) async {
    try {
      final InventoryLineData? line = await (database.select(database.inventoryLine)
            ..where((tbl) => tbl.inventoryLineId.equals(lineId)))
          .getSingleOrNull();
      
      final InventoryLineEntity? entity = line != null ? _toEntity(line) : null;
      return DataSuccess<InventoryLineEntity?>(entity);
    } catch (e) {
      return DataFailed<InventoryLineEntity?>(
        error: 'Failed to get inventory line: ${e.toString()}',
        errorCode: 'GET_LINE_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<InventoryLineEntity>>> getInventoryLinesByBusinessId(String businessId) async {
    try {
      final List<InventoryLineData> lines = await (database.select(database.inventoryLine)
            ..where((tbl) => tbl.businessId.equals(businessId)))
          .get();
      
      final List<InventoryLineEntity> entities = lines.map(_toEntity).toList();
      return DataSuccess<List<InventoryLineEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventoryLineEntity>>(
        error: 'Failed to get inventory lines by business: ${e.toString()}',
        errorCode: 'GET_LINES_BY_BUSINESS_FAILED',
      );
    }
  }

  @override
  Future<DataState<InventoryLineEntity>> createInventoryLine(InventoryLineEntity inventoryLine) async {
    try {
      final InventoryLineCompanion companion = _toCompanion(inventoryLine);
      await database.into(database.inventoryLine).insert(companion);
      return DataSuccess<InventoryLineEntity>(inventoryLine);
    } catch (e) {
      return DataFailed<InventoryLineEntity>(
        error: 'Failed to create inventory line: ${e.toString()}',
        errorCode: 'CREATE_LINE_FAILED',
      );
    }
  }

  @override
  Future<DataState<InventoryLineEntity>> updateInventoryLine(InventoryLineEntity inventoryLine) async {
    try {
      final InventoryLineCompanion companion = _toCompanion(inventoryLine.copyWith(
        updatedAt: DateTime.now(),
      ));
      
      await (database.update(database.inventoryLine)
            ..where((tbl) => tbl.inventoryLineId.equals(inventoryLine.inventoryLineId)))
          .write(companion);
      
      return DataSuccess<InventoryLineEntity>(inventoryLine);
    } catch (e) {
      return DataFailed<InventoryLineEntity>(
        error: 'Failed to update inventory line: ${e.toString()}',
        errorCode: 'UPDATE_LINE_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> deleteInventoryLine(String lineId) async {
    try {
      await (database.delete(database.inventoryLine)
            ..where((tbl) => tbl.inventoryLineId.equals(lineId)))
          .go();
      
      return const DataSuccess<void>(null);
    } catch (e) {
      return DataFailed<void>(
        error: 'Failed to delete inventory line: ${e.toString()}',
        errorCode: 'DELETE_LINE_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<InventoryLineEntity>>> getActiveInventoryLines() async {
    try {
      final List<InventoryLineData> lines = await (database.select(database.inventoryLine)
            ..where((tbl) => tbl.status.equals(StatusType.active.value) & tbl.isActive.equals(true)))
          .get();
      
      final List<InventoryLineEntity> entities = lines.map(_toEntity).toList();
      return DataSuccess<List<InventoryLineEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventoryLineEntity>>(
        error: 'Failed to get active inventory lines: ${e.toString()}',
        errorCode: 'GET_ACTIVE_LINES_FAILED',
      );
    }
  }

  InventoryLineEntity _toEntity(InventoryLineData data) {
    return InventoryLineEntity(
      inventoryLineId: data.inventoryLineId,
      businessId: data.businessId,
      lineCode: data.lineCode,
      lineName: data.lineName,
      lineDescription: data.lineDescription,
      linePlacement: data.linePlacement,
      parentLineId: data.parentLineId,
      sortOrder: data.sortOrder,
      isActive: data.isActive,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }

  InventoryLineCompanion _toCompanion(InventoryLineEntity entity) {
    return InventoryLineCompanion(
      inventoryLineId: Value<String>(entity.inventoryLineId),
      businessId: Value<String>(entity.businessId),
      lineCode: Value<String>(entity.lineCode),
      lineName: Value<String>(entity.lineName),
      lineDescription: Value<String?>(entity.lineDescription),
      linePlacement: Value<PlacementType>(entity.linePlacement),
      parentLineId: Value<String?>(entity.parentLineId),
      sortOrder: Value<int>(entity.sortOrder),
      isActive: Value<bool>(entity.isActive),
      status: Value<StatusType>(entity.status),
      createdBy: Value<String?>(entity.createdBy),
      updatedBy: Value<String?>(entity.updatedBy),
      createdAt: Value<DateTime>(entity.createdAt),
      updatedAt: Value<DateTime>(entity.updatedAt),
      syncStatus: entity.syncStatus != null ? Value<String>(entity.syncStatus!) : const Value<String>.absent(),
    );
  }
}