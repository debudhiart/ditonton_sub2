import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_detail_notifier_test.mocks.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';
import '../../../helpers/tv_series/tv_series_detail_notifier_test.mocks.dart';

void main() {
  late RecommendationTVSeriesBloc recommendationTVSeriesBloc;
  late MockGetTVSeriesRecommendations mockGetRecommendationTVSeries;

  const tId = 1;

  setUp(() {
    mockGetRecommendationTVSeries = MockGetTVSeriesRecommendations();
    recommendationTVSeriesBloc =
        RecommendationTVSeriesBloc(mockGetRecommendationTVSeries);
  });

  group('recommendation TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(recommendationTVSeriesBloc.state, RecommendationTVSeriesEmpty());
    });

    blocTest<RecommendationTVSeriesBloc, RecommendationTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationTVSeries.execute(tId))
            .thenAnswer((_) async => Right(testTVSeriesList));
        return recommendationTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RecommendationTVSeriesAppellation(tId)),
      expect: () => [
        RecommendationTVSeriesLoading(),
        RecommendationTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationTVSeries.execute(tId));
        return RecommendationTVSeriesAppellation(tId).props;
      },
    );

    blocTest<RecommendationTVSeriesBloc, RecommendationTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetRecommendationTVSeries.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RecommendationTVSeriesAppellation(tId)),
      expect: () => [
        RecommendationTVSeriesLoading(),
        RecommendationTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => PopularTVSeriesLoading(),
    );
  });
}
