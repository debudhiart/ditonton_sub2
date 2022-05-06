import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
// import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';

// import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
// import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   Provider.of<TVSeriesDetailNotifier>(context, listen: false)
    //       .fetchTVSeriesDetail(widget.id);
    //   Provider.of<TVSeriesDetailNotifier>(context, listen: false)
    //       .loadWatchlistStatus(widget.id);
    // });

    Future.microtask(() {
      context
          .read<DetailTVSeriesBloc>()
          .add(DetailTVSeriesAppellation(widget.id));
      context
          .read<RecommendationTVSeriesBloc>()
          .add(RecommendationTVSeriesAppellation(widget.id));
      context
          .read<WatchlistTVSeriesBloc>()
          .add(GotWatchlistTVSeries(widget.id));
      // Provider.of<MovieDetailNotifier>(context, listen: false)
      //     .fetchMovieDetail(widget.id);
      // Provider.of<MovieDetailNotifier>(context, listen: false)
      //     .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWatchlistStatus =
        context.select<WatchlistTVSeriesBloc, bool>((bloc) {
      if (bloc.state is InsertDataTVSeriesToWatchlist) {
        return (bloc.state as InsertDataTVSeriesToWatchlist).watchlistStatus;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailTVSeriesBloc, DetailTVSeriesState>(
        builder: (context, state) {
          if (state is DetailTVSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTVSeriesHasData) {
            final data = state.result;
            return SafeArea(
              child: DetailContent(
                data,
                isWatchlistStatus,
              ),
            );
          } else if (state is DetailTVSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
      // Consumer<TVSeriesDetailNotifier>(
      //   builder: (context, provider, child) {
      //     if (provider.tvSeriesState == RequestState.Loading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (provider.tvSeriesState == RequestState.Loaded) {
      //       final tvSeries = provider.tvSeries;
      //       return SafeArea(
      //         child: DetailContent(
      //           tvSeries,
      //           provider.tvSeriesRecommendations,
      //           provider.isAddedTVSeriesToWatchlist,
      //           provider,
      //         ),
      //       );
      //     } else {
      //       return Text(provider.message);
      //     }
      //   },
      // ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVSeriesDetail tvSeries;
  // final List<TVSeries> recommendations;
  late bool isWatchlistStatus;
  // final TVSeriesDetailNotifier provider;

  // DetailContent(this.tvSeries, this.recommendations, this.isAddedWatchlist,
  //     this.provider);

  DetailContent(
    this.tvSeries,
    this.isWatchlistStatus,
  );

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isWatchlistStatus) {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      InsertWatchlistTVSeries(widget.tvSeries));
                                } else {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      DeleteWatchlistTVSeries(widget.tvSeries));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTVSeriesBloc>(
                                            context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String deleteMessage = "Removed from Watchlist";

                                if (state is InsertDataTVSeriesToWatchlist) {
                                  final isAdded = state.watchlistStatus;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = deleteMessage;
                                  }
                                } else {
                                  if (!widget.isWatchlistStatus) {
                                    message = insertMessage;
                                  } else {
                                    message = deleteMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == deleteMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                    action: SnackBarAction(
                                      label: 'See Watchlist',
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            WatchlistTVSeriesPage.ROUTE_NAME);
                                      },
                                    ),
                                  ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isWatchlistStatus =
                                      !widget.isWatchlistStatus;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.isWatchlistStatus)
                                    Icon(Icons.check)
                                  else
                                    Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Text(
                              _formattedDuration(
                                  widget.tvSeries.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Episodes: ' +
                                  widget.tvSeries.numberOfEpisodes.toString(),
                            ),
                            Text(
                              'Season: ' +
                                  widget.tvSeries.numberOfSeasons.toString(),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTVSeriesBloc,
                                RecommendationTVSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationTVSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTVSeriesHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$BASE_IMAGE_URL${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else if (state
                                    is RecommendationTVSeriesError) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(state.message),
                                    ),
                                  );
                                } else {
                                  return const Text(
                                      'There is no recommendations');
                                }
                              },
                            ),
                            // if (provider.tvSeriesRecommendations.isEmpty)
                            //   Container(
                            //     child: Text(
                            //       'There is no recommendations',
                            //     ),
                            //   )
                            // else
                            //   Consumer<TVSeriesDetailNotifier>(
                            //     builder: (context, data, child) {
                            //       if (data.recommendationStateTVSeries ==
                            //           RequestState.Loading) {
                            //         return Center(
                            //           child: CircularProgressIndicator(),
                            //         );
                            //       } else if (data.recommendationStateTVSeries ==
                            //           RequestState.Error) {
                            //         return Text(data.message);
                            //       } else if (data.recommendationStateTVSeries ==
                            //           RequestState.Loaded) {
                            //         return SizedBox(
                            //           child: Column(
                            //             children: <Widget>[
                            //               _buildRecommendationsTVSeriesItem(
                            //                   context),
                            //             ],
                            //           ),
                            //         );
                            //       } else {
                            //         return Container();
                            //       }
                            //     },
                            //   ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            // if (provider.tvSeries.seasons.isEmpty)
                            //   Container(
                            //     child: Text(
                            //       'There is no Season',
                            //     ),
                            //   )
                            // else
                            BlocBuilder<RecommendationTVSeriesBloc,
                                RecommendationTVSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationTVSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTVSeriesHasData) {
                                  final result = state.result;
                                  return Column(
                                    children: <Widget>[
                                      widget.tvSeries.seasons.isNotEmpty
                                          ? Container(
                                              height: 150,
                                              margin: EdgeInsets.only(top: 8.0),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (ctx, index) {
                                                  final season = widget
                                                      .tvSeries.seasons[index];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8),
                                                      ),
                                                      child: season
                                                                  .posterPath ==
                                                              null
                                                          ? Container(
                                                              width: 96.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: kGrey,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .hide_image,
                                                                ),
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  '$BASE_IMAGE_URL${season.posterPath}',
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                    ),
                                                  );
                                                },
                                                itemCount: widget
                                                    .tvSeries.seasons.length,
                                              ),
                                            )
                                          : Text('-'),
                                    ],
                                  );
                                } else if (state
                                    is RecommendationTVSeriesError) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(state.message),
                                    ),
                                  );
                                } else {
                                  return const Text('There is no season');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  // Widget _buildRecommendationsTVSeriesItem(
  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _formattedDuration(List<int> runtimes) =>
      runtimes.map((runtime) => _showDuration(runtime)).join(", ");
}
