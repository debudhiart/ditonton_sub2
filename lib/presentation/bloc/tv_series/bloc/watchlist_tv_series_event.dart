part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesEvent extends Equatable {
  const WatchlistTVSeriesEvent();
}

class OnGotWatchlistTVSeries extends WatchlistTVSeriesEvent {
  @override
  List<Object> get props => [];
}

class GotWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final int id;

  GotWatchlistTVSeries(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeriesDetail;

  InsertWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DeleteWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeriesDetail;

  DeleteWatchlistTVSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
