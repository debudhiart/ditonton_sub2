import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_list_notifier_test.mocks.dart';

void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  group('top rated TVSeries bloc test', () {
    test('initial state should be empty', () {
      expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesEmpty());
    });

    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTVSeriesAppellation()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
        return TopRatedTVSeriesAppellation().props;
      },
    );

    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTVSeriesAppellation()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => TopRatedTVSeriesLoading(),
    );
  });
}
