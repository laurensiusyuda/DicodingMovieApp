import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie/recomendation_movie/recomendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/recomendation_movie/recomendation_movie_event.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helpers.mocks.dart';

void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationBloc movieRecommendationsBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    movieRecommendationsBloc = MovieRecommendationBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(movieRecommendationsBloc.state, Empty());
  });

  blocTest<MovieRecommendationBloc, StateRequest>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecommendationId(testId)),
    expect: () => [
      Loading(),
      HasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return GetMovieRecommendationId(testId).props;
    },
  );

  blocTest<MovieRecommendationBloc, StateRequest>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecommendationId(testId)),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) => Loading(),
  );
}
