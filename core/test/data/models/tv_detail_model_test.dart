import 'package:core/data/models/tv_series/tv_detail_model.dart';
import 'package:core/data/models/tv_series/tv_genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

main() {
  const testTvDetailModel = TvDetailResponse(
    backdropPath: 'backdropPath',
    genres: [TvGenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    status: 'Status',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    tagline: 'Tagline',
    name: 'name',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  const testTvDetail = TvDetailEntity(
    backdropPath: 'backdropPath',
    genres: [TvGenreEntity(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetailJson = {
    "backdrop_path": "backdropPath",
    "genres": [
      {'id': 1, 'name': 'Action'}
    ],
    "homepage": "https://google.com",
    "id": 1,
    "original_language": "en",
    "original_name": "originalName",
    "overview": "overview",
    "popularity": 1,
    "poster_path": "posterPath",
    "first_air_date": "firstAirDate",
    "status": "Status",
    "number_of_episodes": 1,
    "number_of_seasons": 1,
    "tagline": "Tagline",
    "name": "name",
    "type": "type",
    "vote_average": 1,
    "vote_count": 1,
  };

  final testTVShowMap = testTvDetailModel.toJson();

  test('should be a map of TVShow', () async {
    final result = testTvDetailModel.toEntity();
    expect(result, testTvDetail);
  });
  test('should be a subclass TV Detail JSON', () async {
    final result = testTvDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
  test('should be a TVShowDetailResponse instance', () async {
    final result = TvDetailResponse.fromJson(testTVShowMap);
    expect(result, testTvDetailModel);
  });
}
