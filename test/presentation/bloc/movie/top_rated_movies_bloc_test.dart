import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';

void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  group('top rated movies bloc test', () {
    test('initial state should be empty', () {
      expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
    });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesAppellation()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
        return TopRatedMoviesAppellation().props;
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesAppellation()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError('Server Failure'),
      ],
      verify: (bloc) => TopRatedMoviesLoading(),
    );
  });
}
