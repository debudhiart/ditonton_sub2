part of 'on_the_air_now_tv_series_bloc.dart';

abstract class OnTheAirNowTVSeriesState extends Equatable {
  const OnTheAirNowTVSeriesState();

  @override
  List<Object> get props => [];
}

class OnTheAirNowTVSeriesEmpty extends OnTheAirNowTVSeriesState {
  @override
  List<Object> get props => [];
}

class OnTheAirNowTVSeriesLoading extends OnTheAirNowTVSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnTheAirNowTVSeriesError extends OnTheAirNowTVSeriesState {
  String message;
  OnTheAirNowTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirNowTVSeriesHasData extends OnTheAirNowTVSeriesState {
  final List<TVSeries> result;

  OnTheAirNowTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
