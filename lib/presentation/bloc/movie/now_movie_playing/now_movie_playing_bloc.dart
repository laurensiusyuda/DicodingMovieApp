import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_event.dart';
import 'package:ditonton/presentation/bloc/movie/now_movie_playing/now_movie_playing_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (hasData) {
        emit(NowPlayingMovieLoaded(hasData));
      });
    });
  }
}
