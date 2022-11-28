import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/repository.dart';

class GetWatchlistTv {
  final MovieRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<TvEntity>>> execute() {
    return _repository.getWatchlistTv();
  }
}
