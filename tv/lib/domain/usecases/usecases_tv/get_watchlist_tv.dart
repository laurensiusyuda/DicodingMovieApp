import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

class GetWatchlistTv {
  final MovieRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<TvEntity>>> execute() {
    return _repository.getWatchlistTv();
  }
}
