import 'package:equatable/equatable.dart';

import '../../../core/enums/placement_type.dart';
import '../../../core/enums/status_type.dart';

class SubCategoryEntity extends Equatable {

  const SubCategoryEntity({
    required this.subCategoryId,
    required this.categoryId,
    required this.businessId,
    required this.subCategoryCode,
    required this.subCategoryName,
    required this.createdAt, required this.updatedAt, this.subCategoryDescription,
    this.codePlacement = PlacementType.pre,
    this.counter,
    this.sortOrder = 0,
    this.subCategoryImageUrl,
    this.sizeChartUrl,
    this.careInstructions,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String subCategoryId;
  final String categoryId;
  final String businessId;
  final String subCategoryCode;
  final String subCategoryName;
  final String? subCategoryDescription;
  final PlacementType codePlacement;
  final int? counter; // Auto-incremented within category
  final int sortOrder;
  final String? subCategoryImageUrl;
  final String? sizeChartUrl; // For clothing categories
  final String? careInstructions; // For applicable items
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        subCategoryId,
        categoryId,
        businessId,
        subCategoryCode,
        subCategoryName,
        subCategoryDescription,
        codePlacement,
        counter,
        sortOrder,
        subCategoryImageUrl,
        sizeChartUrl,
        careInstructions,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  SubCategoryEntity copyWith({
    String? subCategoryId,
    String? categoryId,
    String? businessId,
    String? subCategoryCode,
    String? subCategoryName,
    String? subCategoryDescription,
    PlacementType? codePlacement,
    int? counter,
    int? sortOrder,
    String? subCategoryImageUrl,
    String? sizeChartUrl,
    String? careInstructions,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return SubCategoryEntity(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      categoryId: categoryId ?? this.categoryId,
      businessId: businessId ?? this.businessId,
      subCategoryCode: subCategoryCode ?? this.subCategoryCode,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      subCategoryDescription:
          subCategoryDescription ?? this.subCategoryDescription,
      codePlacement: codePlacement ?? this.codePlacement,
      counter: counter ?? this.counter,
      sortOrder: sortOrder ?? this.sortOrder,
      subCategoryImageUrl: subCategoryImageUrl ?? this.subCategoryImageUrl,
      sizeChartUrl: sizeChartUrl ?? this.sizeChartUrl,
      careInstructions: careInstructions ?? this.careInstructions,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}