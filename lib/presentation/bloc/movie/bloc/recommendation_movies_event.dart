part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();
}

class RecommendationMoviesAppellation extends RecommendationMoviesEvent {
  final int id;

  RecommendationMoviesAppellation(this.id);

  @override
  List<Object> get props => [];
}
