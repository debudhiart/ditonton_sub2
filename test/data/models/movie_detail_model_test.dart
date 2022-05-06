import 'package:ditonton/data/models/movie_detail_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    popularity: 1,
    posterPath: 'posterPath',
    title: 'title',
    releaseDate: 'releaseDate',
    genres: [],
    imdbId: 'imdbId',
    video: false,
    runtime: 1,
    id: 1,
    overview: 'overview',
    voteCount: 1,
    adult: false,
    revenue: 1,
    tagline: 'tagline',
    originalTitle: 'originalTitle',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    backdropPath: 'backdropPath',
    budget: 2,
    status: 'status',
  );

  group('Test Model for Movie Detail', () {
    test('should be a subclass of TV Series Detail entity', () async {
      final testMovieDetail = tMovieDetailResponse.toEntity();

      final result = tMovieDetailResponse.toEntity();
      expect(result, testMovieDetail);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final tMovieDetailsMap = tMovieDetailResponse.toJson();
      // act
      final result = tMovieDetailResponse.toJson();
      // assert
      expect(result, tMovieDetailsMap);
    });
  });
}
