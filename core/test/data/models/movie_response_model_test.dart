import 'dart:convert';
import 'dart:io';
import 'package:core/data/models/movie_models/movie_model.dart';
import 'package:core/data/models/movie_models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
    genreIds: [28, 878, 35, 10751, 12],
    id: 675353,
    originalTitle: "Sonic the Hedgehog 2",
    overview:
        "After settling in Green Hills, Sonic s eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.",
    popularity: 10135.117,
    posterPath: "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
    releaseDate: "2022-03-30",
    title: "Sonic the Hedgehog 2",
    video: false,
    voteAverage: 7.7,
    voteCount: 1019,
  );
  const tMovieResponseModel =
      MovieResponse(movieList: <MovieModel>[tMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
            "genre_ids": [28, 878, 35, 10751, 12],
            "id": 675353,
            "original_title": "Sonic the Hedgehog 2",
            "overview":
                "After settling in Green Hills, Sonic s eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.",
            "popularity": 10135.117,
            "poster_path": "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
            "release_date": "2022-03-30",
            "title": "Sonic the Hedgehog 2",
            "video": false,
            "vote_average": 7.7,
            "vote_count": 1019
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
