import 'package:equatable/equatable.dart';

import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';

class CategoryEntity extends Equatable {

  const CategoryEntity({
    required this.categoryId,
    required this.businessId,
    required this.categoryCode,
    required this.categoryName,
    this.categoryDescription,
    this.parentCategoryId,
    this.categoryImageUrl,
    this.seoSlug,
    this.metaTitle,
    this.metaDescription,
    this.codePlacement = PlacementType.pre,
    this.sortOrder = 0,
    this.isFeatured = false,
    this.commissionRate,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = 'pending',
  });
  final String categoryId;
  final String businessId;
  final String categoryCode;
  final String categoryName;
  final String? categoryDescription;
  final String? parentCategoryId;
  final String? categoryImageUrl;
  final String? seoSlug;
  final String? metaTitle;
  final String? metaDescription;
  final PlacementType codePlacement;
  final int sortOrder;
  final bool isFeatured;
  final double? commissionRate;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        categoryId,
        businessId,
        categoryCode,
        categoryName,
        categoryDescription,
        parentCategoryId,
        categoryImageUrl,
        seoSlug,
        metaTitle,
        metaDescription,
        codePlacement,
        sortOrder,
        isFeatured,
        commissionRate,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  CategoryEntity copyWith({
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
    return CategoryEntity(
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