import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/supplier_entity.dart';
import '../../repositories/supplier_repository.dart';

class GetSuppliersUseCase extends UseCase<List<SupplierEntity>, NoParams> {
  GetSuppliersUseCase(this._repository);
  
  final SupplierRepository _repository;

  @override
  Future<DataState<List<SupplierEntity>>> call({NoParams? params}) {
    return _repository.getActiveSuppliers();
  }
}