import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/on_the_air_now_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/movie/movie_list_notifier_test.mocks.dart';
import '../../../helpers/tv_series/tv_series_list_notifier_test.mocks.dart';

void main() {
  late OnTheAirNowTVSeriesBloc onTheAirNowTVSeriesBloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    onTheAirNowTVSeriesBloc =
        OnTheAirNowTVSeriesBloc(mockGetNowPlayingTVSeries);
  });

  group('on the air now TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(onTheAirNowTVSeriesBloc.state, OnTheAirNowTVSeriesEmpty());
    });

    blocTest<OnTheAirNowTVSeriesBloc, OnTheAirNowTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return onTheAirNowTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnTheAirNowTVSeriesAppellation()),
      expect: () => [
        OnTheAirNowTVSeriesLoading(),
        OnTheAirNowTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
        return OnTheAirNowTVSeriesAppellation().props;
      },
    );

    blocTest<OnTheAirNowTVSeriesBloc, OnTheAirNowTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirNowTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnTheAirNowTVSeriesAppellation()),
      expect: () => [
        OnTheAirNowTVSeriesLoading(),
        OnTheAirNowTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => OnTheAirNowTVSeriesLoading(),
    );
  });
}
