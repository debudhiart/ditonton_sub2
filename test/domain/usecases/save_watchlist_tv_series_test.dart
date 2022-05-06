import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTVSeriesFromWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveTVSeriesFromWatchlist(mockTVSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVSeriesRepository
            .saveTVSeriesFromWatchlist(testTVSeriesDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetailEntity);
    // assert
    verify(mockTVSeriesRepository
        .saveTVSeriesFromWatchlist(testTVSeriesDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
