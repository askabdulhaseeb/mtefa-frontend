import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.categoryId,
    required super.businessId,
    required super.categoryCode,
    required super.categoryName,
    required super.codePlacement,
    required super.sortOrder,
    required super.isFeatured,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.categoryDescription,
    super.parentCategoryId,
    super.categoryImageUrl,
    super.seoSlug,
    super.metaTitle,
    super.metaDescription,
    super.commissionRate,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'] as String,
      businessId: json['business_id'] as String,
      categoryCode: json['category_code'] as String,
      categoryName: json['category_name'] as String,
      categoryDescription: json['category_description'] as String?,
      parentCategoryId: json['parent_category_id'] as String?,
      categoryImageUrl: json['category_image_url'] as String?,
      seoSlug: json['seo_slug'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaDescription: json['meta_description'] as String?,
      codePlacement: PlacementType.fromString(
        json['code_placement'] as String? ?? 'pre',
      ),
      sortOrder: json['sort_order'] as int? ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      commissionRate: (json['commission_rate'] as num?)?.toDouble(),
      status: StatusType.fromString(json['status'] as String? ?? 'active'),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      syncStatus: json['sync_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category_id': categoryId,
      'business_id': businessId,
      'category_code': categoryCode,
      'category_name': categoryName,
      'category_description': categoryDescription,
      'parent_category_id': parentCategoryId,
      'category_image_url': categoryImageUrl,
      'seo_slug': seoSlug,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'code_placement': codePlacement.value,
      'sort_order': sortOrder,
      'is_featured': isFeatured,
      'commission_rate': commissionRate,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  CategoryModel copyWith({
    String? categoryId,
    String? businessId,
    String? categoryCode,
    String? categoryName,
    String? categoryDescription,
    String? parentCategoryId,
    String? categoryImageUrl,
    String? seoSlug,
    String? metaTitle,
    String? metaDescription,
    PlacementType? codePlacement,
    int? sortOrder,
    bool? isFeatured,
    double? commissionRate,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      businessId: businessId ?? this.businessId,
      categoryCode: categoryCode ?? this.categoryCode,
      categoryName: categoryName ?? this.categoryName,
      categoryDescription: categoryDescription ?? this.categoryDescription,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      seoSlug: seoSlug ?? this.seoSlug,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      codePlacement: codePlacement ?? this.codePlacement,
      sortOrder: sortOrder ?? this.sortOrder,
      isFeatured: isFeatured ?? this.isFeatured,
      commissionRate: commissionRate ?? this.commissionRate,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}
