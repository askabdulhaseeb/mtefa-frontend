import '../../core/resources/data_state.dart';
import '../entities/inventory/inventory_locations_entity.dart';

abstract class InventoryLocationsRepository {
  Future<DataState<List<InventoryLocationsEntity>>> getLocations();
  Future<DataState<InventoryLocationsEntity>> getLocationById(String locationId);
  Future<DataState<InventoryLocationsEntity>> createLocation(InventoryLocationsEntity location);
  Future<DataState<InventoryLocationsEntity>> updateLocation(InventoryLocationsEntity location);
  Future<DataState<bool>> deleteLocation(String locationId);
}