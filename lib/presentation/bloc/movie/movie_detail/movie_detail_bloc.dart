import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail/movie_detail_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieBloc(this.getMovieDetail) : super(DetailMovieEmpty()) {
    on<FetchDetailMovieEvent>((event, emit) async {
      emit(DetailMovieLoading());
      final result = await getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(DetailMovieError(failure.message));
      }, (data) {
        emit(DetailMovieLoaded(data));
      });
    });
  }
}
