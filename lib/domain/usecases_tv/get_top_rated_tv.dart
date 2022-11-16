import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository tvRepository;
  GetTopRatedTv(this.tvRepository);
  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getTopRatedTv();
  }
}
