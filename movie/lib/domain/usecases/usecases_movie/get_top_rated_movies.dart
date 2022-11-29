import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';

class GetTopRatedMovies {
  final MovieRepository repository;
  GetTopRatedMovies(this.repository);
  Future<Either<Failure, List<MovieEntity>>> execute() {
    return repository.getTopRatedMovies();
  }
}
