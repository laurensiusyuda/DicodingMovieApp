import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/usecases_movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie/watchlist_movie_event.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistEvent, StateRequest> {
  final GetWatchListStatusMovie _getWatchListStatusMovie;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies, this._getWatchListStatusMovie,
      this._saveWatchlistMovie, this._removeWatchlistMovie)
      : super(Empty()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      emit(Loading());
      final result = await _getWatchListStatusMovie.execute(id);
      emit(HasStatus(result));
    });

    on<AddWatchlist>((event, emit) async {
      final movie = event.movieDetailEntity;

      final result = await _saveWatchlistMovie.execute(movie);

      result.fold((failure) {
        emit(Error(failure.message));
      }, (message) {
        emit(HasMessage(message));
      });
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final movie = event.movieDetailEntity;

      final result = await _removeWatchlistMovie.execute(movie);

      result.fold((failure) {
        emit(Error(failure.message));
      }, (message) {
        emit(HasMessage(message));
      });
    });

    on<WatchlistMovies>((event, emit) async {
      emit(Loading());
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(HasData(data));
        },
      );
    });
  }
}
