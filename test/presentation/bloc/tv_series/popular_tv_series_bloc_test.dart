import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_list_notifier_test.mocks.dart';

void main() {
  late PopularTVSeriesBloc popularTVSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularTVSeriesBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  group('popular TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(popularTVSeriesBloc.state, PopularTVSeriesEmpty());
    });

    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(PopularTVSeriesAppellation()),
      expect: () => [
        PopularTVSeriesLoading(),
        PopularTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
        return PopularTVSeriesAppellation().props;
      },
    );

    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(PopularTVSeriesAppellation()),
      expect: () => [
        PopularTVSeriesLoading(),
        PopularTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => PopularTVSeriesLoading(),
    );
  });
}
