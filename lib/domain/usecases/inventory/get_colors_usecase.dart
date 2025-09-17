import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/inventory_colors_entity.dart';
import '../../repositories/inventory_colors_repository.dart';

class GetColorsUseCase extends UseCase<List<InventoryColorsEntity>, NoParams> {
  GetColorsUseCase(this._repository);
  
  final InventoryColorsRepository _repository;

  @override
  Future<DataState<List<InventoryColorsEntity>>> call({NoParams? params}) {
    return _repository.getColors();
  }
}