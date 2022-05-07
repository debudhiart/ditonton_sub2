import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_series_page_helper.dart';

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
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(viewProgress, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(progressFinder, findsOneWidget);
  });
}
