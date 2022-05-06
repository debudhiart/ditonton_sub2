part of 'detail_tv_series_bloc.dart';

abstract class DetailTVSeriesState extends Equatable {
  const DetailTVSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTVSeriesEmpty extends DetailTVSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTVSeriesLoading extends DetailTVSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTVSeriesError extends DetailTVSeriesState {
  String message;
  DetailTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTVSeriesHasData extends DetailTVSeriesState {
  final TVSeriesDetail result;

  DetailTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
