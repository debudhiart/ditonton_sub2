import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}

class FakeMovieDetailState extends Fake implements DetailMovieEvent {}

class FakeDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class FakeMovieRecommendationsEvent extends Fake
    implements RecommendationMoviesEvent {}

class FakeMovieRecommendationsState extends Fake
    implements RecommendationMoviesEvent {}

class FakeMovieRecommendationsBloc
    extends MockBloc<RecommendationMoviesEvent, RecommendationMoviesState>
    implements RecommendationMoviesBloc {}

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
