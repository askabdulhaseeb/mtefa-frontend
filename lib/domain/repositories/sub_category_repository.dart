import '../../core/resources/data_state.dart';
import '../entities/inventory/sub_category_entity.dart';

abstract class SubCategoryRepository {
  Future<DataState<List<SubCategoryEntity>>> getAllSubCategories();
  Future<DataState<SubCategoryEntity?>> getSubCategoryById(String subCategoryId);
  Future<DataState<List<SubCategoryEntity>>> getSubCategoriesByCategoryId(String categoryId);
  Future<DataState<List<SubCategoryEntity>>> getSubCategoriesByBusinessId(String businessId);
  Future<DataState<SubCategoryEntity>> createSubCategory(SubCategoryEntity subCategory);
  Future<DataState<SubCategoryEntity>> updateSubCategory(SubCategoryEntity subCategory);
  Future<DataState<void>> deleteSubCategory(String subCategoryId);
  Future<DataState<List<SubCategoryEntity>>> getActiveSubCategories();
}