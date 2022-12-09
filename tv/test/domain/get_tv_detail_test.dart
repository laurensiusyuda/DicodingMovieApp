import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/usecases_tv/get_tv_detail.dart';

import '../dummy_data/dummy_objects_tv.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockMovieRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockMovieRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tId = 1;

  test('should get Tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTVShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVShowDetail));
  });
}
