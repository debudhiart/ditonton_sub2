import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../helpers/tv_series_page_helper.dart';
import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTVSeriesNotifier])
void main() {
  late FakePopularTVSeriesBloc fakePopularTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakePopularTVSeriesEvent());
    registerFallbackValue(FakePopularTVSeriesState());
    fakePopularTVSeriesBloc = FakePopularTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVSeriesBloc>(
      create: (_) => fakePopularTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );

    // ChangeNotifierProvider<PopularTVSeriesNotifier>.value(
    //   value: mockNotifier,
    //   child: MaterialApp(
    //     home: body,
    //   ),
    // );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());
    // when(mockNotifier.tvSeries).thenReturn(<TVSeries>[]);

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(progressFinder, findsOneWidget);
  });
}
