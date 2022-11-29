import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';
import 'package:core/domain/repositories/repository.dart';

class SaveWatchlistTv {
  final MovieRepository repository;
  SaveWatchlistTv(this.repository);
  Future<Either<Failure, String>> execute(TvDetailEntity tv) {
    return repository.saveTvWatchlist(tv);
  }
}
