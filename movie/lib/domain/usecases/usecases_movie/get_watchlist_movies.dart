import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:core/core.dart';
import 'package:core/domain/repositories/repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;
  GetWatchlistMovies(this._repository);
  Future<Either<Failure, List<MovieEntity>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
