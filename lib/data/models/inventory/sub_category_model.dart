import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.subCategoryId,
    required super.categoryId,
    required super.businessId,
    required super.subCategoryCode,
    required super.subCategoryName,
    required super.codePlacement, required super.counter, required super.sortOrder, required super.status, required super.createdAt, required super.updatedAt, super.subCategoryDescription,
    super.subCategoryImageUrl,
    super.sizeChartUrl,
    super.careInstructions,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      subCategoryId: json['sub_category_id'] as String,
      categoryId: json['category_id'] as String,
      businessId: json['business_id'] as String,
      subCategoryCode: json['sub_category_code'] as String,
      subCategoryName: json['sub_category_name'] as String,
      subCategoryDescription: json['sub_category_description'] as String?,
      codePlacement: PlacementType.fromString(json['code_placement'] as String? ?? 'pre'),
      counter: json['counter'] as int? ?? 0,
      sortOrder: json['sort_order'] as int? ?? 0,
      subCategoryImageUrl: json['sub_category_image_url'] as String?,
      sizeChartUrl: json['size_chart_url'] as String?,
      careInstructions: json['care_instructions'] as String?,
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
      'sub_category_id': subCategoryId,
      'category_id': categoryId,
      'business_id': businessId,
      'sub_category_code': subCategoryCode,
      'sub_category_name': subCategoryName,
      'sub_category_description': subCategoryDescription,
      'code_placement': codePlacement.value,
      'counter': counter,
      'sort_order': sortOrder,
      'sub_category_image_url': subCategoryImageUrl,
      'size_chart_url': sizeChartUrl,
      'care_instructions': careInstructions,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  SubCategoryModel copyWith({
    String? subCategoryId,
    String? categoryId,
    String? businessId,
    String? subCategoryCode,
    String? subCategoryName,
    String? subCategoryDescription,
    PlacementType? codePlacement,
    int? counter,
    int? sortOrder,
    String? subCategoryImageUrl,
    String? sizeChartUrl,
    String? careInstructions,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return SubCategoryModel(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      categoryId: categoryId ?? this.categoryId,
      businessId: businessId ?? this.businessId,
      subCategoryCode: subCategoryCode ?? this.subCategoryCode,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      subCategoryDescription: subCategoryDescription ?? this.subCategoryDescription,
      codePlacement: codePlacement ?? this.codePlacement,
      counter: counter ?? this.counter,
      sortOrder: sortOrder ?? this.sortOrder,
      subCategoryImageUrl: subCategoryImageUrl ?? this.subCategoryImageUrl,
      sizeChartUrl: sizeChartUrl ?? this.sizeChartUrl,
      careInstructions: careInstructions ?? this.careInstructions,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}