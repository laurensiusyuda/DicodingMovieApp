import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_event.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingEvent, StateRequest> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(Empty()) {
    on<NowPlayingMovies>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingMovies.execute();
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
