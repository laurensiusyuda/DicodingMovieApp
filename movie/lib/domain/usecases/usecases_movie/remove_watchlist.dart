import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:core/domain/repositories/repository.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;
  RemoveWatchlistMovie(this.repository);
  Future<Either<Failure, String>> execute(MovieDetailEntity movie) {
    return repository.removeMovieWatchlist(movie);
  }
}
