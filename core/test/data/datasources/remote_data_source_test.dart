import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/remote_data_source.dart';
import 'package:core/data/models/movie_models/movie_detail_model.dart';
import 'package:core/data/models/movie_models/movie_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_movie.json')))
        .movieList;

    test('should return list of Movie Model when the response is success',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/now_playing_movie.json'), 200));

      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response is success ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result.isNotEmpty, tMovieList.isNotEmpty);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/675353?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(675353);
      // assert
      expect(result.id, equals(tMovieDetail.id));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/1?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(1);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/recommendations.json')))
        .movieList;

    test('should return list of Movie Model when the response is success',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/movie/675353/recommendations?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/recommendations.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(675353);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/movie/1/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(1);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/search.json')))
            .movieList;

    test('should return list of movies when response is success', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=Spiderman')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search.json'), 200));
      // act
      final result = await dataSource.searchMovies('Spiderman');
      // assert
      expect(result.isNotEmpty, tSearchResult.isNotEmpty);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=Spiderman')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies('Spiderman');
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
