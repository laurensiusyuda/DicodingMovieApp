import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/usecases_movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_movie/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  String watchlistAddSuccessMessage = 'Added to Watchlist';
  String watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  MovieDetailBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieRecommendations getMovieRecommendations,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  })  : _getMovieDetail = getMovieDetail,
        _getMovieRecommendations = getMovieRecommendations,
        _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        super(StateMovieDetailInitial()) {
    on<EventLoadDetailMovie>(_fetchMovieDetail);
    on<EventAddWatchlist>(_addWatchlist);
    on<EventRemoveWatchlist>(_removeFromWatchlist);
  }

  void _fetchMovieDetail(
    EventLoadDetailMovie event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(StateMovieDetailInitial());
    final detailResult = await _getMovieDetail.execute(event.id);
    final recommendationResult =
        await _getMovieRecommendations.execute(event.id);
    final statusResult = await _getWatchListStatus.execute(event.id);
    _isAddedToWatchlist = statusResult;
    detailResult.fold(
      (failure) {
        emit(StateLoadDetailMovieFailure(message: failure.message));
      },
      (movie) {
        _movie = movie;
        recommendationResult.fold(
          (failure) {
            emit(StateLoadMovieRecommendationFailure(message: failure.message));
          },
          (movies) {
            _movieRecommendations = movies;
          },
        );
        emit(StateMovieDetailLoaded());
      },
    );
  }

  void _addWatchlist(
    EventAddWatchlist event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(StateMovieDetailLoading());
    final result = await _saveWatchlist.execute(event.movie);
    await result.fold(
      (failure) async {
        emit(StateWatchlistFailure(failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = true;
        emit(StateWatchlistSuccess(successMessage));
      },
    );
  }

  void _removeFromWatchlist(
    EventRemoveWatchlist event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(StateMovieDetailLoading());
    final result = await _removeWatchlist.execute(event.movie);

    await result.fold(
      (failure) async {
        emit(StateWatchlistFailure(failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = false;
        emit(StateWatchlistSuccess(successMessage));
      },
    );
  }
}
