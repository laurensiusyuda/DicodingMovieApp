import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/repository.dart';

class SaveWatchlistTv {
  final MovieRepository repository;
  SaveWatchlistTv(this.repository);
  Future<Either<Failure, String>> execute(TvDetailEntity tv) {
    return repository.saveTvWatchlist(tv);
  }
}
