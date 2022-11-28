import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_event.dart';

class PopularMoviesBloc extends Bloc<PopularEvent, StateRequest> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(Empty()) {
    on<PopularMovies>((event, emit) async {
      emit(Loading());
      final result = await _getPopularMovies.execute();
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
