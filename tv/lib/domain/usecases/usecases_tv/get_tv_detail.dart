import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

class GetTvDetail {
  final MovieRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetailEntity>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
