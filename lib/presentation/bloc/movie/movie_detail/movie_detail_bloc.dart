import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/usecases_movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, StateRequest> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc(this.getMovieDetail) : super(Empty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(Loading());
      final detailResult = await getMovieDetail.execute(event.id);

      detailResult.fold(
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
