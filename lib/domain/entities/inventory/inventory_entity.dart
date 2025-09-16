import 'package:equatable/equatable.dart';

/// Inventory entity representing an inventory item in the POS system
class InventoryEntity extends Equatable {
  const InventoryEntity({
    required this.name,
    required this.code,
    required this.categoryId,
    required this.brandId,
    required this.costPrice,
    required this.sellingPrice,
    required this.stockQuantity,
    required this.minimumStockLevel,
    required this.unitOfMeasurement,
    this.id,
    this.description,
    this.imageUrl,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String name;
  final String code; // SKU
  final String categoryId;
  final String brandId;
  final String? description;
  final double costPrice;
  final double sellingPrice;
  final int stockQuantity;
  final int minimumStockLevel;
  final String unitOfMeasurement;
  final String? imageUrl;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Calculate profit margin
  double get profitMargin {
    if (sellingPrice <= 0) return 0;
    return ((sellingPrice - costPrice) / sellingPrice) * 100;
  }

  /// Calculate markup percentage
  double get markupPercentage {
    if (costPrice <= 0) return 0;
    return ((sellingPrice - costPrice) / costPrice) * 100;
  }

  /// Check if stock is low
  bool get isLowStock => stockQuantity <= minimumStockLevel;

  /// Check if out of stock
  bool get isOutOfStock => stockQuantity <= 0;

  InventoryEntity copyWith({
    String? id,
    String? name,
    String? code,
    String? categoryId,
    String? brandId,
    String? description,
    double? costPrice,
    double? sellingPrice,
    int? stockQuantity,
    int? minimumStockLevel,
    String? unitOfMeasurement,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InventoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      description: description ?? this.description,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
      unitOfMeasurement: unitOfMeasurement ?? this.unitOfMeasurement,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        categoryId,
        brandId,
        description,
        costPrice,
        sellingPrice,
        stockQuantity,
        minimumStockLevel,
        unitOfMeasurement,
        imageUrl,
        isActive,
        createdAt,
        updatedAt,
      ];
}