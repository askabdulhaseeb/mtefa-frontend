import '../../core/resources/data_state.dart';
import '../entities/inventory/inventory_sizes_entity.dart';

abstract class InventorySizesRepository {
  Future<DataState<List<InventorySizesEntity>>> getSizes();
  Future<DataState<InventorySizesEntity>> getSizeById(String sizeId);
  Future<DataState<InventorySizesEntity>> createSize(InventorySizesEntity size);
  Future<DataState<InventorySizesEntity>> updateSize(InventorySizesEntity size);
  Future<DataState<bool>> deleteSize(String sizeId);
}