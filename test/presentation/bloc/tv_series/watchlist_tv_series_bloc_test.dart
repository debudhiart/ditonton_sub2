import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_watchlist_notifier_test.mocks.dart';

void main() {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late MockGetDataTVSeriesWatchListStatus mockGetDataTVSeriesWatchListStatus;
  late MockSaveWatchlistTVSeries mockSaveWatchlistTVSeries;
  late MockDeleteWatchlistTVSeries mockDeleteWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    mockGetDataTVSeriesWatchListStatus = MockGetDataTVSeriesWatchListStatus();
    mockSaveWatchlistTVSeries = MockSaveWatchlistTVSeries();
    mockDeleteWatchlistTVSeries = MockDeleteWatchlistTVSeries();
    watchlistTVSeriesBloc = WatchlistTVSeriesBloc(
      mockGetWatchlistTVSeries,
      mockGetDataTVSeriesWatchListStatus,
      mockSaveWatchlistTVSeries,
      mockDeleteWatchlistTVSeries,
    );
  });

  group('watchlist TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistTVSeriesBloc.state, WatchlistTVSeriesEmpty());
    });

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
        return OnGotWatchlistTVSeries().props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('status watchlist TV Series bloc test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetDataTVSeriesWatchListStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => true);

        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(GotWatchlistTVSeries(testTVSeriesDetail.id)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        InsertDataTVSeriesToWatchlist(true),
      ],
      verify: (bloc) {
        verify(
            mockGetDataTVSeriesWatchListStatus.execute(testTVSeriesDetail.id));
        return GotWatchlistTVSeries(testTVSeriesDetail.id).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetDataTVSeriesWatchListStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => false);

        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(GotWatchlistTVSeries(testTVSeriesDetail.id)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        InsertDataTVSeriesToWatchlist(false),
      ],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('add watchlist TV Series bloc test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetailEntity))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(InsertWatchlistTVSeries(testTVSeriesDetailEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        MessageTVSeriesWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTVSeries.execute(testTVSeriesDetailEntity));
        return InsertWatchlistTVSeries(testTVSeriesDetailEntity).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(InsertWatchlistTVSeries(testTVSeriesDetailEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTVSeries(testTVSeriesDetailEntity),
    );
  });

  group('delete watchlist TV Series bloc test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockDeleteWatchlistTVSeries.execute(testTVSeriesDetailEntity))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTVSeries(testTVSeriesDetailEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        MessageTVSeriesWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockDeleteWatchlistTVSeries.execute(testTVSeriesDetailEntity));
        return DeleteWatchlistTVSeries(testTVSeriesDetailEntity).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockDeleteWatchlistTVSeries.execute(testTVSeriesDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTVSeries(testTVSeriesDetailEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistTVSeries(testTVSeriesDetailEntity),
    );
  });
}
