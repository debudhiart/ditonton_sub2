import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/watch_list_card.dart';

import 'package:flutter/material.dart';

class ListWatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/list_watchlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Ditonton'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
              child: WatchListCard(
                icon: Icons.movie_creation_outlined,
                title: "Watchlist Movie",
              ),
            ),
            SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVSeriesPage.ROUTE_NAME);
              },
              child: WatchListCard(
                icon: Icons.live_tv_rounded,
                title: "Watchlist TV Series",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
