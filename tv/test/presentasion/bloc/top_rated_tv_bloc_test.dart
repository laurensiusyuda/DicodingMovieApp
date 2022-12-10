import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_top_rated/tv_top_rated_event.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  final tTv = TvEntity(
    backdropPath: '/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg',
    genreIds: [14, 12, 28],
    id: 338953,
    originalName: 'Fantastic Beasts: The Secrets of Dumbledore',
    overview:
        'Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald\'s growing legion of followers.',
    popularity: 3456.961,
    posterPath: '/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg',
    firstAirDate: '2022-04-06',
    name: 'Fantastic Beasts: The Secrets of Dumbledore',
    voteAverage: 6.9,
    voteCount: 1795,
  );

  final tTvList = <TvEntity>[tTv];

  blocTest<TopRatedTvBloc, StateRequest>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTv()),
    expect: () => [
      Loading(),
      HasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, StateRequest>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTv()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
