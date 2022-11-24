import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (data) {
          emit(TopRatedMovieLoaded(data));
        },
      );
    });
  }
}
