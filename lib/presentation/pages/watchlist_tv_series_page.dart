import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/empty_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
