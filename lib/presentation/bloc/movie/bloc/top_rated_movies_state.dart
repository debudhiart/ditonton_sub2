part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  String message;
  TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> result;

  TopRatedMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
