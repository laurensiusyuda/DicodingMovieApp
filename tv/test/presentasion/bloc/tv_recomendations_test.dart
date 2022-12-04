import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv/tv_recomendation/tv_recomendation_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_recomendation/tv_recomendation_event.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../helpers/tv_helper.mocks.dart';

void main() {
  late MockGetTvRecommendations usecase;
  late TvRecommendationBloc tvShowRecommendationsBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetTvRecommendations();
    tvShowRecommendationsBloc = TvRecommendationBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(tvShowRecommendationsBloc.state, Empty());
  });

  blocTest<TvRecommendationBloc, StateRequest>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId)).thenAnswer((_) async => Right(testTvList));
      return tvShowRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const GetTvRecommendationId(testId)),
    expect: () => [
      Loading(),
      HasData(testTvList),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return const GetTvRecommendationId(testId).props;
    },
  );

  blocTest<TvRecommendationBloc, StateRequest>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const GetTvRecommendationId(testId)),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) => Loading(),
  );
}
