import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/usecases/usecases_tv/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';

import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
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

  blocTest<NowPlayingTvBloc, StateRequest>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTv()),
    expect: () => [
      Loading(),
      HasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<NowPlayingTvBloc, StateRequest>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTv()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );
}
