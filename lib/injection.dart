import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/delete_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_data_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/on_the_air_now_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  // locator.registerFactory(
  //   () => MovieListNotifier(
  //     getNowPlayingMovies: locator(),
  //     getPopularMovies: locator(),
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieDetailNotifier(
  //     getMovieDetail: locator(),
  //     getMovieRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieSearchNotifier(
  //     searchMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularMoviesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedMoviesNotifier(
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );

  // locator.registerFactory(
  //   () => TVSeriesListNotifier(
  //     getOnTheAirTVSeries: locator(),
  //     getPopularTVSeries: locator(),
  //     getTopRatedTVSeries: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularTVSeriesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedTVSeriesNotifier(
  //     getTopRatedTVSeries: locator(),
  //   ),
  // );

  // locator.registerFactory(
  //   () => WatchlistTVSeriesNotifier(
  //     getDataWatchlistTVSeries: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TVSeriesSearchNotifier(
  //     searchTVSeries: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TVSeriesDetailNotifier(
  //     getTVSeriesDetail: locator(),
  //     getTVSeriesRecommendations: locator(),
  //     getWatchListStatusTVSeries: locator(),
  //     saveTVSeriesFromWatchlist: locator(),
  //     deleteTVSeriesFromWatchlist: locator(),
  //   ),
  // );

  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirNowTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTVSeriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator
      .registerLazySingleton(() => GetDataTVSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTVSeriesFromWatchlist(locator()));
  locator.registerLazySingleton(() => DeleteTVSeriesFromWatchlist(locator()));
  locator.registerLazySingleton(() => GetDataWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
