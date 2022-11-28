import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/repository.dart';
import 'package:core/core.dart';

class GetTvRecommendations {
  final MovieRepository repository;
  GetTvRecommendations(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
