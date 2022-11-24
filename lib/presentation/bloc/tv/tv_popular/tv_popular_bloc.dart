import 'package:bloc/bloc.dart';

import 'package:ditonton/domain/usecases/usecases_tv/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular/tv_popular_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (data) {
          emit(PopularTvLoaded(data));
        },
      );
    });
  }
}
