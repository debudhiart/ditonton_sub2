import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/empty_message.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-tv-series';

  @override
  _TopRatedTVSeriesPageState createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<TopRatedTVSeriesNotifier>(context, listen: false)
    //       .fetchTopRatedTVSeries(),
    // );
    Future.microtask(() {
      context.read<TopRatedTVSeriesBloc>().add(TopRatedTVSeriesAppellation());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTVSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVSeriesHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final movie = result[index];
                    return TVSeriesCard(movie);
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is TopRatedTVSeriesError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Expanded(
                child: EmptyMessage(
                  icon: Icons.movie_filter_outlined,
                  title: "No have data top rated TV Series",
                ),
              );
            }
          },
        ),
        // Consumer<TopRatedTVSeriesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tvSeries = data.tvSeries[index];
        //           return TVSeriesCard(tvSeries);
        //         },
        //         itemCount: data.tvSeries.length,
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
}
