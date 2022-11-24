import 'package:equatable/equatable.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();
  @override
  List<Object> get props => [];
}

class StateTvSeriesDetailInitial extends DetailTvSeriesState {}

class StateTvSeriesDetailLoading extends DetailTvSeriesState {}

class StateTvSeriesDetailLoaded extends DetailTvSeriesState {}

class StateWatchlistTvSeriesFailure extends DetailTvSeriesState {
  final String message;
  const StateWatchlistTvSeriesFailure(this.message);
}

class StateWatchlistTvSeriesSuccess extends DetailTvSeriesState {
  final String message;
  const StateWatchlistTvSeriesSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class StateDetailTvSeriesFailure extends DetailTvSeriesState {
  final String message;
  const StateDetailTvSeriesFailure(this.message);
  @override
  List<Object> get props => [message];
}

class StateDetailTvSeriesSuccess extends DetailTvSeriesState {
  final String message;
  const StateDetailTvSeriesSuccess(this.message);
  @override
  List<Object> get props => [message];
}
