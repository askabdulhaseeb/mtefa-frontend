import 'package:equatable/equatable.dart';

import '../../../core/enums/status_type.dart';

class InventorySizesEntity extends Equatable {

  const InventorySizesEntity({
    required this.sizeId,
    required this.businessId,
    this.subCategoryId,
    required this.sizeName,
    required this.sizeCode,
    required this.sizeType,
    this.sizeSystem,
    this.sizeMeasurements,
    this.sizeChartPosition,
    this.displayOrder = 0,
    this.equivalentSizes,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = 'pending',
  });
  final String sizeId;
  final String businessId;
  final String? subCategoryId;
  final String sizeName; // S, M, L or 32, 34, 36
  final String sizeCode; // SKU component
  final String sizeType; // clothing, shoes, generic, numeric
  final String? sizeSystem; // US, EU, UK, etc.
  final Map<String, dynamic>? sizeMeasurements; // Detailed measurements
  final int? sizeChartPosition;
  final int displayOrder;
  final Map<String, dynamic>? equivalentSizes; // Size conversions
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        sizeId,
        businessId,
        subCategoryId,
        sizeName,
        sizeCode,
        sizeType,
        sizeSystem,
        sizeMeasurements,
        sizeChartPosition,
        displayOrder,
        equivalentSizes,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  InventorySizesEntity copyWith({
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
    return InventorySizesEntity(
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