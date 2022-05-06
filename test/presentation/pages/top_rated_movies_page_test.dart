import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';
import '../../helpers/movie_page_helper.dart';

@GenerateMocks([TopRatedMoviesNotifier])
void main() {
  // late MockTopRatedMoviesNotifier mockNotifier;
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;

  setUp(() {
    // mockNotifier = MockTopRatedMoviesNotifier();
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (_) => fakeTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
    // ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
    //   value: mockNotifier,
    //   child: MaterialApp(
    //     home: body,
    //   ),
    // );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });
}
