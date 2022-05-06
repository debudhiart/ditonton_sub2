// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/helpers/movie_bloc_test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_series.dart' as _i9;
import 'package:ditonton/domain/entities/tv_series_detail.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_data_watchlist_tv_series.dart'
    as _i14;
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart'
    as _i13;
import 'package:ditonton/domain/usecases/delete_watchlist_tv_series.dart'
    as _i16;
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart' as _i15;

import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTVSeriesRepository_0 extends _i1.Fake
    implements _i2.TVSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetDataTVSeriesWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDataTVSeriesWatchListStatus extends _i1.Mock
    implements _i13.GetDataTVSeriesWatchListStatus {
  MockGetDataTVSeriesWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTVSeries extends _i1.Mock
    implements _i14.GetDataWatchlistTVSeries {
  MockGetWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i9.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>);
}

/// A class which mocks [SaveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTVSeries extends _i1.Mock
    implements _i15.SaveTVSeriesFromWatchlist {
  MockSaveWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeries]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteWatchlistTVSeries extends _i1.Mock
    implements _i16.DeleteTVSeriesFromWatchlist {
  MockDeleteWatchlistTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeries]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
