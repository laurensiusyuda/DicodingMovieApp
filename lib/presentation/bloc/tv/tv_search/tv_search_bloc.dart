import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/usecases_tv/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv searchTv;

  SearchTvBloc(this.searchTv) : super(SearchTvEmpty()) {
    on<SearchTvSetEmpty>((event, emit) => emit(SearchTvEmpty()));
    on<OnQueryChangedTv>((event, emit) async {
      emit(SearchTvLoading());
      final result = await searchTv.execute(event.query);
      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (data) {
          emit(SearchTvLoaded(data));
        },
      );
    });
  }
}
