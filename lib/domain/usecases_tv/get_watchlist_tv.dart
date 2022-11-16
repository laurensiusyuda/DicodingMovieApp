import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetWatchlistTv {
  final TvRepository _tvRepository;

  GetWatchlistTv(this._tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _tvRepository.getWatchlistTv();
  }
}
