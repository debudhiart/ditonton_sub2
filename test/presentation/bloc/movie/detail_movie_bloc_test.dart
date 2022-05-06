import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';
import '../../../helpers/movie/movie_detail_notifier_test.mocks.dart';

void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  const tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  group('detail movies bloc test', () {
    test('initial state should be empty', () {
      expect(detailMovieBloc.state, DetailMovieEmpty());
    });

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(DetailMovieAppellation(tId)),
      expect: () => [
        DetailMovieLoading(),
        DetailMovieHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        return DetailMovieAppellation(tId).props;
      },
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(DetailMovieAppellation(tId)),
      expect: () => [
        DetailMovieLoading(),
        DetailMovieError('Server Failure'),
      ],
      verify: (bloc) => DetailMovieLoading(),
    );
  });
}
