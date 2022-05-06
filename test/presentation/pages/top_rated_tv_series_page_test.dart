import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_series_page_helper.dart';

void main() {
  late FakeTopRatedTVSeriesBloc fakeTopRatedTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedTVSeriesEvent());
    registerFallbackValue(FakeTopRatedTVSeriesState());
    fakeTopRatedTVSeriesBloc = FakeTopRatedTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>(
      create: (_) => fakeTopRatedTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTopRatedTVSeriesBloc.close();
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(progressFinder, findsOneWidget);
  });
}
