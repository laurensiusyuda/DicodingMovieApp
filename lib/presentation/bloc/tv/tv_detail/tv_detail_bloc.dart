import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

import 'package:ditonton/domain/usecases/usecases_tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/usecases_tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/usecases_tv/save_watchlist.dart';

import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail _getTvSeriesDetail;
  final GetTvRecommendations _getTvSeriesRecommendations;
  final GetWatchListStatusTv _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  late TvDetail _tvSeries;
  TvDetail get tvSeries => _tvSeries;

  List<Tv> _tvSeriesRecommendations = [];
  List<Tv> get tvSeriesRecommendations => _tvSeriesRecommendations;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  TvSeriesDetailBloc({
    required GetTvDetail getTvSeriesDetail,
    required GetTvRecommendations getTvSeriesRecommendations,
    required GetWatchListStatusTv getWatchListStatus,
    required SaveWatchlistTv saveWatchlist,
    required RemoveWatchlistTv removeWatchlist,
  })  : _getTvSeriesDetail = getTvSeriesDetail,
        _getTvSeriesRecommendations = getTvSeriesRecommendations,
        _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        super(StateTvSeriesDetailInitial()) {
    on<EventLoadDetailTvSeries>(_fetchTvSeriesDetail);
    on<EventAddWatchlist>(_addWatchlist);
    on<EventRemoveWatchlist>(_removeFromWatchlist);
  }

  void _fetchTvSeriesDetail(
    EventLoadDetailTvSeries event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    emit(StateTvSeriesDetailInitial());
    final detailResult = await _getTvSeriesDetail.execute(event.id);
    final recommendationResult =
        await _getTvSeriesRecommendations.execute(event.id);
    final statusResult = await _getWatchListStatus.execute(event.id);
    _isAddedToWatchlist = statusResult;
    detailResult.fold(
      (failure) {
        emit(StateDetailTvSeriesFailure(failure.message));
      },
      (tvSerie) {
        _tvSeries = tvSerie;
        recommendationResult.fold(
          (failure) {
            emit(StateDetailTvSeriesFailure(failure.message));
          },
          (tvSeries) {
            _tvSeriesRecommendations = tvSeries;
          },
        );
        emit(StateTvSeriesDetailLoaded());
      },
    );
  }

  void _addWatchlist(
    EventAddWatchlist event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    emit(StateTvSeriesDetailLoading());
    final result = await _saveWatchlist.execute(event.tvSeries);

    await result.fold(
      (failure) async {
        emit(StateWatchlistTvSeriesFailure(failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = true;
        emit(StateWatchlistTvSeriesSuccess(successMessage));
      },
    );
  }

  void _removeFromWatchlist(
    EventRemoveWatchlist event,
    Emitter<DetailTvSeriesState> emit,
  ) async {
    emit(StateTvSeriesDetailLoading());
    final result = await _removeWatchlist.execute(event.tvSeries);

    await result.fold(
      (failure) async {
        emit(StateWatchlistTvSeriesFailure(failure.message));
      },
      (successMessage) async {
        _isAddedToWatchlist = false;
        emit(StateWatchlistTvSeriesSuccess(successMessage));
      },
    );
  }
}
