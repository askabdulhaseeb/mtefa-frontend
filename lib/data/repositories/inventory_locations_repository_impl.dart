import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/location_type.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/inventory_locations_entity.dart';
import '../../domain/repositories/inventory_locations_repository.dart';

class InventoryLocationsRepositoryImpl implements InventoryLocationsRepository {
  InventoryLocationsRepositoryImpl({required AppDatabase database}) : _database = database;
  final AppDatabase _database;

  @override
  Future<DataState<List<InventoryLocationsEntity>>> getLocations() async {
    try {
      final List<InventoryLocation> locations = await _database.select(_database.inventoryLocations).get();
      
      final List<InventoryLocationsEntity> entities = locations.map((InventoryLocation location) {
        return InventoryLocationsEntity(
          locationId: location.locationId,
          businessId: location.businessId,
          branchId: location.branchId,
          locationName: location.locationName,
          locationCode: location.locationCode,
          locationType: location.locationType,
          parentLocationId: location.parentLocationId,
          aisle: location.aisle,
          shelf: location.shelf,
          bin: location.bin,
          barcode: location.barcode,
          maxCapacity: location.maxCapacity,
          currentCapacity: location.currentCapacity,
          isSellableLocation: location.isSellableLocation,
          requiresCounting: location.requiresCounting,
          temperatureControlled: location.temperatureControlled,
          securityLevel: location.securityLevel,
          status: location.status,
          createdBy: location.createdBy,
          updatedBy: location.updatedBy,
          createdAt: location.createdAt,
          updatedAt: location.updatedAt,
          syncStatus: location.syncStatus,
        );
      }).toList();
      
      return DataSuccess<List<InventoryLocationsEntity>>(entities);
    } catch (e) {
      return DataFailed<List<InventoryLocationsEntity>>(
        error: 'Failed to fetch locations: ${e.toString()}',
        errorCode: 'GET_LOCATIONS_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryLocationsEntity>> getLocationById(String locationId) async {
    try {
      final InventoryLocation? location = await (_database.select(_database.inventoryLocations)
        ..where(($InventoryLocationsTable tbl) => tbl.locationId.equals(locationId)))
        .getSingleOrNull();
      
      if (location == null) {
        return DataFailed<InventoryLocationsEntity>(
          error: 'Location not found',
          errorCode: 'LOCATION_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventoryLocationsEntity>(
        InventoryLocationsEntity(
          locationId: location.locationId,
          businessId: location.businessId,
          branchId: location.branchId,
          locationName: location.locationName,
          locationCode: location.locationCode,
          locationType: location.locationType,
          parentLocationId: location.parentLocationId,
          aisle: location.aisle,
          shelf: location.shelf,
          bin: location.bin,
          barcode: location.barcode,
          maxCapacity: location.maxCapacity,
          currentCapacity: location.currentCapacity,
          isSellableLocation: location.isSellableLocation,
          requiresCounting: location.requiresCounting,
          temperatureControlled: location.temperatureControlled,
          securityLevel: location.securityLevel,
          status: location.status,
          createdBy: location.createdBy,
          updatedBy: location.updatedBy,
          createdAt: location.createdAt,
          updatedAt: location.updatedAt,
          syncStatus: location.syncStatus,
        ),
      );
    } catch (e) {
      return DataFailed<InventoryLocationsEntity>(
        error: 'Failed to fetch location: ${e.toString()}',
        errorCode: 'GET_LOCATION_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryLocationsEntity>> createLocation(InventoryLocationsEntity location) async {
    try {
      final InventoryLocationsCompanion companion = InventoryLocationsCompanion(
        locationId: Value<String>(location.locationId),
        businessId: Value<String>(location.businessId),
        branchId: Value<String>(location.branchId),
        locationName: Value<String>(location.locationName),
        locationCode: Value<String>(location.locationCode),
        locationType: Value<LocationType>(location.locationType),
        parentLocationId: Value<String?>(location.parentLocationId),
        aisle: Value<String?>(location.aisle),
        shelf: Value<String?>(location.shelf),
        bin: Value<String?>(location.bin),
        barcode: Value<String?>(location.barcode),
        maxCapacity: Value<int?>(location.maxCapacity),
        currentCapacity: Value<int>(location.currentCapacity),
        isSellableLocation: Value<bool>(location.isSellableLocation),
        requiresCounting: Value<bool>(location.requiresCounting),
        temperatureControlled: Value<bool>(location.temperatureControlled),
        securityLevel: Value<String>(location.securityLevel),
        status: Value<StatusType>(location.status),
        createdBy: Value<String?>(location.createdBy),
        updatedBy: Value<String?>(location.updatedBy),
        createdAt: Value<DateTime>(location.createdAt),
        updatedAt: Value<DateTime>(location.updatedAt),
        syncStatus: location.syncStatus != null ? Value<String>(location.syncStatus!) : const Value<String>.absent(),
      );
      
      await _database.into(_database.inventoryLocations).insert(companion);
      
      return DataSuccess<InventoryLocationsEntity>(location);
    } catch (e) {
      return DataFailed<InventoryLocationsEntity>(
        error: 'Failed to create location: ${e.toString()}',
        errorCode: 'CREATE_LOCATION_ERROR',
      );
    }
  }

  @override
  Future<DataState<InventoryLocationsEntity>> updateLocation(InventoryLocationsEntity location) async {
    try {
      final InventoryLocationsCompanion companion = InventoryLocationsCompanion(
        locationName: Value<String>(location.locationName),
        locationCode: Value<String>(location.locationCode),
        locationType: Value<LocationType>(location.locationType),
        parentLocationId: Value<String?>(location.parentLocationId),
        aisle: Value<String?>(location.aisle),
        shelf: Value<String?>(location.shelf),
        bin: Value<String?>(location.bin),
        barcode: Value<String?>(location.barcode),
        maxCapacity: Value<int?>(location.maxCapacity),
        currentCapacity: Value<int>(location.currentCapacity),
        isSellableLocation: Value<bool>(location.isSellableLocation),
        requiresCounting: Value<bool>(location.requiresCounting),
        temperatureControlled: Value<bool>(location.temperatureControlled),
        securityLevel: Value<String>(location.securityLevel),
        status: Value<StatusType>(location.status),
        updatedBy: Value<String?>(location.updatedBy),
        updatedAt: Value<DateTime>(DateTime.now()),
      );
      
      final int affectedRows = await (_database.update(_database.inventoryLocations)
        ..where(($InventoryLocationsTable tbl) => tbl.locationId.equals(location.locationId)))
        .write(companion);
      
      if (affectedRows == 0) {
        return DataFailed<InventoryLocationsEntity>(
          error: 'Location not found for update',
          errorCode: 'UPDATE_LOCATION_NOT_FOUND',
        );
      }
      
      return DataSuccess<InventoryLocationsEntity>(location);
    } catch (e) {
      return DataFailed<InventoryLocationsEntity>(
        error: 'Failed to update location: ${e.toString()}',
        errorCode: 'UPDATE_LOCATION_ERROR',
      );
    }
  }

  @override
  Future<DataState<bool>> deleteLocation(String locationId) async {
    try {
      final int affectedRows = await (_database.delete(_database.inventoryLocations)
        ..where(($InventoryLocationsTable tbl) => tbl.locationId.equals(locationId)))
        .go();
      
      if (affectedRows == 0) {
        return DataFailed<bool>(
          error: 'Location not found for deletion',
          errorCode: 'DELETE_LOCATION_NOT_FOUND',
        );
      }
      
      return const DataSuccess<bool>(true);
    } catch (e) {
      return DataFailed<bool>(
        error: 'Failed to delete location: ${e.toString()}',
        errorCode: 'DELETE_LOCATION_ERROR',
      );
    }
  }
}