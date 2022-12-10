import 'package:core/data/models/tv_series/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const testTVShowResponse = TvDetailResponse(
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    type: 'type',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    overview: 'overview',
    voteCount: 1,
    tagline: 'tagline',
    originalName: 'originalName',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    backdropPath: 'backdropPath',
    status: 'status',
  );

  final testTVShowMap = testTVShowResponse.toJson();

  test('should be a map of TVShow', () async {
    final result = testTVShowResponse.toJson();
    expect(result, testTVShowMap);
  });

  test('should be a TVShowDetailResponse instance', () async {
    final result = TvDetailResponse.fromJson(testTVShowMap);
    expect(result, testTVShowResponse);
  });
}
