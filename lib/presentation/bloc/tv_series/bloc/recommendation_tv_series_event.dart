part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTVSeriesEvent extends Equatable {
  const RecommendationTVSeriesEvent();
}

class RecommendationTVSeriesAppellation extends RecommendationTVSeriesEvent {
  final int id;

  RecommendationTVSeriesAppellation(this.id);

  @override
  List<Object> get props => [];
}
