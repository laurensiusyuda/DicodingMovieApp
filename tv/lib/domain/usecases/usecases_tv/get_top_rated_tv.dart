import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

class GetTopRatedTv {
  final MovieRepository repository;
  GetTopRatedTv(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getTopRatedTv();
  }
}
