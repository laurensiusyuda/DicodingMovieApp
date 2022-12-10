import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_detail/tv_detail_event.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../helpers/tv_helper.mocks.dart';

void main() {
  late MockGetTvDetail usecase;
  late TvDetailBloc tvBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTvDetail();
    tvBloc = TvDetailBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, Empty());
  });

  blocTest<TvDetailBloc, StateRequest>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
      return tvBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    expect: () => [
      Loading(),
      HasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return FetchTvDetail(tId).props;
    },
  );

  blocTest<TvDetailBloc, StateRequest>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) => Loading(),
  );
}
