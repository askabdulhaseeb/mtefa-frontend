import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/inventory_sizes_entity.dart';
import '../../domain/repositories/inventory_sizes_repository.dart';

class InventorySizesRepositoryImpl implements InventorySizesRepository {
  InventorySizesRepositoryImpl({required AppDatabase database}) : _database = database;
  final AppDatabase _database;

  @override
  Future<DataState<List<InventorySizesEntity>>> getSizes() async {
    try {
      final List<InventorySize> sizes = await _database.select(_database.inventorySizes).get();
      
      final List<InventorySizesEntity> entities = sizes.map((InventorySize size) {
        return InventorySizesEntity(
          sizeId: size.sizeId,
          businessId: size.businessId,
          subCategoryId: size.subCategoryId,
          sizeName: size.sizeName,
          sizeCode: size.sizeCode,
          sizeType: size.sizeType,
          sizeSystem: size.sizeSystem,
          sizeMeasurements: null, // TODO: Parse JSON string if needed
          sizeChartPosition: size.sizeChartPosition,
          displayOrder: size.displayOrder,
          equivalentSizes: null, // TODO: Parse JSON string if needed
          status: size.status,
          createdBy: size.createdBy,
          updatedBy: size.updatedBy,
          createdAt: size.createdAt,
          updatedAt: size.updatedAt,
          syncStatus: size.syncStatus,
        );
      }).toList();
      
      return DataSuccess<List<InventorySizesEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventorySizesEntity>>(
        error: 'Failed to fetch sizes: ${e.toString()}',
        errorCode: 'GET_SIZES_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventorySizesEntity>> getSizeById(String sizeId) async {
    try {
      final InventorySize? size = await (_database.select(_database.inventorySizes)
        ..where(($InventorySizesTable tbl) => tbl.sizeId.equals(sizeId)))
        .getSingleOrNull();
      
      if (size == null) {
        return DataFailed<InventorySizesEntity>(
          error: 'Size not found',
          errorCode: 'SIZE_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventorySizesEntity>(
        InventorySizesEntity(
          sizeId: size.sizeId,
          businessId: size.businessId,
          subCategoryId: size.subCategoryId,
          sizeName: size.sizeName,
          sizeCode: size.sizeCode,
          sizeType: size.sizeType,
          sizeSystem: size.sizeSystem,
          sizeMeasurements: null, // TODO: Parse JSON string if needed
          sizeChartPosition: size.sizeChartPosition,
          displayOrder: size.displayOrder,
          equivalentSizes: null, // TODO: Parse JSON string if needed
          status: size.status,
          createdBy: size.createdBy,
          updatedBy: size.updatedBy,
          createdAt: size.createdAt,
          updatedAt: size.updatedAt,
          syncStatus: size.syncStatus,
        ),
      );
    } catch (e) {
      return DataFailed<InventorySizesEntity>(
        error: 'Failed to fetch size: ${e.toString()}',
        errorCode: 'GET_SIZE_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventorySizesEntity>> createSize(InventorySizesEntity size) async {
    try {
      final InventorySizesCompanion companion = InventorySizesCompanion(
        sizeId: Value<String>(size.sizeId),
        businessId: Value<String>(size.businessId),
        subCategoryId: Value<String?>(size.subCategoryId),
        sizeName: Value<String>(size.sizeName),
        sizeCode: Value<String>(size.sizeCode),
        sizeType: Value<String>(size.sizeType),
        sizeSystem: Value<String?>(size.sizeSystem),
        sizeMeasurements: Value<String?>(null), // TODO: Serialize JSON if needed
        sizeChartPosition: Value<int?>(size.sizeChartPosition),
        displayOrder: Value<int>(size.displayOrder),
        equivalentSizes: Value<String?>(null), // TODO: Serialize JSON if needed
        status: Value<StatusType>(size.status),
        createdBy: Value<String?>(size.createdBy),
        updatedBy: Value<String?>(size.updatedBy),
        createdAt: Value<DateTime>(size.createdAt),
        updatedAt: Value<DateTime>(size.updatedAt),
        syncStatus: size.syncStatus != null ? Value<String>(size.syncStatus!) : const Value<String>.absent(),
      );
      
      await _database.into(_database.inventorySizes).insert(companion);
      
      return DataSuccess<InventorySizesEntity>(size);
    } catch (e) {
      return DataFailed<InventorySizesEntity>(
        error: 'Failed to create size: ${e.toString()}',
        errorCode: 'CREATE_SIZE_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventorySizesEntity>> updateSize(InventorySizesEntity size) async {
    try {
      final InventorySizesCompanion companion = InventorySizesCompanion(
        sizeName: Value<String>(size.sizeName),
        sizeCode: Value<String>(size.sizeCode),
        sizeType: Value<String>(size.sizeType),
        sizeSystem: Value<String?>(size.sizeSystem),
        sizeMeasurements: Value<String?>(null), // TODO: Serialize JSON if needed
        sizeChartPosition: Value<int?>(size.sizeChartPosition),
        displayOrder: Value<int>(size.displayOrder),
        equivalentSizes: Value<String?>(null), // TODO: Serialize JSON if needed
        status: Value<StatusType>(size.status),
        updatedBy: Value<String?>(size.updatedBy),
        updatedAt: Value<DateTime>(DateTime.now()),
      );
      
      final int affectedRows = await (_database.update(_database.inventorySizes)
        ..where(($InventorySizesTable tbl) => tbl.sizeId.equals(size.sizeId)))
        .write(companion);
      
      if (affectedRows == 0) {
        return DataFailed<InventorySizesEntity>(
          error: 'Size not found for update',
          errorCode: 'UPDATE_SIZE_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventorySizesEntity>(size);
    } catch (e) {
      return DataFailed<InventorySizesEntity>(
        error: 'Failed to update size: ${e.toString()}',
        errorCode: 'UPDATE_SIZE_ERROR',
      );
    }
  }

  @override
  Future<DataState<bool>> deleteSize(String sizeId) async {
    try {
      final int affectedRows = await (_database.delete(_database.inventorySizes)
        ..where(($InventorySizesTable tbl) => tbl.sizeId.equals(sizeId)))
        .go();
      
      if (affectedRows == 0) {
        return DataFailed<bool>(
          error: 'Size not found for deletion',
          errorCode: 'DELETE_SIZE_NOT_FOUND',
        );
      }
      
      return const DataSuccess<bool>(true);
    } catch (e) {
      return DataFailed<bool>(
        error: 'Failed to delete size: ${e.toString()}',
        errorCode: 'DELETE_SIZE_ERROR',
      );
    }
  }
}