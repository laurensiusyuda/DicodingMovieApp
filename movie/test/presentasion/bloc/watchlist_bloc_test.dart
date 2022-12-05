import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie/watchlist_movie/watchlist_movie_event.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helpers.mocks.dart';

void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistMovies getWatchlistMovies;
  late MockGetWatchListStatusMovie getWatchlistStatus;
  late MockRemoveWatchlistMovie removeWatchlist;
  late MockSaveWatchlistMovie saveWatchlist;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  setUp(() {
    getWatchlistMovies = MockGetWatchlistMovies();
    getWatchlistStatus = MockGetWatchListStatusMovie();
    removeWatchlist = MockRemoveWatchlistMovie();
    saveWatchlist = MockSaveWatchlistMovie();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      getWatchlistMovies,
      getWatchlistStatus,
      saveWatchlist,
      removeWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchlistMoviesBloc.state, Empty());
  });

  group(
    'get watchlist movies test cases',
    () {
      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistMovies()),
        expect: () => [
          Loading(),
          HasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovies.execute());
          return WatchlistMovies().props;
        },
      );
      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistMovies()),
        expect: () => [
          Loading(),
          Error('Server Failure'),
        ],
        verify: (bloc) => Loading(),
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
        expect: () => [
          HasMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(saveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
        expect: () => [
          Error('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
          HasMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveFromWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, StateRequest>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
          Error('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveFromWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}
