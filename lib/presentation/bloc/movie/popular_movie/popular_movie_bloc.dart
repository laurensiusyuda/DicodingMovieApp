import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(
    this.getPopularMovies,
  ) : super(PopularMovieEmpty()) {
    on<FetchPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(PopularMovieError(failure.message));
        },
        (data) {
          emit(PopularMovieLoaded(data));
        },
      );
    });
  }
}
