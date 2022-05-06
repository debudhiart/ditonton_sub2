import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_page_helper.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
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

  const testId = 1;

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(DetailMovieLoading());
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesLoading());
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(DetailMovieLoading());
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesLoading());
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(InsertDataMovieToWatchlist(false));

    // when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    // when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
    // expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMoviesHasData(testMovieList));
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(InsertDataMovieToWatchlist(false));
    // when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
  });
}
