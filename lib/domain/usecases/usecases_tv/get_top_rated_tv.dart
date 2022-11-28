import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/repository.dart';

class GetTopRatedTv {
  final MovieRepository repository;
  GetTopRatedTv(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getTopRatedTv();
  }
}
