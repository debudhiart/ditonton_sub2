import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

import '../../helpers/tv_series_page_helper.dart';

void main() {
  late FakeDetailTVSeriesBloc fakeDetailTVSeriesBloc;
  late FakeTVSeriesRecommendationsBloc fakeTVSeriesRecommendationsBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesDetailEvent());
    registerFallbackValue(FakeTVSeriesDetailState());
    fakeDetailTVSeriesBloc = FakeDetailTVSeriesBloc();

    registerFallbackValue(FakeTVSeriesRecommendationsEvent());
    registerFallbackValue(FakeTVSeriesRecommendationsState());
    fakeTVSeriesRecommendationsBloc = FakeTVSeriesRecommendationsBloc();

    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());
    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTVSeriesBloc>(
          create: (_) => fakeDetailTVSeriesBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (_) => fakeWatchlistTVSeriesBloc,
        ),
        BlocProvider<RecommendationTVSeriesBloc>(
          create: (_) => fakeTVSeriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailTVSeriesBloc.close();
    fakeWatchlistTVSeriesBloc.close();
    fakeTVSeriesRecommendationsBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTVSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTVSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesHasData(testTVSeriesDetailResponseEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTVSeriesHasData(testTVSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertDataTVSeriesToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTVSeriesHasData(testTVSeriesDetailResponseEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTVSeriesHasData(testTVSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertDataTVSeriesToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
  });
}
