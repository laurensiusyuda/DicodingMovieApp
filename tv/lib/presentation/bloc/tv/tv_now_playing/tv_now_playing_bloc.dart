import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_now_playing/tv_now_playing_event.dart';
import '../../../../domain/usecases/usecases_tv/get_now_playing_tv.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingEvent, StateRequest> {
  final GetNowPlayingTv _getNowPlayingTv;

  NowPlayingTvBloc(this._getNowPlayingTv) : super(Empty()) {
    on<NowPlayingTv>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingTv.execute();
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
