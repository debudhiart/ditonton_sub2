import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/delete_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetDataTVSeriesWatchListStatus getWatchListStatusTVSeries;
  final SaveTVSeriesFromWatchlist saveTVSeriesFromWatchlist;
  final DeleteTVSeriesFromWatchlist deleteTVSeriesFromWatchlist;

  TVSeriesDetailNotifier({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getWatchListStatusTVSeries,
    required this.saveTVSeriesFromWatchlist,
    required this.deleteTVSeriesFromWatchlist,
  });

  late TVSeriesDetail _tvSeries;
  TVSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TVSeries> _tvSeriesRecommendations = [];
  List<TVSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationStateTVSeries = RequestState.Empty;
  RequestState get recommendationStateTVSeries => _recommendationStateTVSeries;

  String _message = '';
  String get message => _message;

  bool _isAddedTVSeriestoWatchlist = false;
  bool get isAddedTVSeriesToWatchlist => _isAddedTVSeriestoWatchlist;

  Future<void> fetchTVSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVSeriesDetail.execute(id);
    final recommendationResult = await getTVSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationStateTVSeries = RequestState.Loading;
        _tvSeries = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationStateTVSeries = RequestState.Error;
            _message = failure.message;
          },
          (tvSeries) {
            _recommendationStateTVSeries = RequestState.Loaded;
            _tvSeriesRecommendations = tvSeries;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> insertTVSeriesWatchlist(TVSeriesDetail movie) async {
    final result = await saveTVSeriesFromWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> deleteFromWatchlist(TVSeriesDetail movie) async {
    final result = await deleteTVSeriesFromWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTVSeries.execute(id);
    _isAddedTVSeriestoWatchlist = result;
    notifyListeners();
  }
}
