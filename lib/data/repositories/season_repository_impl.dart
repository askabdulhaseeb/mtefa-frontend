import 'package:drift/drift.dart';

import '../../core/database/database.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/season_entity.dart';
import '../../domain/repositories/season_repository.dart';

class SeasonRepositoryImpl implements SeasonRepository {
  SeasonRepositoryImpl({required AppDatabase database}) : _database = database;
  final AppDatabase _database;

  @override
  Future<DataState<List<SeasonEntity>>> getSeasons() async {
    try {
      final List<SeasonData> seasons = await _database.select(_database.season).get();
      
      final List<SeasonEntity> entities = seasons.map((SeasonData season) {
        return SeasonEntity(
          seasonId: season.seasonId,
          businessId: season.businessId,
          seasonName: season.seasonName,
          seasonCode: season.seasonCode,
          seasonDescription: season.seasonDescription,
          startDate: season.startDate,
          endDate: season.endDate,
          isCurrentSeason: season.isCurrentSeason,
          marketingThemes: season.marketingThemes?.split(','),
          targetDemographics: season.targetDemographics?.split(','),
          seasonalMarkupPercentage: season.seasonalMarkupPercentage,
          status: season.status,
          createdBy: season.createdBy,
          updatedBy: season.updatedBy,
          createdAt: season.createdAt,
          updatedAt: season.updatedAt,
          syncStatus: season.syncStatus,
        );
      }).toList();
      
      return DataSuccess<List<SeasonEntity>>(entities);
    } catch (e) {
      return DataFailed<List<SeasonEntity>>(
        error: 'Failed to fetch seasons: ${e.toString()}',
        errorCode: 'GET_SEASONS_ERROR',
      );
    }
  }

  @override
  Future<DataState<SeasonEntity>> getSeasonById(String seasonId) async {
    try {
      final SeasonData? season = await (_database.select(_database.season)
        ..where(($SeasonTable tbl) => tbl.seasonId.equals(seasonId)))
        .getSingleOrNull();
      
      if (season == null) {
        return DataFailed<SeasonEntity>(
          error: 'Season not found',
          errorCode: 'SEASON_NOT_FOUND',
        );
      }
      
      return DataSuccess<SeasonEntity>(
        SeasonEntity(
          seasonId: season.seasonId,
          businessId: season.businessId,
          seasonName: season.seasonName,
          seasonCode: season.seasonCode,
          seasonDescription: season.seasonDescription,
          startDate: season.startDate,
          endDate: season.endDate,
          isCurrentSeason: season.isCurrentSeason,
          marketingThemes: season.marketingThemes?.split(','),
          targetDemographics: season.targetDemographics?.split(','),
          seasonalMarkupPercentage: season.seasonalMarkupPercentage,
          status: season.status,
          createdBy: season.createdBy,
          updatedBy: season.updatedBy,
          createdAt: season.createdAt,
          updatedAt: season.updatedAt,
          syncStatus: season.syncStatus,
        ),
      );
    } catch (e) {
      return DataFailed<SeasonEntity>(
        error: 'Failed to fetch season: ${e.toString()}',
        errorCode: 'GET_SEASON_ERROR',
      );
    }
  }

  @override
  Future<DataState<SeasonEntity>> createSeason(SeasonEntity season) async {
    try {
      final SeasonCompanion companion = SeasonCompanion(
        seasonId: Value<String>(season.seasonId),
        businessId: Value<String>(season.businessId),
        seasonName: Value<String>(season.seasonName),
        seasonCode: Value<String>(season.seasonCode),
        seasonDescription: Value<String?>(season.seasonDescription),
        startDate: Value<DateTime?>(season.startDate),
        endDate: Value<DateTime?>(season.endDate),
        isCurrentSeason: Value<bool>(season.isCurrentSeason),
        marketingThemes: Value<String?>(season.marketingThemes?.join(',')),
        targetDemographics: Value<String?>(season.targetDemographics?.join(',')),
        seasonalMarkupPercentage: Value<double?>(season.seasonalMarkupPercentage),
        status: Value<StatusType>(season.status),
        createdBy: Value<String?>(season.createdBy),
        updatedBy: Value<String?>(season.updatedBy),
        createdAt: Value<DateTime>(season.createdAt),
        updatedAt: Value<DateTime>(season.updatedAt),
        syncStatus: season.syncStatus != null ? Value<String>(season.syncStatus!) : const Value<String>.absent(),
      );
      
      await _database.into(_database.season).insert(companion);
      
      return DataSuccess<SeasonEntity>(season);
    } catch (e) {
      return DataFailed<SeasonEntity>(
        error: 'Failed to create season: ${e.toString()}',
        errorCode: 'CREATE_SEASON_ERROR',
      );
    }
  }

  @override
  Future<DataState<SeasonEntity>> updateSeason(SeasonEntity season) async {
    try {
      final SeasonCompanion companion = SeasonCompanion(
        seasonName: Value<String>(season.seasonName),
        seasonCode: Value<String>(season.seasonCode),
        seasonDescription: Value<String?>(season.seasonDescription),
        startDate: Value<DateTime?>(season.startDate),
        endDate: Value<DateTime?>(season.endDate),
        isCurrentSeason: Value<bool>(season.isCurrentSeason),
        marketingThemes: Value<String?>(season.marketingThemes?.join(',')),
        targetDemographics: Value<String?>(season.targetDemographics?.join(',')),
        seasonalMarkupPercentage: Value<double?>(season.seasonalMarkupPercentage),
        status: Value<StatusType>(season.status),
        updatedBy: Value<String?>(season.updatedBy),
        updatedAt: Value<DateTime>(DateTime.now()),
      );
      
      final int affectedRows = await (_database.update(_database.season)
        ..where(($SeasonTable tbl) => tbl.seasonId.equals(season.seasonId)))
        .write(companion);
      
      if (affectedRows == 0) {
        return DataFailed<SeasonEntity>(
          error: 'Season not found for update',
          errorCode: 'UPDATE_SEASON_NOT_FOUND',
        );
      }
      
      return DataSuccess<SeasonEntity>(season);
    } catch (e) {
      return DataFailed<SeasonEntity>(
        error: 'Failed to update season: ${e.toString()}',
        errorCode: 'UPDATE_SEASON_ERROR',
      );
    }
  }

  @override
  Future<DataState<bool>> deleteSeason(String seasonId) async {
    try {
      final int affectedRows = await (_database.delete(_database.season)
        ..where(($SeasonTable tbl) => tbl.seasonId.equals(seasonId)))
        .go();
      
      if (affectedRows == 0) {
        return DataFailed<bool>(
          error: 'Season not found for deletion',
          errorCode: 'DELETE_SEASON_NOT_FOUND',
        );
      }
      
      return const DataSuccess<bool>(true);
    } catch (e) {
      return DataFailed<bool>(
        error: 'Failed to delete season: ${e.toString()}',
        errorCode: 'DELETE_SEASON_ERROR',
      );
    }
  }
}