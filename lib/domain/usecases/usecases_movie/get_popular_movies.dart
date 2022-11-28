import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/repository.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';

class GetPopularMovies {
  final MovieRepository repository;
  GetPopularMovies(this.repository);
  Future<Either<Failure, List<MovieEntity>>> execute() {
    return repository.getPopularMovies();
  }
}
