import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/on_the_air_now_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

class HomeTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series';
  @override
  _HomeTVSeriesPageState createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<OnTheAirNowTVSeriesBloc>()
          .add(OnTheAirNowTVSeriesAppellation());
      context.read<PopularTVSeriesBloc>().add(PopularTVSeriesAppellation());
      context.read<TopRatedTVSeriesBloc>().add(TopRatedTVSeriesAppellation());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Ditonton (TV Series)'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On The Air Now',
                style: kHeading6,
              ),
              BlocBuilder<OnTheAirNowTVSeriesBloc, OnTheAirNowTVSeriesState>(
                builder: (context, state) {
                  if (state is OnTheAirNowTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirNowTVSeriesHasData) {
                    final data = state.result;
                    return
                        // Text('Failed');
                        TVSeriesList(
                      tvSeries: data,
                      key: Key('on_the_air_now_tv_series'),
                    );
                  } else if (state is OnTheAirNowTVSeriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
                builder: (context, state) {
                  if (state is PopularTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTVSeriesHasData) {
                    final data = state.result;
                    return
                        // Text('Failed');
                        TVSeriesList(
                      tvSeries: data,
                      key: Key('popular_tv_series'),
                    );
                  } else if (state is PopularTVSeriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTVSeriesHasData) {
                    final data = state.result;
                    return
                        // Text('Failed');
                        TVSeriesList(
                      tvSeries: data,
                      key: Key('top_rated_tv_series'),
                    );
                  } else if (state is TopRatedTVSeriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TVSeriesList({Key? key, required this.tvSeries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final atvSeries = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: atvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${atvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
