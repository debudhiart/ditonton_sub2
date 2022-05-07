import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_page_helper.dart';

void main() {
  late FakeDetailMovieBloc fakeDetailMovieBloc;
  late FakeMovieRecommendationsBloc fakeMovieRecommendationsBloc;
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeDetailMovieBloc = FakeDetailMovieBloc();

    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    fakeMovieRecommendationsBloc = FakeMovieRecommendationsBloc();

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (_) => fakeDetailMovieBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => fakeWatchlistMovieBloc,
        ),
        BlocProvider<RecommendationMoviesBloc>(
          create: (_) => fakeMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailMovieBloc.close();
    fakeWatchlistMovieBloc.close();
    fakeMovieRecommendationsBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(DetailMovieLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesLoading());
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(DetailMovieLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesLoading());
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));

    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));

    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(InsertDataMovieToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(InsertDataMovieToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
  });
}
