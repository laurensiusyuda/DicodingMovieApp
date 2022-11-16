import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases_tv/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail getTvDetail;

  DetailTvBloc(this.getTvDetail) : super(DetailTvEmpty()) {
    on<FetchDetailTvEvent>((event, emit) async {
      emit(DetailTvLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(DetailTvError(failure.message));
        },
        (data) {
          emit(DetailTvLoaded(data));
        },
      );
    });
  }
}
