import '../../core/resources/data_state.dart';
import '../entities/inventory/category_entity.dart';

abstract class CategoryRepository {
  Future<DataState<List<CategoryEntity>>> getAllCategories();
  Future<DataState<CategoryEntity?>> getCategoryById(String categoryId);
  Future<DataState<List<CategoryEntity>>> getCategoriesByBusinessId(String businessId);
  Future<DataState<List<CategoryEntity>>> getCategoriesByParentId(String? parentId);
  Future<DataState<CategoryEntity>> createCategory(CategoryEntity category);
  Future<DataState<CategoryEntity>> updateCategory(CategoryEntity category);
  Future<DataState<void>> deleteCategory(String categoryId);
  Future<DataState<List<CategoryEntity>>> getActiveCategories();
}