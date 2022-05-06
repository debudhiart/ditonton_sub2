import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_detail_notifier_test.mocks.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';

void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  const tId = 1;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetRecommendationMovies);
  });

  group('recommendation movies bloc test', () {
    test('initial state should be empty', () {
      expect(recommendationMoviesBloc.state, RecommendationMoviesEmpty());
    });

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(RecommendationMoviesAppellation(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationMovies.execute(tId));
        return RecommendationMoviesAppellation(tId).props;
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(RecommendationMoviesAppellation(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesError('Server Failure'),
      ],
      verify: (bloc) => PopularMoviesLoading(),
    );
  });
}
