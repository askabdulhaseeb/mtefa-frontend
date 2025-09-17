import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/inventory_sizes_entity.dart';
import '../../repositories/inventory_sizes_repository.dart';

class GetSizesUseCase extends UseCase<List<InventorySizesEntity>, NoParams> {
  GetSizesUseCase(this._repository);
  
  final InventorySizesRepository _repository;

  @override
  Future<DataState<List<InventorySizesEntity>>> call({NoParams? params}) {
    return _repository.getSizes();
  }
}