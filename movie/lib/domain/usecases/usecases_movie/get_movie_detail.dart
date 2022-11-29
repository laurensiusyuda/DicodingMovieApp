import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:core/domain/repositories/repository.dart';

class GetMovieDetail {
  final MovieRepository repository;
  GetMovieDetail(this.repository);
  Future<Either<Failure, MovieDetailEntity>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
