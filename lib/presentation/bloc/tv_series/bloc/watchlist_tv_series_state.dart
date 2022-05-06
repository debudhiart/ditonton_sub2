part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  String message;
  WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final List<TVSeries> result;

  WatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertDataTVSeriesToWatchlist extends WatchlistTVSeriesState {
  final bool watchlistStatus;

  InsertDataTVSeriesToWatchlist(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

class MessageTVSeriesWatchlist extends WatchlistTVSeriesState {
  final String message;

  MessageTVSeriesWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
