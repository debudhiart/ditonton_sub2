import 'package:ditonton/data/models/season_tv_series_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonTVSeriesModel = SeasonTVSeriesModel(
    id: 1,
    name: 'season',
    posterPath: 'poster',
    episodeCount: 2,
    seasonNumber: 2,
    airDate: '',
    overview: '',
  );

  group('Test Model for TV Series Season', () {
    test('should be a subclass of TV Series Detail entity', () async {
      final testSeason = tSeasonTVSeriesModel.toEntity();

      final result = tSeasonTVSeriesModel.toEntity();
      expect(result, testSeason);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final testSeasonMap = tSeasonTVSeriesModel.toJson();
      // act
      final result = tSeasonTVSeriesModel.toJson();
      // assert
      expect(result, testSeasonMap);
    });
  });
}
