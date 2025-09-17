import '../../core/resources/data_state.dart';
import '../entities/inventory/season_entity.dart';

abstract class SeasonRepository {
  Future<DataState<List<SeasonEntity>>> getSeasons();
  Future<DataState<SeasonEntity>> getSeasonById(String seasonId);
  Future<DataState<SeasonEntity>> createSeason(SeasonEntity season);
  Future<DataState<SeasonEntity>> updateSeason(SeasonEntity season);
  Future<DataState<bool>> deleteSeason(String seasonId);
}