import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_tv_recommendations.dart';

import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_event.dart';

class TvRecommendationBloc extends Bloc<TvRecommendationEvent, StateRequest> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationBloc(this._getTvRecommendations) : super(Empty()) {
    on<GetTvRecommendationId>((event, emit) async {
      emit(Loading());
      final result = await _getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (movieData) {
          emit(HasData(movieData));
        },
      );
    });
  }
}
