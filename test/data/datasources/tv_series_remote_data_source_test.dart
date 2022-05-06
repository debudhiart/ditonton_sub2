import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TVSeriesRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TV Series', () {
    final testTVShowList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_on_the_air.json')))
        .tvSeriesList;

    test('should return list of TVShow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_on_the_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getOnTheAirTVSeries();
      // assert
      expect(result, equals(testTVShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getOnTheAirTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Detail', () {
    final tId = 2;
    final testTVDetail = TVSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    test('should be return tv show detail when the response code is 200',
        () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSourceImpl.getTVSeriesDetail(tId);
      //assert
      expect(result, equals(testTVDetail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSourceImpl.getTVSeriesDetail(tId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Recommendations', () {
    final testRecommendationTVShowList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .tvSeriesList;
    final tId = 1;
    test(
        'should be return  tv show recommendation when the response code is 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSourceImpl.getTVSeriesRecommendations(tId);
      //assert
      expect(result, equals(testRecommendationTVShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTVSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVShows', () {
    final testTVShowList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_popular.json')))
        .tvSeriesList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_popular.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getPopularTVSeries();
      // assert
      expect(result, testTVShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getPopularTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get Top Rated TVShows', () {
    final testTVShowList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_top_rated.json')))
        .tvSeriesList;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_top_rated.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getTopRatedTVSeries();
      // assert
      expect(result, testTVShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTopRatedTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tSearchResult = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_naruto_tv_series.json')))
        .tvSeriesList;
    final tQuery = 'Avengers';
    test('should be return list of tv shows when response code is 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_naruto_tv_series.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSourceImpl.searchTVSeries(tQuery);

      //assert
      expect(result, tSearchResult);
    });

    test('should be throw ServerException when response code is other 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSourceImpl.searchTVSeries(tQuery);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
