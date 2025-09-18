import 'package:equatable/equatable.dart';

import '../../../core/enums/status_type.dart';

class InventoryColorsEntity extends Equatable {

  const InventoryColorsEntity({
    required this.colorId,
    required this.businessId,
    required this.colorName,
    required this.colorCode,
    required this.createdAt, required this.updatedAt, this.hexColor,
    this.rgbColor,
    this.pantoneCode,
    this.supplierColorCode,
    this.colorFamily,
    this.isSeasonal = false,
    this.seasonIds,
    this.displayOrder = 0,
    this.colorImageUrl,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String colorId;
  final String businessId;
  final String colorName;
  final String colorCode; // SKU code component
  final String? hexColor; // #FFFFFF format
  final String? rgbColor; // rgb(255,255,255) format
  final String? pantoneCode; // Pantone color matching
  final String? supplierColorCode; // Vendor's color reference
  final String? colorFamily; // Red, Blue, Green, etc.
  final bool isSeasonal;
  final List<String>? seasonIds; // Array of applicable season IDs
  final int displayOrder;
  final String? colorImageUrl; // Sample color swatch image
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        colorId,
        businessId,
        colorName,
        colorCode,
        hexColor,
        rgbColor,
        pantoneCode,
        supplierColorCode,
        colorFamily,
        isSeasonal,
        seasonIds,
        displayOrder,
        colorImageUrl,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  InventoryColorsEntity copyWith({
    String? colorId,
    String? businessId,
    String? colorName,
    String? colorCode,
    String? hexColor,
    String? rgbColor,
    String? pantoneCode,
    String? supplierColorCode,
    String? colorFamily,
    bool? isSeasonal,
    List<String>? seasonIds,
    int? displayOrder,
    String? colorImageUrl,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return InventoryColorsEntity(
      colorId: colorId ?? this.colorId,
      businessId: businessId ?? this.businessId,
      colorName: colorName ?? this.colorName,
      colorCode: colorCode ?? this.colorCode,
      hexColor: hexColor ?? this.hexColor,
      rgbColor: rgbColor ?? this.rgbColor,
      pantoneCode: pantoneCode ?? this.pantoneCode,
      supplierColorCode: supplierColorCode ?? this.supplierColorCode,
      colorFamily: colorFamily ?? this.colorFamily,
      isSeasonal: isSeasonal ?? this.isSeasonal,
      seasonIds: seasonIds ?? this.seasonIds,
      displayOrder: displayOrder ?? this.displayOrder,
      colorImageUrl: colorImageUrl ?? this.colorImageUrl,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}