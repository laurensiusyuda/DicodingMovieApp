import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/repositories/repository.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';

class GetTopRatedMovies {
  final MovieRepository repository;
  GetTopRatedMovies(this.repository);
  Future<Either<Failure, List<MovieEntity>>> execute() {
    return repository.getTopRatedMovies();
  }
}
