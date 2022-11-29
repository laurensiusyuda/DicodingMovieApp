import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
