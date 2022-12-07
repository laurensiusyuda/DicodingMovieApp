import 'package:core/data/models/tv_series/tv_genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_entities/genre.dart';

void main() {
  const tGenreModel = TvGenreModel(
    id: 1,
    name: 'genre',
  );

  const tGenre = TvGenreEntity(
    id: 1,
    name: 'genre',
  );

  final tGenreJson = {
    'id': 1,
    'name': 'genre',
  };

  test('should be a subclass Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a subclass Genre Json', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}
