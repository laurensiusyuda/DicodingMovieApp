import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/repository.dart';
import 'package:core/core.dart';

class GetNowPlayingTv {
  final MovieRepository repository;
  GetNowPlayingTv(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute() {
    return repository.getNowPlayingTv();
  }
}
