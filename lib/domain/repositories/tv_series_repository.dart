import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Either<Failure, String>> saveTVSeriesFromWatchlist(
      TVSeriesDetail movie);
  Future<Either<Failure, String>> deleteTVSeriesFromWatchlist(
      TVSeriesDetail movie);
  Future<bool> isInsertTVSeriesToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getDataTVSeriesWatchlist();
}
