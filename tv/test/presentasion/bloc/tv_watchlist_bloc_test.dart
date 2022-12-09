import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_event.dart';
import 'package:tv/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../helpers/tv_helper.mocks.dart';

void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistTv getWatchlistTVShows;
  late MockGetWatchListStatusTv getWatchlistTVStatus;
  late MockSaveWatchlistTv saveTVWatchList;
  late MockRemoveWatchlistTv removeTVWatchlist;
  late WatchlistTvBloc watchlistBloc;

  setUp(() {
    getWatchlistTVShows = MockGetWatchlistTv();
    getWatchlistTVStatus = MockGetWatchListStatusTv();
    saveTVWatchList = MockSaveWatchlistTv();
    removeTVWatchlist = MockRemoveWatchlistTv();
    watchlistBloc = WatchlistTvBloc(
      getWatchlistTVShows,
      getWatchlistTVStatus,
      saveTVWatchList,
      removeTVWatchlist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, Empty());
  });

  group(
    'this test for get watchlist tv, ',
    () {
      blocTest<WatchlistTvBloc, StateRequest>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTVShows.execute())
              .thenAnswer((_) async => Right([testWatchlistTv]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(WatchlistTv()),
        expect: () => [
          Loading(),
          HasData([testWatchlistTv]),
        ],
        verify: (bloc) {
          verify(getWatchlistTVShows.execute());
          return WatchlistTv().props;
        },
      );

      blocTest<WatchlistTvBloc, StateRequest>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTVShows.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(WatchlistTv()),
        expect: () => [
          Loading(),
          Error('Server Failure'),
        ],
        verify: (bloc) => Loading(),
      );
    },
  );

  group(
    'this test for add and remove watchlist,',
    () {
      blocTest<WatchlistTvBloc, StateRequest>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveTVWatchList.execute(testTVShowDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddWatchlist(testTVShowDetail)),
        expect: () => [
          HasMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveTVWatchList.execute(testTVShowDetail));
          return AddWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, StateRequest>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveTVWatchList.execute(testTVShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddWatchlist(testTVShowDetail)),
        expect: () => [
          Error('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveTVWatchList.execute(testTVShowDetail));
          return AddWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, StateRequest>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeTVWatchlist.execute(testTVShowDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testTVShowDetail)),
        expect: () => [
          HasMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeTVWatchlist.execute(testTVShowDetail));
          return RemoveFromWatchlist(testTVShowDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, StateRequest>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeTVWatchlist.execute(testTVShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testTVShowDetail)),
        expect: () => [
          Error('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeTVWatchlist.execute(testTVShowDetail));
          return RemoveFromWatchlist(testTVShowDetail).props;
        },
      );
    },
  );
}
