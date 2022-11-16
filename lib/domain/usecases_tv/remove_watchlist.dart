import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository tvRepository;

  RemoveWatchlistTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return tvRepository.removeWatchlistTv(tv);
  }
}
