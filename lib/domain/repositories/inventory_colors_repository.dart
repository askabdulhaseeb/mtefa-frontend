import '../../core/resources/data_state.dart';
import '../entities/inventory/inventory_colors_entity.dart';

abstract class InventoryColorsRepository {
  Future<DataState<List<InventoryColorsEntity>>> getColors();
  Future<DataState<InventoryColorsEntity>> getColorById(String colorId);
  Future<DataState<InventoryColorsEntity>> createColor(InventoryColorsEntity color);
  Future<DataState<InventoryColorsEntity>> updateColor(InventoryColorsEntity color);
  Future<DataState<bool>> deleteColor(String colorId);
}