import '../../../core/resources/data_state.dart';
import '../../../core/resources/base_usecase.dart';
import '../../entities/inventory/sub_category_entity.dart';
import '../../repositories/sub_category_repository.dart';

class GetSubCategoriesParams {
  const GetSubCategoriesParams({required this.categoryId});
  
  final String categoryId;
}

class GetSubCategoriesUseCase extends UseCase<List<SubCategoryEntity>, GetSubCategoriesParams> {
  GetSubCategoriesUseCase(this._repository);
  
  final SubCategoryRepository _repository;

  @override
  Future<DataState<List<SubCategoryEntity>>> call({GetSubCategoriesParams? params}) async {
    if (params == null) {
      return const DataFailed<List<SubCategoryEntity>>(
        error: 'Category ID is required',
        errorCode: 'CATEGORY_ID_REQUIRED',
      );
    }
    
    return _repository.getSubCategoriesByCategoryId(params.categoryId);
  }
}