import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/usecases/usecases_tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated/tv_top_rated_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedEvent, StateRequest> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(Empty()) {
    on<TopRatedTv>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedTv.execute();
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
