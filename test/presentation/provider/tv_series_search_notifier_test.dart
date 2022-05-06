import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_series/tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late TVSeriesSearchNotifier provider;
  late MockSearchTVSeries mockSearchTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTVSeries = MockSearchTVSeries();
    provider = TVSeriesSearchNotifier(searchTVSeries: mockSearchTVSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeriesModel = TVSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  final tQuery = 'boruto';

  group('search TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
