import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/placement_type.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/category_entity.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.database});

  final AppDatabase database;

  @override
  Future<DataState<List<CategoryEntity>>> getAllCategories() async {
    try {
      final List<CategoryTableData> categories = await database.select(database.categoryTable).get();
      final List<CategoryEntity> entities = categories.map(_toEntity).toList();
      return DataSuccess<List<CategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<CategoryEntity>>(
        error: 'Failed to get categories: ${e.toString()}',
        errorCode: 'GET_CATEGORIES_FAILED',
      );
    }
  }

  @override
  Future<DataState<CategoryEntity?>> getCategoryById(String categoryId) async {
    try {
      final CategoryTableData? category = await (database.select(database.categoryTable)
            ..where(($CategoryTableTable tbl) => tbl.categoryId.equals(categoryId)))
          .getSingleOrNull();
      
      final CategoryEntity? entity = category != null ? _toEntity(category) : null;
      return DataSuccess<CategoryEntity?>(entity);
    } catch (e) {
      return DataFailed<CategoryEntity?>(
        error: 'Failed to get category: ${e.toString()}',
        errorCode: 'GET_CATEGORY_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> getCategoriesByBusinessId(String businessId) async {
    try {
      final List<CategoryTableData> categories = await (database.select(database.categoryTable)
            ..where(($CategoryTableTable tbl) => tbl.businessId.equals(businessId)))
          .get();
      
      final List<CategoryEntity> entities = categories.map(_toEntity).toList();
      return DataSuccess<List<CategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<CategoryEntity>>(
        error: 'Failed to get categories by business: ${e.toString()}',
        errorCode: 'GET_CATEGORIES_BY_BUSINESS_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> getCategoriesByParentId(String? parentId) async {
    try {
      final List<CategoryTableData> categories = await (database.select(database.categoryTable)
            ..where(($CategoryTableTable tbl) => parentId != null ? tbl.parentCategoryId.equals(parentId) : tbl.parentCategoryId.isNull()))
          .get();
      
      final List<CategoryEntity> entities = categories.map(_toEntity).toList();
      return DataSuccess<List<CategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<CategoryEntity>>(
        error: 'Failed to get categories by parent: ${e.toString()}',
        errorCode: 'GET_CATEGORIES_BY_PARENT_FAILED',
      );
    }
  }

  @override
  Future<DataState<CategoryEntity>> createCategory(CategoryEntity category) async {
    try {
      final CategoryTableCompanion companion = _toCompanion(category);
      await database.into(database.categoryTable).insert(companion);
      return DataSuccess<CategoryEntity>(category);
    } catch (e) {
      return DataFailed<CategoryEntity>(
        error: 'Failed to create category: ${e.toString()}',
        errorCode: 'CREATE_CATEGORY_FAILED',
      );
    }
  }

  @override
  Future<DataState<CategoryEntity>> updateCategory(CategoryEntity category) async {
    try {
      final CategoryTableCompanion companion = _toCompanion(category.copyWith(
        updatedAt: DateTime.now(),
      ));
      
      await (database.update(database.categoryTable)
            ..where(($CategoryTableTable tbl) => tbl.categoryId.equals(category.categoryId)))
          .write(companion);
      
      return DataSuccess<CategoryEntity>(category);
    } catch (e) {
      return DataFailed<CategoryEntity>(
        error: 'Failed to update category: ${e.toString()}',
        errorCode: 'UPDATE_CATEGORY_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> deleteCategory(String categoryId) async {
    try {
      await (database.delete(database.categoryTable)
            ..where(($CategoryTableTable tbl) => tbl.categoryId.equals(categoryId)))
          .go();
      
      return const DataSuccess<void>(null);
    } catch (e) {
      return DataFailed<void>(
        error: 'Failed to delete category: ${e.toString()}',
        errorCode: 'DELETE_CATEGORY_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> getActiveCategories() async {
    try {
      final List<CategoryTableData> categories = await (database.select(database.categoryTable)
            ..where(($CategoryTableTable tbl) => tbl.status.equals(StatusType.active.value)))
          .get();
      
      final List<CategoryEntity> entities = categories.map(_toEntity).toList();
      return DataSuccess<List<CategoryEntity>>(entities);
    } catch (e) {
      return DataFailed<List<CategoryEntity>>(
        error: 'Failed to get active categories: ${e.toString()}',
        errorCode: 'GET_ACTIVE_CATEGORIES_FAILED',
      );
    }
  }

  CategoryEntity _toEntity(CategoryTableData data) {
    return CategoryEntity(
      categoryId: data.categoryId,
      businessId: data.businessId,
      categoryCode: data.categoryCode,
      categoryName: data.categoryName,
      categoryDescription: data.categoryDescription,
      parentCategoryId: data.parentCategoryId,
      categoryImageUrl: data.categoryImageUrl,
      seoSlug: data.seoSlug,
      metaTitle: data.metaTitle,
      metaDescription: data.metaDescription,
      codePlacement: data.codePlacement,
      sortOrder: data.sortOrder,
      isFeatured: data.isFeatured,
      commissionRate: data.commissionRate,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }

  CategoryTableCompanion _toCompanion(CategoryEntity entity) {
    return CategoryTableCompanion(
      categoryId: Value<String>(entity.categoryId),
      businessId: Value<String>(entity.businessId),
      categoryCode: Value<String>(entity.categoryCode),
      categoryName: Value<String>(entity.categoryName),
      categoryDescription: Value<String?>(entity.categoryDescription),
      parentCategoryId: Value<String?>(entity.parentCategoryId),
      categoryImageUrl: Value<String?>(entity.categoryImageUrl),
      seoSlug: Value<String?>(entity.seoSlug),
      metaTitle: Value<String?>(entity.metaTitle),
      metaDescription: Value<String?>(entity.metaDescription),
      codePlacement: Value<PlacementType>(entity.codePlacement),
      sortOrder: Value<int>(entity.sortOrder),
      isFeatured: Value<bool>(entity.isFeatured),
      commissionRate: Value<double?>(entity.commissionRate),
      status: Value<StatusType>(entity.status),
      createdBy: Value<String?>(entity.createdBy),
      updatedBy: Value<String?>(entity.updatedBy),
      createdAt: Value<DateTime>(entity.createdAt),
      updatedAt: Value<DateTime>(entity.updatedAt),
      syncStatus: entity.syncStatus != null ? Value<String>(entity.syncStatus!) : const Value<String>.absent(),
    );
  }
}