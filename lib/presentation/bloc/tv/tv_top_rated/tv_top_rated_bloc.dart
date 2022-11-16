import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases_tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<TopRatedTvEvent>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) {
          emit(TopRatedTvError(failure.message));
        },
        (data) {
          emit(TopRatedTvLoaded(data));
        },
      );
    });
  }
}
