import 'dart:convert';

import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/inventory_colors_entity.dart';

class InventoryColorsModel extends InventoryColorsEntity {
  const InventoryColorsModel({
    required super.colorId,
    required super.businessId,
    required super.colorName,
    required super.colorCode,
    required super.isSeasonal, required super.displayOrder, required super.status, required super.createdAt, required super.updatedAt, super.hexColor,
    super.rgbColor,
    super.pantoneCode,
    super.supplierColorCode,
    super.colorFamily,
    super.seasonIds,
    super.colorImageUrl,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory InventoryColorsModel.fromJson(Map<String, dynamic> json) {
    return InventoryColorsModel(
      colorId: json['color_id'] as String,
      businessId: json['business_id'] as String,
      colorName: json['color_name'] as String,
      colorCode: json['color_code'] as String,
      hexColor: json['hex_color'] as String?,
      rgbColor: json['rgb_color'] as String?,
      pantoneCode: json['pantone_code'] as String?,
      supplierColorCode: json['supplier_color_code'] as String?,
      colorFamily: json['color_family'] as String?,
      isSeasonal: json['is_seasonal'] as bool? ?? false,
      seasonIds: json['season_ids'] != null
          ? List<String>.from(
              jsonDecode(json['season_ids'] as String) as List<dynamic>)
          : null,
      displayOrder: json['display_order'] as int? ?? 0,
      colorImageUrl: json['color_image_url'] as String?,
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
      'color_id': colorId,
      'business_id': businessId,
      'color_name': colorName,
      'color_code': colorCode,
      'hex_color': hexColor,
      'rgb_color': rgbColor,
      'pantone_code': pantoneCode,
      'supplier_color_code': supplierColorCode,
      'color_family': colorFamily,
      'is_seasonal': isSeasonal,
      'season_ids': seasonIds != null
          ? jsonEncode(seasonIds)
          : null,
      'display_order': displayOrder,
      'color_image_url': colorImageUrl,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  InventoryColorsModel copyWith({
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
    return InventoryColorsModel(
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