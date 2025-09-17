import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/inventory_colors_entity.dart';
import '../../domain/repositories/inventory_colors_repository.dart';

class InventoryColorsRepositoryImpl implements InventoryColorsRepository {
  InventoryColorsRepositoryImpl({required AppDatabase database}) : _database = database;
  final AppDatabase _database;

  @override
  Future<DataState<List<InventoryColorsEntity>>> getColors() async {
    try {
      final List<InventoryColor> colors = await _database.select(_database.inventoryColors).get();
      
      final List<InventoryColorsEntity> entities = colors.map((InventoryColor color) {
        return InventoryColorsEntity(
          colorId: color.colorId,
          businessId: color.businessId,
          colorName: color.colorName,
          colorCode: color.colorCode,
          hexColor: color.hexColor,
          rgbColor: color.rgbColor,
          pantoneCode: color.pantoneCode,
          supplierColorCode: color.supplierColorCode,
          colorFamily: color.colorFamily,
          isSeasonal: color.isSeasonal,
          seasonIds: color.seasonIds?.split(','),
          displayOrder: color.displayOrder,
          colorImageUrl: color.colorImageUrl,
          status: color.status,
          createdBy: color.createdBy,
          updatedBy: color.updatedBy,
          createdAt: color.createdAt,
          updatedAt: color.updatedAt,
          syncStatus: color.syncStatus,
        );
      }).toList();
      
      return DataSuccess<List<InventoryColorsEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventoryColorsEntity>>(
        error: 'Failed to fetch colors: ${e.toString()}',
        errorCode: 'GET_COLORS_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryColorsEntity>> getColorById(String colorId) async {
    try {
      final InventoryColor? color = await (_database.select(_database.inventoryColors)
        ..where(($InventoryColorsTable tbl) => tbl.colorId.equals(colorId)))
        .getSingleOrNull();
      
      if (color == null) {
        return DataFailed<InventoryColorsEntity>(
          error: 'Color not found',
          errorCode: 'COLOR_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventoryColorsEntity>(
        InventoryColorsEntity(
          colorId: color.colorId,
          businessId: color.businessId,
          colorName: color.colorName,
          colorCode: color.colorCode,
          hexColor: color.hexColor,
          rgbColor: color.rgbColor,
          pantoneCode: color.pantoneCode,
          supplierColorCode: color.supplierColorCode,
          colorFamily: color.colorFamily,
          isSeasonal: color.isSeasonal,
          seasonIds: color.seasonIds?.split(','),
          displayOrder: color.displayOrder,
          colorImageUrl: color.colorImageUrl,
          status: color.status,
          createdBy: color.createdBy,
          updatedBy: color.updatedBy,
          createdAt: color.createdAt,
          updatedAt: color.updatedAt,
          syncStatus: color.syncStatus,
        ),
      );
    } catch (e) {
      return DataFailed<InventoryColorsEntity>(
        error: 'Failed to fetch color: ${e.toString()}',
        errorCode: 'GET_COLOR_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryColorsEntity>> createColor(InventoryColorsEntity color) async {
    try {
      final InventoryColorsCompanion companion = InventoryColorsCompanion(
        colorId: Value<String>(color.colorId),
        businessId: Value<String>(color.businessId),
        colorName: Value<String>(color.colorName),
        colorCode: Value<String>(color.colorCode),
        hexColor: Value<String?>(color.hexColor),
        rgbColor: Value<String?>(color.rgbColor),
        pantoneCode: Value<String?>(color.pantoneCode),
        supplierColorCode: Value<String?>(color.supplierColorCode),
        colorFamily: Value<String?>(color.colorFamily),
        isSeasonal: Value<bool>(color.isSeasonal),
        seasonIds: Value<String?>(color.seasonIds?.join(',')),
        displayOrder: Value<int>(color.displayOrder),
        colorImageUrl: Value<String?>(color.colorImageUrl),
        status: Value<StatusType>(color.status),
        createdBy: Value<String?>(color.createdBy),
        updatedBy: Value<String?>(color.updatedBy),
        createdAt: Value<DateTime>(color.createdAt),
        updatedAt: Value<DateTime>(color.updatedAt),
        syncStatus: color.syncStatus != null ? Value<String>(color.syncStatus!) : const Value<String>.absent(),
      );
      
      await _database.into(_database.inventoryColors).insert(companion);
      
      return DataSuccess<InventoryColorsEntity>(color);
    } catch (e) {
      return DataFailed<InventoryColorsEntity>(
        error: 'Failed to create color: ${e.toString()}',
        errorCode: 'CREATE_COLOR_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryColorsEntity>> updateColor(InventoryColorsEntity color) async {
    try {
      final InventoryColorsCompanion companion = InventoryColorsCompanion(
        colorName: Value<String>(color.colorName),
        colorCode: Value<String>(color.colorCode),
        hexColor: Value<String?>(color.hexColor),
        rgbColor: Value<String?>(color.rgbColor),
        pantoneCode: Value<String?>(color.pantoneCode),
        supplierColorCode: Value<String?>(color.supplierColorCode),
        colorFamily: Value<String?>(color.colorFamily),
        isSeasonal: Value<bool>(color.isSeasonal),
        seasonIds: Value<String?>(color.seasonIds?.join(',')),
        displayOrder: Value<int>(color.displayOrder),
        colorImageUrl: Value<String?>(color.colorImageUrl),
        status: Value<StatusType>(color.status),
        updatedBy: Value<String?>(color.updatedBy),
        updatedAt: Value<DateTime>(DateTime.now()),
      );
      
      final int affectedRows = await (_database.update(_database.inventoryColors)
        ..where(($InventoryColorsTable tbl) => tbl.colorId.equals(color.colorId)))
        .write(companion);
      
      if (affectedRows == 0) {
        return DataFailed<InventoryColorsEntity>(
          error: 'Color not found for update',
          errorCode: 'UPDATE_COLOR_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventoryColorsEntity>(color);
    } catch (e) {
      return DataFailed<InventoryColorsEntity>(
        error: 'Failed to update color: ${e.toString()}',
        errorCode: 'UPDATE_COLOR_ERROR',
      );
    }
  }

  @override
  Future<DataState<bool>> deleteColor(String colorId) async {
    try {
      final int affectedRows = await (_database.delete(_database.inventoryColors)
        ..where(($InventoryColorsTable tbl) => tbl.colorId.equals(colorId)))
        .go();
      
      if (affectedRows == 0) {
        return DataFailed<bool>(
          error: 'Color not found for deletion',
          errorCode: 'DELETE_COLOR_NOT_FOUND',
        );
      }
      
      return const DataSuccess<bool>(true);
    } catch (e) {
      return DataFailed<bool>(
        error: 'Failed to delete color: ${e.toString()}',
        errorCode: 'DELETE_COLOR_ERROR',
      );
    }
  }
}