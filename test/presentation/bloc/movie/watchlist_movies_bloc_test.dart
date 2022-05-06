import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';
import '../../../helpers/movie/movie_watchlist_notifier_test.mocks.dart';

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  group('watchlist movies bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return OnGotWatchlistMovie().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('status watchlist movies bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GotWatchlistMovie(testMovieDetail.id)),
      expect: () => [
        InsertDataMovieToWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return GotWatchlistMovie(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GotWatchlistMovie(testMovieDetail.id)),
      expect: () => [
        InsertDataMovieToWatchlist(false),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('add watchlist movies bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        MessageMovieWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return InsertWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistMovie(testMovieDetail),
    );
  });

  group('delete watchlist movies bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        MessageMovieWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return DeleteWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistMovie(testMovieDetail),
    );
  });
}
