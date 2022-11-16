import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetOnTheAirTv {
  final TvRepository tvRepository;
  GetOnTheAirTv(this.tvRepository);
  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getOnTheAirTv();
  }
}
