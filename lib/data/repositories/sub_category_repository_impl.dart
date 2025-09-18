import '../../core/database/database.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/sub_category_entity.dart';
import '../../domain/repositories/sub_category_repository.dart';

class SubCategoryRepositoryImpl implements SubCategoryRepository {
  SubCategoryRepositoryImpl({required this.database});

  final AppDatabase database;

  @override
  Future<DataState<List<SubCategoryEntity>>> getAllSubCategories() async {
    try {
      final List<SubCategoryData> subCategories = await database.select(database.subCategory).get();
      final List<SubCategoryEntity> entities = subCategories.map(_toEntity).toList();
      return DataSuccess<List<SubCategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<SubCategoryEntity>>(
        error: 'Failed to get sub categories: ${e.toString()}',
        errorCode: 'GET_SUB_CATEGORIES_FAILED',
      );
    }
  }

  @override
  Future<DataState<SubCategoryEntity?>> getSubCategoryById(String subCategoryId) async {
    // TODO: Implement
    return const DataFailed<SubCategoryEntity?>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<List<SubCategoryEntity>>> getSubCategoriesByCategoryId(String categoryId) async {
    try {
      final List<SubCategoryData> subCategories = await (database.select(database.subCategory)
            ..where(($SubCategoryTable tbl) => tbl.categoryId.equals(categoryId)))
          .get();
      
      final List<SubCategoryEntity> entities = subCategories.map(_toEntity).toList();
      return DataSuccess<List<SubCategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<SubCategoryEntity>>(
        error: 'Failed to get sub categories by category: ${e.toString()}',
        errorCode: 'GET_SUB_CATEGORIES_BY_CATEGORY_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<SubCategoryEntity>>> getSubCategoriesByBusinessId(String businessId) async {
    // TODO: Implement
    return const DataFailed<List<SubCategoryEntity>>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<SubCategoryEntity>> createSubCategory(SubCategoryEntity subCategory) async {
    // TODO: Implement
    return const DataFailed<SubCategoryEntity>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<SubCategoryEntity>> updateSubCategory(SubCategoryEntity subCategory) async {
    // TODO: Implement
    return const DataFailed<SubCategoryEntity>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<void>> deleteSubCategory(String subCategoryId) async {
    // TODO: Implement
    return const DataFailed<void>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<List<SubCategoryEntity>>> getActiveSubCategories() async {
    // TODO: Implement
    return const DataFailed<List<SubCategoryEntity>>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  SubCategoryEntity _toEntity(SubCategoryData data) {
    return SubCategoryEntity(
      subCategoryId: data.subCategoryId,
      categoryId: data.categoryId,
      businessId: data.businessId,
      subCategoryCode: data.subCategoryCode,
      subCategoryName: data.subCategoryName,
      subCategoryDescription: data.subCategoryDescription,
      codePlacement: data.codePlacement,
      counter: data.counter,
      sortOrder: data.sortOrder,
      subCategoryImageUrl: data.subCategoryImageUrl,
      sizeChartUrl: data.sizeChartUrl,
      careInstructions: data.careInstructions,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }
}