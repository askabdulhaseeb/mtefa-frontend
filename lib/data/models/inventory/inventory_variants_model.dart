import 'dart:convert';

import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/inventory_variants_entity.dart';

class InventoryVariantsModel extends InventoryVariantsEntity {
  const InventoryVariantsModel({
    required super.variantId,
    required super.inventoryId,
    required super.businessId,
    required super.variantSku, required super.variantName, required super.variantCode, required super.costPriceAdjustment, required super.priceAdjustment, required super.finalCostPrice, required super.finalRetailPrice, required super.weightAdjustment, required super.minimumStockLevel, required super.reorderLevel, required super.isDefaultVariant, required super.isAvailableOnline, required super.isAvailableInStore, required super.status, required super.createdAt, required super.updatedAt, super.colorId,
    super.sizeId,
    super.variantBarcode,
    super.variantDescription,
    super.variantSpecifications,
    super.variantImages,
    super.dimensionAdjustments,
    super.maximumStockLevel,
    super.availabilityDate,
    super.discontinueDate,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory InventoryVariantsModel.fromJson(Map<String, dynamic> json) {
    return InventoryVariantsModel(
      variantId: json['variant_id'] as String,
      inventoryId: json['inventory_id'] as String,
      businessId: json['business_id'] as String,
      colorId: json['color_id'] as String?,
      sizeId: json['size_id'] as String?,
      variantSku: json['variant_sku'] as String,
      variantBarcode: json['variant_barcode'] as String?,
      variantName: json['variant_name'] as String,
      variantCode: json['variant_code'] as String,
      costPriceAdjustment: (json['cost_price_adjustment'] as num?)?.toDouble() ?? 0.00,
      priceAdjustment: (json['price_adjustment'] as num?)?.toDouble() ?? 0.00,
      finalCostPrice: (json['final_cost_price'] as num?)?.toDouble() ?? 0.00,
      finalRetailPrice: (json['final_retail_price'] as num?)?.toDouble() ?? 0.00,
      variantDescription: json['variant_description'] as String?,
      variantSpecifications: json['variant_specifications'] != null
          ? Map<String, dynamic>.from(
              jsonDecode(json['variant_specifications'] as String) as Map<dynamic, dynamic>)
          : null,
      variantImages: json['variant_images'] != null
          ? List<String>.from(
              jsonDecode(json['variant_images'] as String) as List<dynamic>)
          : null,
      weightAdjustment: (json['weight_adjustment'] as num?)?.toDouble() ?? 0.000,
      dimensionAdjustments: json['dimension_adjustments'] != null
          ? Map<String, dynamic>.from(
              jsonDecode(json['dimension_adjustments'] as String) as Map<dynamic, dynamic>)
          : null,
      minimumStockLevel: json['minimum_stock_level'] as int? ?? 0,
      reorderLevel: json['reorder_level'] as int? ?? 0,
      maximumStockLevel: json['maximum_stock_level'] as int?,
      isDefaultVariant: json['is_default_variant'] as bool? ?? false,
      isAvailableOnline: json['is_available_online'] as bool? ?? true,
      isAvailableInStore: json['is_available_in_store'] as bool? ?? true,
      availabilityDate: json['availability_date'] != null
          ? DateTime.parse(json['availability_date'] as String)
          : null,
      discontinueDate: json['discontinue_date'] != null
          ? DateTime.parse(json['discontinue_date'] as String)
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
      'variant_id': variantId,
      'inventory_id': inventoryId,
      'business_id': businessId,
      'color_id': colorId,
      'size_id': sizeId,
      'variant_sku': variantSku,
      'variant_barcode': variantBarcode,
      'variant_name': variantName,
      'variant_code': variantCode,
      'cost_price_adjustment': costPriceAdjustment,
      'price_adjustment': priceAdjustment,
      'final_cost_price': finalCostPrice,
      'final_retail_price': finalRetailPrice,
      'variant_description': variantDescription,
      'variant_specifications': variantSpecifications != null
          ? jsonEncode(variantSpecifications)
          : null,
      'variant_images': variantImages != null
          ? jsonEncode(variantImages)
          : null,
      'weight_adjustment': weightAdjustment,
      'dimension_adjustments': dimensionAdjustments != null
          ? jsonEncode(dimensionAdjustments)
          : null,
      'minimum_stock_level': minimumStockLevel,
      'reorder_level': reorderLevel,
      'maximum_stock_level': maximumStockLevel,
      'is_default_variant': isDefaultVariant,
      'is_available_online': isAvailableOnline,
      'is_available_in_store': isAvailableInStore,
      'availability_date': availabilityDate?.toIso8601String(),
      'discontinue_date': discontinueDate?.toIso8601String(),
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  InventoryVariantsModel copyWith({
    String? variantId,
    String? inventoryId,
    String? businessId,
    String? colorId,
    String? sizeId,
    String? variantSku,
    String? variantBarcode,
    String? variantName,
    String? variantCode,
    double? costPriceAdjustment,
    double? priceAdjustment,
    double? finalCostPrice,
    double? finalRetailPrice,
    String? variantDescription,
    Map<String, dynamic>? variantSpecifications,
    List<String>? variantImages,
    double? weightAdjustment,
    Map<String, dynamic>? dimensionAdjustments,
    int? minimumStockLevel,
    int? reorderLevel,
    int? maximumStockLevel,
    bool? isDefaultVariant,
    bool? isAvailableOnline,
    bool? isAvailableInStore,
    DateTime? availabilityDate,
    DateTime? discontinueDate,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return InventoryVariantsModel(
      variantId: variantId ?? this.variantId,
      inventoryId: inventoryId ?? this.inventoryId,
      businessId: businessId ?? this.businessId,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      variantSku: variantSku ?? this.variantSku,
      variantBarcode: variantBarcode ?? this.variantBarcode,
      variantName: variantName ?? this.variantName,
      variantCode: variantCode ?? this.variantCode,
      costPriceAdjustment: costPriceAdjustment ?? this.costPriceAdjustment,
      priceAdjustment: priceAdjustment ?? this.priceAdjustment,
      finalCostPrice: finalCostPrice ?? this.finalCostPrice,
      finalRetailPrice: finalRetailPrice ?? this.finalRetailPrice,
      variantDescription: variantDescription ?? this.variantDescription,
      variantSpecifications: variantSpecifications ?? this.variantSpecifications,
      variantImages: variantImages ?? this.variantImages,
      weightAdjustment: weightAdjustment ?? this.weightAdjustment,
      dimensionAdjustments: dimensionAdjustments ?? this.dimensionAdjustments,
      minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      maximumStockLevel: maximumStockLevel ?? this.maximumStockLevel,
      isDefaultVariant: isDefaultVariant ?? this.isDefaultVariant,
      isAvailableOnline: isAvailableOnline ?? this.isAvailableOnline,
      isAvailableInStore: isAvailableInStore ?? this.isAvailableInStore,
      availabilityDate: availabilityDate ?? this.availabilityDate,
      discontinueDate: discontinueDate ?? this.discontinueDate,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}