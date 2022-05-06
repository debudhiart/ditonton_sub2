import 'package:bloc_test/bloc_test.dart';
// import 'package:ditonton/presentation/bloc/movie/movie_detail/bloc/movie_detail_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/movie_recommendations/movie_recommendations_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/now_playing_movies/bloc/now_playing_movies_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/popular_movies/bloc/popular_movies_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/top_rated_movies/bloc/top_rated_movies_bloc.dart';
// import 'package:ditonton/presentation/bloc/movie/watchlist_movies/watchlist_movies_bloc.dart';

import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/on_the_air_now_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';

import 'package:mocktail/mocktail.dart';

class FakeOnTheAirNowTVSeriesEvent extends Fake
    implements OnTheAirNowTVSeriesEvent {}

class FakeOnTheAirNowTVSeriesState extends Fake
    implements OnTheAirNowTVSeriesState {}

class FakeOnTheAirNowTVSeriesBloc
    extends MockBloc<OnTheAirNowTVSeriesEvent, OnTheAirNowTVSeriesState>
    implements OnTheAirNowTVSeriesBloc {}

class FakePopularTVSeriesEvent extends Fake implements PopularTVSeriesEvent {}

class FakePopularTVSeriesState extends Fake implements PopularTVSeriesState {}

class FakePopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}

class FakeTopRatedTVSeriesEvent extends Fake implements TopRatedTVSeriesEvent {}

class FakeTopRatedTVSeriesState extends Fake implements TopRatedTVSeriesState {}

class FakeTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}

class FakeTVSeriesDetailEvent extends Fake implements DetailTVSeriesEvent {}

class FakeTVSeriesDetailState extends Fake implements DetailTVSeriesEvent {}

class FakeDetailTVSeriesBloc
    extends MockBloc<DetailTVSeriesEvent, DetailTVSeriesState>
    implements DetailTVSeriesBloc {}

class FakeTVSeriesRecommendationsEvent extends Fake
    implements RecommendationTVSeriesEvent {}

class FakeTVSeriesRecommendationsState extends Fake
    implements RecommendationTVSeriesEvent {}

class FakeTVSeriesRecommendationsBloc
    extends MockBloc<RecommendationTVSeriesEvent, RecommendationTVSeriesState>
    implements RecommendationTVSeriesBloc {}

class FakeWatchlistTVSeriesEvent extends Fake
    implements WatchlistTVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class FakeWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}
