import 'package:core/domain/repositories/repository.dart';

class GetWatchListStatusMovie {
  final MovieRepository repository;

  GetWatchListStatusMovie(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistMovies(id);
  }
}
