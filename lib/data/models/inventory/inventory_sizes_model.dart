import 'dart:convert';

import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/inventory_sizes_entity.dart';

class InventorySizesModel extends InventorySizesEntity {
  const InventorySizesModel({
    required super.sizeId,
    required super.businessId,
    required super.sizeName, required super.sizeCode, required super.sizeType, required super.displayOrder, required super.status, required super.createdAt, required super.updatedAt, super.subCategoryId,
    super.sizeSystem,
    super.sizeMeasurements,
    super.sizeChartPosition,
    super.equivalentSizes,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory InventorySizesModel.fromJson(Map<String, dynamic> json) {
    return InventorySizesModel(
      sizeId: json['size_id'] as String,
      businessId: json['business_id'] as String,
      subCategoryId: json['sub_category_id'] as String?,
      sizeName: json['size_name'] as String,
      sizeCode: json['size_code'] as String,
      sizeType: json['size_type'] as String,
      sizeSystem: json['size_system'] as String?,
      sizeMeasurements: json['size_measurements'] != null
          ? Map<String, dynamic>.from(
              jsonDecode(json['size_measurements'] as String) as Map<dynamic, dynamic>)
          : null,
      sizeChartPosition: json['size_chart_position'] as int?,
      displayOrder: json['display_order'] as int? ?? 0,
      equivalentSizes: json['equivalent_sizes'] != null
          ? Map<String, dynamic>.from(
              jsonDecode(json['equivalent_sizes'] as String) as Map<dynamic, dynamic>)
          : null,
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
      'size_id': sizeId,
      'business_id': businessId,
      'sub_category_id': subCategoryId,
      'size_name': sizeName,
      'size_code': sizeCode,
      'size_type': sizeType,
      'size_system': sizeSystem,
      'size_measurements': sizeMeasurements != null
          ? jsonEncode(sizeMeasurements)
          : null,
      'size_chart_position': sizeChartPosition,
      'display_order': displayOrder,
      'equivalent_sizes': equivalentSizes != null
          ? jsonEncode(equivalentSizes)
          : null,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  InventorySizesModel copyWith({
    String? sizeId,
    String? businessId,
    String? subCategoryId,
    String? sizeName,
    String? sizeCode,
    String? sizeType,
    String? sizeSystem,
    Map<String, dynamic>? sizeMeasurements,
    int? sizeChartPosition,
    int? displayOrder,
    Map<String, dynamic>? equivalentSizes,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return InventorySizesModel(
      sizeId: sizeId ?? this.sizeId,
      businessId: businessId ?? this.businessId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      sizeName: sizeName ?? this.sizeName,
      sizeCode: sizeCode ?? this.sizeCode,
      sizeType: sizeType ?? this.sizeType,
      sizeSystem: sizeSystem ?? this.sizeSystem,
      sizeMeasurements: sizeMeasurements ?? this.sizeMeasurements,
      sizeChartPosition: sizeChartPosition ?? this.sizeChartPosition,
      displayOrder: displayOrder ?? this.displayOrder,
      equivalentSizes: equivalentSizes ?? this.equivalentSizes,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}