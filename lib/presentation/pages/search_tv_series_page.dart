import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/empty_message.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTVSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVSeriesBloc, SearchTVSeriesState>(
              builder: (context, state) {
                if (state is SearchTVSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTVSeriesHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return TVSeriesCard(tvSeries);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchTVSeriesError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: EmptyMessage(
                      icon: Icons.search,
                      title: "Let's search your favorite TV Series",
                    ),
                  );
                }
              },
            ),
            // Consumer<TVSeriesSearchNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       final result = data.searchResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final tvSeries = data.searchResult[index];
            //             return TVSeriesCard(tvSeries);
            //           },
            //           itemCount: result.length,
            //         ),
            //       );
            //     } else if (data.state == RequestState.Empty) {
            //       return EmptyMessage(
            //         icon: Icons.search,
            //         title: "Let's search your favorite TV Series",
            //       );
            //     } else {
            //       return Expanded(
            //         child: Container(),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
