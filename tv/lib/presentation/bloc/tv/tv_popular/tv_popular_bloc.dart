import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/tv/tv_popular/tv_popular_event.dart';

import '../../../../domain/usecases/usecases_tv/get_popular_tv.dart';

class PopularTvBloc extends Bloc<PopularEvent, StateRequest> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(Empty()) {
    on<PopularTv>((event, emit) async {
      emit(Loading());
      final result = await _getPopularTv.execute();
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
