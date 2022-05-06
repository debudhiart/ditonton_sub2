import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/empty_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
    //         .fetchWatchlistTVSeries());
    Future.microtask(() {
      context.read<WatchlistTVSeriesBloc>().add(OnGotWatchlistTVSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTVSeriesBloc>().add(OnGotWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist (TV Series)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTVSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTVSeriesHasData) {
              final result = state.result;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return TVSeriesCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            } else if (state is WatchlistTVSeriesEmpty) {
              return EmptyMessage(
                icon: Icons.movie_filter_outlined,
                title: "Don't have watchlist yet",
              );
            } else if (state is WatchlistTVSeriesError) {
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

        // Consumer<WatchlistTVSeriesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.watchlistState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.watchlistState == RequestState.Loaded) {
        //       if (data.watchlistTVSeries.isEmpty)
        //         return EmptyMessage(
        //           icon: Icons.movie_filter_outlined,
        //           title: "Don't have watchlist yet",
        //         );
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final atvSeries = data.watchlistTVSeries[index];
        //           return TVSeriesCard(atvSeries);
        //         },
        //         itemCount: data.watchlistTVSeries.length,
        //       );
        //     } else if (data.watchlistState == RequestState.Empty) {
        //       return EmptyMessage(
        //         icon: Icons.tv_rounded,
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
