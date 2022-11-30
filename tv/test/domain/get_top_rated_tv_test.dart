import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_top_rated_tv.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockMovieRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockMovieRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tTvs = <TvEntity>[];

  test('should get list of Tvs from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv()).thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
