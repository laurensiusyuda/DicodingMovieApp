import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_popular_tv.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockMovieRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockMovieRepository();
    usecase = GetPopularTv(mockTvRpository);
  });

  final tTv = <TvEntity>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of Tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTv())
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
