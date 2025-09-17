import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/inventory_line_entity.dart';

class InventoryLineModel extends InventoryLineEntity {
  const InventoryLineModel({
    required super.inventoryLineId,
    required super.businessId,
    required super.lineCode,
    required super.lineName,
    required super.linePlacement, required super.sortOrder, required super.isActive, required super.status, required super.createdAt, required super.updatedAt, super.lineDescription,
    super.parentLineId,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory InventoryLineModel.fromJson(Map<String, dynamic> json) {
    return InventoryLineModel(
      inventoryLineId: json['inventory_line_id'] as String,
      businessId: json['business_id'] as String,
      lineCode: json['line_code'] as String,
      lineName: json['line_name'] as String,
      lineDescription: json['line_description'] as String?,
      linePlacement: PlacementType.fromString(json['line_placement'] as String? ?? 'pre'),
      parentLineId: json['parent_line_id'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? true,
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
      'inventory_line_id': inventoryLineId,
      'business_id': businessId,
      'line_code': lineCode,
      'line_name': lineName,
      'line_description': lineDescription,
      'line_placement': linePlacement.value,
      'parent_line_id': parentLineId,
      'sort_order': sortOrder,
      'is_active': isActive,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  InventoryLineModel copyWith({
    String? inventoryLineId,
    String? businessId,
    String? lineCode,
    String? lineName,
    String? lineDescription,
    PlacementType? linePlacement,
    String? parentLineId,
    int? sortOrder,
    bool? isActive,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return InventoryLineModel(
      inventoryLineId: inventoryLineId ?? this.inventoryLineId,
      businessId: businessId ?? this.businessId,
      lineCode: lineCode ?? this.lineCode,
      lineName: lineName ?? this.lineName,
      lineDescription: lineDescription ?? this.lineDescription,
      linePlacement: linePlacement ?? this.linePlacement,
      parentLineId: parentLineId ?? this.parentLineId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}