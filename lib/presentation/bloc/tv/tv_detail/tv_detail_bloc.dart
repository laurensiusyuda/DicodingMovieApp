import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/usecases/usecases_tv/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail/tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, StateRequest> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(Empty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(Loading());
      final detailResult = await getTvDetail.execute(event.id);
      detailResult.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (tvData) {
          emit(HasData(tvData));
        },
      );
    });
  }
}
