import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases_tv/get_tv_recommendations.dart';

import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recomendation/tv_recomendation_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations getTvRecommendations;

  RecommendationTvBloc(this.getTvRecommendations)
      : super(RecommendationTvEmpty()) {
    on<FetchRecommendationTvEvent>((event, emit) async {
      emit(RecommendationTvLoading());
      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendationTvError(failure.message));
        },
        (data) {
          emit(RecommendationTvLoaded(data));
        },
      );
    });
  }
}
