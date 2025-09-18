import 'package:equatable/equatable.dart';

import '../../../core/enums/location_type.dart';
import '../../../core/enums/status_type.dart';

class InventoryLocationsEntity extends Equatable {

  const InventoryLocationsEntity({
    required this.locationId,
    required this.businessId,
    required this.branchId,
    required this.locationName,
    required this.locationCode,
    required this.locationType,
    required this.createdAt, required this.updatedAt, this.parentLocationId,
    this.aisle,
    this.shelf,
    this.bin,
    this.barcode,
    this.maxCapacity,
    this.currentCapacity = 0,
    this.isSellableLocation = true,
    this.requiresCounting = true,
    this.temperatureControlled = false,
    this.securityLevel = 'standard',
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String locationId;
  final String businessId;
  final String branchId;
  final String locationName;
  final String locationCode;
  final LocationType locationType;
  final String? parentLocationId;
  final String? aisle;
  final String? shelf;
  final String? bin;
  final String? barcode;
  final int? maxCapacity;
  final int currentCapacity;
  final bool isSellableLocation;
  final bool requiresCounting;
  final bool temperatureControlled;
  final String securityLevel; // standard, high, restricted
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        locationId,
        businessId,
        branchId,
        locationName,
        locationCode,
        locationType,
        parentLocationId,
        aisle,
        shelf,
        bin,
        barcode,
        maxCapacity,
        currentCapacity,
        isSellableLocation,
        requiresCounting,
        temperatureControlled,
        securityLevel,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  InventoryLocationsEntity copyWith({
    String? locationId,
    String? businessId,
    String? branchId,
    String? locationName,
    String? locationCode,
    LocationType? locationType,
    String? parentLocationId,
    String? aisle,
    String? shelf,
    String? bin,
    String? barcode,
    int? maxCapacity,
    int? currentCapacity,
    bool? isSellableLocation,
    bool? requiresCounting,
    bool? temperatureControlled,
    String? securityLevel,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return InventoryLocationsEntity(
      locationId: locationId ?? this.locationId,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      locationName: locationName ?? this.locationName,
      locationCode: locationCode ?? this.locationCode,
      locationType: locationType ?? this.locationType,
      parentLocationId: parentLocationId ?? this.parentLocationId,
      aisle: aisle ?? this.aisle,
      shelf: shelf ?? this.shelf,
      bin: bin ?? this.bin,
      barcode: barcode ?? this.barcode,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentCapacity: currentCapacity ?? this.currentCapacity,
      isSellableLocation: isSellableLocation ?? this.isSellableLocation,
      requiresCounting: requiresCounting ?? this.requiresCounting,
      temperatureControlled:
          temperatureControlled ?? this.temperatureControlled,
      securityLevel: securityLevel ?? this.securityLevel,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}