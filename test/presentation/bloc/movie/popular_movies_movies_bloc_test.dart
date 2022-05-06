import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';

void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  group('popular movies bloc test', () {
    test('initial state should be empty', () {
      expect(popularMoviesBloc.state, PopularMoviesEmpty());
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesAppellation()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
        return PopularMoviesAppellation().props;
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesAppellation()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError('Server Failure'),
      ],
      verify: (bloc) => PopularMoviesLoading(),
    );
  });
}
