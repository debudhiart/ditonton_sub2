import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_detail_notifier_test.mocks.dart';

void main() {
  late DetailTVSeriesBloc detailTVSeriesBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  const tId = 1;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    detailTVSeriesBloc = DetailTVSeriesBloc(mockGetTVSeriesDetail);
  });

  group('detail TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(detailTVSeriesBloc.state, DetailTVSeriesEmpty());
    });

    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVSeriesDetailEntity));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTVSeriesAppellation(tId)),
      expect: () => [
        DetailTVSeriesLoading(),
        DetailTVSeriesHasData(testTVSeriesDetailEntity),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
        return DetailTVSeriesAppellation(tId).props;
      },
    );

    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTVSeriesAppellation(tId)),
      expect: () => [
        DetailTVSeriesLoading(),
        DetailTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => DetailTVSeriesLoading(),
    );
  });
}
