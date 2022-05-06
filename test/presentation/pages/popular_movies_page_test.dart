import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../helpers/movie_page_helper.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late FakePopularMoviesBloc fakePopularMoviesBloc;

  setUp(() {
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMoviesBloc = FakePopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => fakePopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
    // ChangeNotifierProvider<PopularMoviesNotifier>.value(
    //   value: mockNotifier,
    //   child: MaterialApp(
    //     home: body,
    //   ),
    // );
  }

  tearDown(() {
    fakePopularMoviesBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(progressFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });
}
