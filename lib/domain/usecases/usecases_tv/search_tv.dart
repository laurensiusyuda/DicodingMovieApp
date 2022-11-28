import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/repository.dart';

class SearchTv {
  final MovieRepository repository;
  SearchTv(this.repository);
  Future<Either<Failure, List<TvEntity>>> execute(String query) {
    return repository.searchTv(query);
  }
}
