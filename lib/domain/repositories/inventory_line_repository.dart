import '../../core/resources/data_state.dart';
import '../entities/inventory/inventory_line_entity.dart';

abstract class InventoryLineRepository {
  Future<DataState<List<InventoryLineEntity>>> getAllInventoryLines();
  Future<DataState<InventoryLineEntity?>> getInventoryLineById(String lineId);
  Future<DataState<List<InventoryLineEntity>>> getInventoryLinesByBusinessId(String businessId);
  Future<DataState<InventoryLineEntity>> createInventoryLine(InventoryLineEntity inventoryLine);
  Future<DataState<InventoryLineEntity>> updateInventoryLine(InventoryLineEntity inventoryLine);
  Future<DataState<void>> deleteInventoryLine(String lineId);
  Future<DataState<List<InventoryLineEntity>>> getActiveInventoryLines();
}