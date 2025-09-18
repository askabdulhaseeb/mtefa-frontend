import 'package:equatable/equatable.dart';

import '../../../core/enums/status_type.dart';

class SeasonEntity extends Equatable {

  const SeasonEntity({
    required this.seasonId,
    required this.businessId,
    required this.seasonName,
    required this.seasonCode,
    required this.createdAt, required this.updatedAt, this.seasonDescription,
    this.startDate,
    this.endDate,
    this.isCurrentSeason = false,
    this.marketingThemes,
    this.targetDemographics,
    this.seasonalMarkupPercentage,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String seasonId;
  final String businessId;
  final String seasonName;
  final String seasonCode;
  final String? seasonDescription;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentSeason;
  final List<String>? marketingThemes; // Colors, styles, themes
  final List<String>? targetDemographics;
  final double? seasonalMarkupPercentage;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        seasonId,
        businessId,
        seasonName,
        seasonCode,
        seasonDescription,
        startDate,
        endDate,
        isCurrentSeason,
        marketingThemes,
        targetDemographics,
        seasonalMarkupPercentage,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  SeasonEntity copyWith({
    String? seasonId,
    String? businessId,
    String? seasonName,
    String? seasonCode,
    String? seasonDescription,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentSeason,
    List<String>? marketingThemes,
    List<String>? targetDemographics,
    double? seasonalMarkupPercentage,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return SeasonEntity(
      seasonId: seasonId ?? this.seasonId,
      businessId: businessId ?? this.businessId,
      seasonName: seasonName ?? this.seasonName,
      seasonCode: seasonCode ?? this.seasonCode,
      seasonDescription: seasonDescription ?? this.seasonDescription,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentSeason: isCurrentSeason ?? this.isCurrentSeason,
      marketingThemes: marketingThemes ?? this.marketingThemes,
      targetDemographics: targetDemographics ?? this.targetDemographics,
      seasonalMarkupPercentage:
          seasonalMarkupPercentage ?? this.seasonalMarkupPercentage,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}