import 'package:equatable/equatable.dart';

import '../../../core/enums/status_type.dart';

class InventoryVariantsEntity extends Equatable {

  const InventoryVariantsEntity({
    required this.variantId,
    required this.inventoryId,
    required this.businessId,
    this.colorId,
    this.sizeId,
    required this.variantSku,
    this.variantBarcode,
    required this.variantName,
    required this.variantCode,
    this.costPriceAdjustment = 0.00,
    this.priceAdjustment = 0.00,
    this.finalCostPrice,
    this.finalRetailPrice,
    this.variantDescription,
    this.variantSpecifications,
    this.variantImages,
    this.weightAdjustment = 0.000,
    this.dimensionAdjustments,
    this.minimumStockLevel = 0,
    this.reorderLevel = 0,
    this.maximumStockLevel,
    this.isDefaultVariant = false,
    this.isAvailableOnline = true,
    this.isAvailableInStore = true,
    this.availabilityDate,
    this.discontinueDate,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = 'pending',
  });
  final String variantId;
  final String inventoryId;
  final String businessId;
  final String? colorId;
  final String? sizeId;
  // Variant Identification
  final String variantSku;
  final String? variantBarcode;
  final String variantName; // Generated: "Product Name - Red - Large"
  final String variantCode; // Short variant identifier
  // Pricing Adjustments
  final double costPriceAdjustment;
  final double priceAdjustment;
  final double? finalCostPrice; // Generated field
  final double? finalRetailPrice; // Generated field
  // Variant-Specific Information
  final String? variantDescription;
  final Map<String, dynamic>? variantSpecifications;
  final List<String>? variantImages; // Variant-specific images
  final double weightAdjustment;
  final Map<String, dynamic>? dimensionAdjustments; // L/W/H adjustments
  // Inventory Settings
  final int minimumStockLevel;
  final int reorderLevel;
  final int? maximumStockLevel;
  // Availability
  final bool isDefaultVariant;
  final bool isAvailableOnline;
  final bool isAvailableInStore;
  final DateTime? availabilityDate; // When variant becomes available
  final DateTime? discontinueDate; // When to stop selling
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        variantId,
        inventoryId,
        businessId,
        colorId,
        sizeId,
        variantSku,
        variantBarcode,
        variantName,
        variantCode,
        costPriceAdjustment,
        priceAdjustment,
        finalCostPrice,
        finalRetailPrice,
        variantDescription,
        variantSpecifications,
        variantImages,
        weightAdjustment,
        dimensionAdjustments,
        minimumStockLevel,
        reorderLevel,
        maximumStockLevel,
        isDefaultVariant,
        isAvailableOnline,
        isAvailableInStore,
        availabilityDate,
        discontinueDate,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  InventoryVariantsEntity copyWith({
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
    return InventoryVariantsEntity(
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
      variantSpecifications:
          variantSpecifications ?? this.variantSpecifications,
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