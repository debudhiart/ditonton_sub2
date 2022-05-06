// import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:mockito/mockito.dart';

// import '../../provider/movie_search_notifier_test.mocks.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../../../helpers/tv_series/tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc searchTVSeriesBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searchTVSeriesBloc = SearchTVSeriesBloc(mockSearchTVSeries);
  });

  test('initial state should be empty', () {
    expect(searchTVSeriesBloc.state, SearchTVSeriesEmpty());
  });

  final tTVSeriesModel = TVSeries(
    // adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    // originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    // releaseDate: '2002-05-01',
    // title: 'Spider-Man',
    // video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );

  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  final tQuery = 'spiderman';

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTVSeriesLoading(),
      SearchTVSeriesHasData(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTVSeriesLoading(),
      SearchTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
