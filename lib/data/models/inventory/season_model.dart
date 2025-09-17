import 'dart:convert';

import '../../../core/enums/status_type.dart';
import '../../../domain/entities/inventory/season_entity.dart';

class SeasonModel extends SeasonEntity {
  const SeasonModel({
    required super.seasonId,
    required super.businessId,
    required super.seasonName,
    required super.seasonCode,
    required super.isCurrentSeason, required super.status, required super.createdAt, required super.updatedAt, super.seasonDescription,
    super.startDate,
    super.endDate,
    super.marketingThemes,
    super.targetDemographics,
    super.seasonalMarkupPercentage,
    super.createdBy,
    super.updatedBy,
    super.syncStatus,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      seasonId: json['season_id'] as String,
      businessId: json['business_id'] as String,
      seasonName: json['season_name'] as String,
      seasonCode: json['season_code'] as String,
      seasonDescription: json['season_description'] as String?,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      isCurrentSeason: json['is_current_season'] as bool? ?? false,
      marketingThemes: json['marketing_themes'] != null
          ? List<String>.from(
              jsonDecode(json['marketing_themes'] as String) as List<dynamic>)
          : null,
      targetDemographics: json['target_demographics'] != null
          ? List<String>.from(
              jsonDecode(json['target_demographics'] as String) as List<dynamic>)
          : null,
      seasonalMarkupPercentage: (json['seasonal_markup_percentage'] as num?)?.toDouble(),
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
      'season_id': seasonId,
      'business_id': businessId,
      'season_name': seasonName,
      'season_code': seasonCode,
      'season_description': seasonDescription,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_current_season': isCurrentSeason,
      'marketing_themes': marketingThemes != null
          ? jsonEncode(marketingThemes)
          : null,
      'target_demographics': targetDemographics != null
          ? jsonEncode(targetDemographics)
          : null,
      'seasonal_markup_percentage': seasonalMarkupPercentage,
      'status': status.value,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  @override
  SeasonModel copyWith({
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
    return SeasonModel(
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
      seasonalMarkupPercentage: seasonalMarkupPercentage ?? this.seasonalMarkupPercentage,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}