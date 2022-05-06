import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/delete_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteTVSeriesFromWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = DeleteTVSeriesFromWatchlist(mockTVSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTVSeriesRepository
            .deleteTVSeriesFromWatchlist(testTVSeriesDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetailEntity);
    // assert
    verify(mockTVSeriesRepository
        .deleteTVSeriesFromWatchlist(testTVSeriesDetailEntity));
    expect(result, Right('Removed from watchlist'));
  });
}
