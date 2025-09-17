import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/inventory_line_entity.dart';
import '../../repositories/inventory_line_repository.dart';

class GetInventoryLinesUseCase extends UseCase<List<InventoryLineEntity>, NoParams> {
  GetInventoryLinesUseCase(this._repository);
  
  final InventoryLineRepository _repository;

  @override
  Future<DataState<List<InventoryLineEntity>>> call({NoParams? params}) {
    return _repository.getActiveInventoryLines();
  }
}