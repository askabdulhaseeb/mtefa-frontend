import 'package:equatable/equatable.dart';

import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';

class InventoryLineEntity extends Equatable {

  const InventoryLineEntity({
    required this.inventoryLineId,
    required this.businessId,
    required this.lineCode,
    required this.lineName,
    required this.createdAt, required this.updatedAt, this.lineDescription,
    this.linePlacement = PlacementType.pre,
    this.parentLineId,
    this.sortOrder = 0,
    this.isActive = true,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String inventoryLineId;
  final String businessId;
  final String lineCode;
  final String lineName;
  final String? lineDescription;
  final PlacementType linePlacement;
  final String? parentLineId;
  final int sortOrder;
  final bool isActive;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        inventoryLineId,
        businessId,
        lineCode,
        lineName,
        lineDescription,
        linePlacement,
        parentLineId,
        sortOrder,
        isActive,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  InventoryLineEntity copyWith({
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
    return InventoryLineEntity(
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