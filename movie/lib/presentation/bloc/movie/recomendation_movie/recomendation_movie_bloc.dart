import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:movie/domain/usecases/usecases_movie/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie/recomendation_movie/recomendation_movie_event.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, StateRequest> {
  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationBloc(this._getMovieRecommendations) : super(Empty()) {
    on<GetMovieRecommendationId>((event, emit) async {
      emit(Loading());
      final result = await _getMovieRecommendations.execute(event.id);
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
