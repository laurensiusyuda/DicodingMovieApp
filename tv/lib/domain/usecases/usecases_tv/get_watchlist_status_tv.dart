import 'package:core/domain/repositories/repository.dart';

class GetWatchListStatusTv {
  final MovieRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
