// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/tv_series_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_series.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart' as _i4;
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart' as _i8;
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTVSeriesRepository extends _i1.Fake
    implements _i2.TVSeriesRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetNowPlayingTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingTVSeries extends _i1.Mock
    implements _i4.GetOnTheAirTVSeries {
  MockGetNowPlayingTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}

/// A class which mocks [GetPopularTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTVSeries extends _i1.Mock
    implements _i8.GetPopularTVSeries {
  MockGetPopularTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}

/// A class which mocks [GetTopRatedTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTVSeries extends _i1.Mock
    implements _i9.GetTopRatedTVSeries {
  MockGetTopRatedTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}
