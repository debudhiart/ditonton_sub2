import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(DetailMovieAppellation(widget.id));
      context
          .read<RecommendationMoviesBloc>()
          .add(RecommendationMoviesAppellation(widget.id));
      context.read<WatchlistMovieBloc>().add(GotWatchlistMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWatchlistStatus = context.select<WatchlistMovieBloc, bool>((bloc) {
      if (bloc.state is InsertDataMovieToWatchlist) {
        return (bloc.state as InsertDataMovieToWatchlist).watchlistStatus;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            final data = state.result;
            return SafeArea(
              child: DetailContent(
                data,
                isWatchlistStatus,
              ),
            );
          } else if (state is DetailMovieError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
      // Consumer<MovieDetailNotifier>(
      //   builder: (context, provider, child) {
      //     if (provider.movieState == RequestState.Loading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (provider.movieState == RequestState.Loaded) {
      //       final movie = provider.movie;
      //       return SafeArea(
      //         child: DetailContent(
      //           movie,
      //           provider.movieRecommendations,
      //           provider.isAddedToWatchlist,
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
  final MovieDetail movie;
  // final List<Movie> recommendations;
  late bool isWatchlistStatus;

  DetailContent(
    this.movie,
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
          imageUrl: '$BASE_IMAGE_URL${widget.movie.posterPath}',
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
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isWatchlistStatus) {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(InsertWatchlistMovie(widget.movie));
                                } else {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(DeleteWatchlistMovie(widget.movie));
                                }

                                final state =
                                    BlocProvider.of<WatchlistMovieBloc>(context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String deleteMessage = "Removed from Watchlist";

                                if (state is InsertDataMovieToWatchlist) {
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
                                            WatchlistMoviesPage.ROUTE_NAME);
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
                            // BlocBuilder<WatchlistMovieBloc,
                            //     WatchlistMovieState>(builder: (context, state) {
                            //   if (state is WatchlistMovieLoading) {
                            //     return Center(
                            //         child: CircularProgressIndicator());
                            //   } else if (state is WatchlistMovieError) {
                            //     return Center(child: Text(state.message));
                            //   } else if (state is InsertDataMovieToWatchlist) {
                            //     final isAddedWatchlist = state.watchlistStatus;

                            //     return ElevatedButton(
                            //       onPressed: () async {
                            //         if (!isAddedWatchlist) {
                            //           context
                            //               .read<WatchlistMovieBloc>()
                            //               .add(InsertWatchlistMovie(movie));
                            //         } else {
                            //           context
                            //               .read<WatchlistMovieBloc>()
                            //               .add(DeleteWatchlistMovie(movie));
                            //         }
                            //       },
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           isAddedWatchlist
                            //               ? Icon(Icons.check)
                            //               : Icon(Icons.add),
                            //           Text('Watchlist'),
                            //         ],
                            //       ),
                            //     );
                            //   } else {
                            //     return Center(child: Text('Error.'));
                            //   }
                            // }),
                            // ElevatedButton(
                            //   onPressed: () async {
                            //     if (!iswatchlistStatus) {
                            //       context
                            //           .read<WatchlistMovieBloc>()
                            //           .add(InsertWatchlistMovie(movie));
                            //     } else {
                            //       context
                            //           .read<WatchlistMovieBloc>()
                            //           .add(DeleteWatchlistMovie(movie));
                            //     }

                            //     // if (!iswatchlistStatus) {
                            //     //   await Provider.of<MovieDetailNotifier>(
                            //     //           context,
                            //     //           listen: false)
                            //     //       .addWatchlist(movie);
                            //     // } else {
                            //     //   await Provider.of<MovieDetailNotifier>(
                            //     //           context,
                            //     //           listen: false)
                            //     //       .removeFromWatchlist(movie);
                            //     // }

                            //     final state =
                            //         BlocProvider.of<WatchlistMovieBloc>(context)
                            //             .state;
                            //     String message = "";

                            //     if (state is InsertDataMovieToWatchlist) {
                            //       final isInsert = state.watchlistStatus;
                            //       message = isInsert == false
                            //           ? 'Added to Watchlist'
                            //           : 'Removed from Watchlist';
                            //     } else {
                            //       message = !iswatchlistStatus
                            //           ? 'Added to Watchlist'
                            //           : 'Removed from Watchlist';
                            //     }

                            //     if (message == 'Added to Watchlist' ||
                            //         message == 'Removed from Watchlist') {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text(message)));
                            //     } else {
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return AlertDialog(
                            //               content: Text(message),
                            //             );
                            //           });
                            //     }

                            //     emit(() {
                            //       iswatchlistStatus = !iswatchlistStatus;
                            //     });

                            //     // if (message ==
                            //     //         MovieDetailNotifier
                            //     //             .watchlistAddSuccessMessage ||
                            //     //     message ==
                            //     //         MovieDetailNotifier
                            //     //             .watchlistRemoveSuccessMessage) {
                            //     //   ScaffoldMessenger.of(context).showSnackBar(
                            //     //       SnackBar(content: Text(message)));
                            //     // } else {
                            //     //   showDialog(
                            //     //       context: context,
                            //     //       builder: (context) {
                            //     //         return AlertDialog(
                            //     //           content: Text(message),
                            //     //         );
                            //     //       });
                            //     // }
                            //   },
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       iswatchlistStatus
                            //           ? Icon(Icons.check)
                            //           : Icon(Icons.add),
                            //       Text('Watchlist'),
                            //     ],
                            //   ),
                            // ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc,
                                RecommendationMoviesState>(
                              builder: (context, state) {
                                if (state is RecommendationMoviesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationMoviesHasData) {
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
                                                MovieDetailPage.ROUTE_NAME,
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
                                } else if (state is RecommendationMoviesError) {
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
                            // Consumer<MovieDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final movie = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     MovieDetailPage.ROUTE_NAME,
                            //                     arguments: movie.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         '$BASE_IMAGE_URL${movie.posterPath}',
                            //                     placeholder: (context, url) =>
                            //                         Center(
                            //                       child:
                            //                           CircularProgressIndicator(),
                            //                     ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: recommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
