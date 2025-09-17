import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/category_entity.dart';
import '../../repositories/category_repository.dart';

class GetCategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  GetCategoriesUseCase(this._repository);
  
  final CategoryRepository _repository;

  @override
  Future<DataState<List<CategoryEntity>>> call({NoParams? params}) {
    return _repository.getActiveCategories();
  }
}

class GetCategoriesByParentParams {
  const GetCategoriesByParentParams({this.parentId});
  
  final String? parentId;
}

class GetCategoriesByParentUseCase extends UseCase<List<CategoryEntity>, GetCategoriesByParentParams> {
  GetCategoriesByParentUseCase(this._repository);
  
  final CategoryRepository _repository;

  @override
  Future<DataState<List<CategoryEntity>>> call({GetCategoriesByParentParams? params}) {
    return _repository.getCategoriesByParentId(params?.parentId);
  }
}