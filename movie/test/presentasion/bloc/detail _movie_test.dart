import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_event.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helpers.mocks.dart';

void main() {
  late MockGetMovieDetail usecase;
  late MovieDetailBloc movieDetailBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(movieDetailBloc.state, Empty());
  });

  blocTest<MovieDetailBloc, StateRequest>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(testId)),
    expect: () => [
      Loading(),
      HasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return FetchMovieDetail(testId).props;
    },
  );

  blocTest<MovieDetailBloc, StateRequest>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(testId)),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) => Loading(),
  );
}
