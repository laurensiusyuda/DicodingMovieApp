import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/usecases_tv/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/usecases_tv/remove_watchlist.dart';
import 'package:tv/domain/usecases/usecases_tv/save_watchlist.dart';

import '../dummy_data/dummy_objects_tv.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late SaveWatchlistTv usecaseSaveWatchlist;
  late RemoveWatchlistTv usecaseRemove;
  late MockMovieRepository mockTvRepository;
  late GetWatchlistTv usecaseGet;

  setUp(() {
    mockTvRepository = MockMovieRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
    usecaseSaveWatchlist = SaveWatchlistTv(mockTvRepository);
    usecaseRemove = RemoveWatchlistTv(mockTvRepository);
    usecaseGet = GetWatchlistTv(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
  test('should save Tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveTvWatchlist(testTVShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecaseSaveWatchlist.execute(testTVShowDetail);
    // assert
    verify(mockTvRepository.saveTvWatchlist(testTVShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
  test('should remove watchlist Tv from repository', () async {
    // arrange
    when(mockTvRepository.removeTvWatchlist(testTVShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecaseRemove.execute(testTVShowDetail);
    // assert
    verify(mockTvRepository.removeTvWatchlist(testTVShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
  test('should get list of Tv from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecaseGet.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
