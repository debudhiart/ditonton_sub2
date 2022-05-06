import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/empty_message.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(OnGotWatchlistMovie());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnGotWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist (Movie)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieHasData) {
              final result = state.result;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            } else if (state is WatchlistMovieEmpty) {
              return EmptyMessage(
                icon: Icons.movie_filter_outlined,
                title: "Don't have watchlist yet",
              );
            } else if (state is WatchlistMovieError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return EmptyMessage(
                icon: Icons.movie_filter_outlined,
                title: "Error get data watchlist",
              );
            }
          },
        ),
        //  Consumer<WatchlistMovieNotifier>(
        //   builder: (context, data, child) {
        //     if (data.watchlistState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.watchlistState == RequestState.Loaded) {
        //       if (data.watchlistMovies.isEmpty)
        //         return EmptyMessage(
        //           icon: Icons.movie_filter_outlined,
        //           title: "Don't have watchlist yet",
        //         );
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final movie = data.watchlistMovies[index];
        //           return MovieCard(movie);
        //         },
        //         itemCount: data.watchlistMovies.length,
        //       );
        //     } else if (data.watchlistState == RequestState.Empty) {
        //       return EmptyMessage(
        //         icon: Icons.movie_filter_outlined,
        //         title: "Don't have watchlist yet",
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
