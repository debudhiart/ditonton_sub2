part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTVSeriesState extends Equatable {
  const RecommendationTVSeriesState();
}

class RecommendationTVSeriesEmpty extends RecommendationTVSeriesState {
  @override
  List<Object> get props => [];
}

class RecommendationTVSeriesLoading extends RecommendationTVSeriesState {
  @override
  List<Object> get props => [];
}

class RecommendationTVSeriesError extends RecommendationTVSeriesState {
  String message;
  RecommendationTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTVSeriesHasData extends RecommendationTVSeriesState {
  final List<TVSeries> result;

  RecommendationTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
