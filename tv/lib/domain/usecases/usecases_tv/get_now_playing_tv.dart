import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:core/core.dart';

class GetNowPlayingTv {
  final MovieRepository repository;
  GetNowPlayingTv(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getNowPlayingTv();
  }
}
