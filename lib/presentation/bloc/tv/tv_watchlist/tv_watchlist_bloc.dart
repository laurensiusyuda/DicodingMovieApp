import 'package:bloc/bloc.dart';

import 'package:ditonton/domain/usecases/usecases_tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/usecases_tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_tv/save_watchlist.dart';

import 'package:ditonton/presentation/bloc/tv/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist/tv_watchlist_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTv getWatchlistTv;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  WatchlistTvBloc({
    required this.getWatchlistTv,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          emit(WatchlistTvLoaded(data));
        },
      );
    });

    on<FetchStatusTvEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(WatchlistTvStatusLoaded(result));
    });

    on<AddItemTvEvent>((event, emit) async {
      final tvDetail = event.result;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvSuccess(successMessage));
        },
      );
    });

    on<RemoveItemTvEvent>((event, emit) async {
      final tvDetail = event.result;
      final result = await removeWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvSuccess(successMessage));
        },
      );
    });
  }
}
