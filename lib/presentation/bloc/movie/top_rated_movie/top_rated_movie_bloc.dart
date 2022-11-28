import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie/top_rated_movie_event.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedEvent, StateRequest> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(Empty()) {
    on<TopRatedMovies>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedMovies.execute();
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
