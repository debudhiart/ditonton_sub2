part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class OnGotWatchlistMovie extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}

class GotWatchlistMovie extends WatchlistMovieEvent {
  final int id;

  GotWatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  InsertWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  DeleteWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}
