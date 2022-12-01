import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/usecases_tv/get_watchlist_tv.dart';

import '../dummy_data/dummy_objects_tv.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockMovieRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockMovieRepository();
    usecase = GetWatchlistTv(mockTvRepository);
  });

  test('should get list of Tv from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
