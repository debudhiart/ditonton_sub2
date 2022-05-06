import 'package:bloc/bloc.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/delete_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_data_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetDataWatchlistTVSeries _getDataWatchlistTVSeries;
  final GetDataTVSeriesWatchListStatus _getDataTVSeriesWatchListStatus;
  final SaveTVSeriesFromWatchlist _saveTVSeriesFromWatchlist;
  final DeleteTVSeriesFromWatchlist _deleteTVSeriesFromWatchlist;

  WatchlistTVSeriesBloc(
      this._getDataWatchlistTVSeries,
      this._getDataTVSeriesWatchListStatus,
      this._saveTVSeriesFromWatchlist,
      this._deleteTVSeriesFromWatchlist)
      : super(WatchlistTVSeriesEmpty()) {
    on<OnGotWatchlistTVSeries>(
      (event, emit) async {
        emit(WatchlistTVSeriesLoading());

        final result = await _getDataWatchlistTVSeries.execute();

        result.fold(
          (failure) {
            emit(WatchlistTVSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistTVSeriesHasData(data));
            } else {
              emit(WatchlistTVSeriesEmpty());
            }
          },
        );
      },
    );
    on<GotWatchlistTVSeries>(
      (event, emit) async {
        emit(WatchlistTVSeriesLoading());
        final id = event.id;

        final result = await _getDataTVSeriesWatchListStatus.execute(id);
        emit(InsertDataTVSeriesToWatchlist(result));
      },
    );
    on<InsertWatchlistTVSeries>(
      (event, emit) async {
        emit(WatchlistTVSeriesLoading());

        final tvSeries = event.tvSeriesDetail;

        final result = await _saveTVSeriesFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTVSeriesError(failure.message));
          },
          (message) {
            emit(MessageTVSeriesWatchlist(message));
          },
        );
      },
    );
    on<DeleteWatchlistTVSeries>(
      (event, emit) async {
        emit(WatchlistTVSeriesLoading());

        final tvSeries = event.tvSeriesDetail;

        final result = await _deleteTVSeriesFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTVSeriesError(failure.message));
          },
          (message) {
            emit(MessageTVSeriesWatchlist(message));
          },
        );
      },
    );
  }
}
