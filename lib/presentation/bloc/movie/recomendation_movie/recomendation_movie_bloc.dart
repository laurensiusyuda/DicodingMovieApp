import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation_movie/recomendation_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation_movie/recomendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationMovieBloc(this.getMovieRecommendations)
      : super(RecommendationMovieEmpty()) {
    on<FetchRecommendationMovieEvent>((event, emit) async {
      emit(RecommendationMovieLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendationMovieError(failure.message));
        },
        (data) {
          emit(RecommendationMovieLoaded(data));
        },
      );
    });
  }
}
