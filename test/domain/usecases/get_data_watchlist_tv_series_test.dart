import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_data_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDataWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetDataWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getDataTVSeriesWatchlist())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
