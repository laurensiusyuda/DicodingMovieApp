import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_now_playing_tv.dart';

import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_now_playing/tv_now_playing_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvBloc(this.getOnTheAirTv) : super(OnTheAirTvEmpty()) {
    on<FetchOnTheAirTvEvent>((event, emit) async {
      emit(OnTheAirTvLoading());
      final result = await getOnTheAirTv.execute();
      result.fold(
        (failure) {
          emit(OnTheAirTvError(failure.message));
        },
        (data) {
          emit(OnTheAirTvLoaded(data));
        },
      );
    });
  }
}
