import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/repository.dart';
import 'package:core/core.dart';

class GetTvDetail {
  final MovieRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetailEntity>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
