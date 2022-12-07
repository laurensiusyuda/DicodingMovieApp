import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

void main() {
  const tTvModel = TvModel(
    genreIds: [10759, 10765],
    id: 52814,
    name: 'Halo',
    originalName: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    popularity: 10330.342,
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
    voteAverage: 8.7,
    voteCount: 420,
  );

  final tTv = TvEntity(
    genreIds: const [10759, 10765],
    id: 52814,
    name: 'Halo',
    originalName: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    popularity: 10330.342,
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
    voteAverage: 8.7,
    voteCount: 420,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
