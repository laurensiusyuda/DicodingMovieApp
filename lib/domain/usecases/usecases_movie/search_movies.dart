import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/repositories/repository.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);
  Future<Either<Failure, List<MovieEntity>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
