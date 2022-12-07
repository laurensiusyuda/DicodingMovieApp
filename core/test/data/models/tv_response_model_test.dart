import 'dart:convert';

import 'package:core/data/models/movie_models/movie_model.dart';
import 'package:core/data/models/movie_models/movie_response.dart';
import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:core/data/models/tv_series/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import '../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvResponseModel = TvResponse(tvShowList: <TvModel>[tTvModel]);

  group('toJson', () {
    test('should return a JSON to map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "Name",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
