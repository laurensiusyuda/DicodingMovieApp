import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/usecases_tv/save_watchlist.dart';

import '../dummy_data/dummy_objects_tv.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockMovieRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockMovieRepository();
    usecase = SaveWatchlistTv(mockTvRepository);
  });

  test('should save Tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveTvWatchlist(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
