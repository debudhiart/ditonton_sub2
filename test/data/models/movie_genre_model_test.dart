import 'package:ditonton/data/models/genre_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreMovieModel = GenreModel(
    id: 1,
    name: 'name',
  );

  group('Test Model for TV Series Season', () {
    test('should be a subclass of TV Series Detail entity', () async {
      final tGenreModel = tGenreMovieModel.toEntity();

      final result = tGenreMovieModel.toEntity();
      expect(result, tGenreModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final testGenreModelMap = tGenreMovieModel.toJson();
      // act
      final result = tGenreMovieModel.toJson();
      // assert
      expect(result, testGenreModelMap);
    });
  });
}
