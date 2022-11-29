import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;

  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}
