import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/usecases_movie/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/usecases_movie/get_watchlist_status.dart';
import 'package:movie/domain/usecases/usecases_movie/remove_watchlist.dart';
import 'package:movie/domain/usecases/usecases_movie/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchlistMovies usecase;
  late MockMovieRepository mockMovieRepository;
  late GetWatchListStatusMovie usecaseStatus;
  late RemoveWatchlistMovie usecaseRemove;
  late SaveWatchlistMovie usecaseSave;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
    usecaseStatus = GetWatchListStatusMovie(mockMovieRepository);
    usecaseRemove = RemoveWatchlistMovie(mockMovieRepository);
    usecaseSave = SaveWatchlistMovie(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieList));
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlistMovies(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecaseStatus.execute(1);
    // assert
    expect(result, true);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecaseRemove.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeMovieWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecaseSave.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveMovieWatchlist(testMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
