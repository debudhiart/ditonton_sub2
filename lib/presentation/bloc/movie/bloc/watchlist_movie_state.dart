part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieLoading extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieError extends WatchlistMovieState {
  String message;
  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertDataMovieToWatchlist extends WatchlistMovieState {
  final bool watchlistStatus;

  InsertDataMovieToWatchlist(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

class MessageMovieWatchlist extends WatchlistMovieState {
  final String message;

  MessageMovieWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
