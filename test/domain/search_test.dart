import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:movie/domain/usecases/usecases_movie/search_movies.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/usecases/usecases_tv/search_tv.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase1;
  late SearchTv usecase2;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase1 = SearchMovies(mockMovieRepository);
    usecase2 = SearchTv(mockMovieRepository);
  });

  final tMovies = <MovieEntity>[];
  const tQuery = 'Spiderman';
  final tTvSeries = <TvEntity>[];
  const tQuery2 = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase1.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });

  test('should get list of Tv Series from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery2))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase2.execute(tQuery2);
    // assert
    expect(result, Right(tTvSeries));
  });
}
