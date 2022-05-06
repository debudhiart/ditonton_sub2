part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesEmpty extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PopularMoviesError extends PopularMoviesState {
  String message;
  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;

  PopularMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
