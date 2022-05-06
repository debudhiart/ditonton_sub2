import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_tv_series.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeRunTime,
    required this.posterPath,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;

  final List<Genre> genres;
  final List<int> episodeRunTime;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        episodeRunTime,
        id,
        name,
        overview,
        posterPath,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
        voteAverage,
        voteCount
      ];
}
